import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/database/database.dart';
import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:leetcode_todo_app/provider/due_questions_provider.dart';
import 'package:leetcode_todo_app/screens/new_question.dart';
import 'package:leetcode_todo_app/screens/question_dismissed_dailog.dart';
import 'package:leetcode_todo_app/widgets/question_big.dart';

class DueQuestionsScreen extends ConsumerStatefulWidget {
  const DueQuestionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DueQuestionsScreenState();
  }
}

class _DueQuestionsScreenState extends ConsumerState<DueQuestionsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(dueQuestionsProvider.notifier).loadQuestions();
  }

  Widget confirmIcon() {
    return const Icon(
      Icons.check,
      color: Colors.white,
      size: 40,
    );
  }

  void reloadDueQuestions() {
    ref.read(dueQuestionsProvider.notifier).loadQuestions();
  }

  void addNewQuestion() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewQuestionScreen(),
      ),
    );
    reloadDueQuestions();
  }

  Future<bool> questionDismissed({
    required Question question,
  }) async {
    ConfidenceLevel? dialogResponse = await showDialog<ConfidenceLevel>(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return QuestionDismissedDialog(
          question: question,
        );
      },
    );
    if (dialogResponse != null) {
      updateConfidence(
        question: question,
        newConfidenceLevel: dialogResponse,
      );
      reloadDueQuestions();
      return true;
    }
    return false;
  }

  Widget dismissablePrimaryBackground() {
    return Container(
      color: Colors.green.shade500,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: confirmIcon(),
    );
  }

  Widget dismissableSecondaryBackground() {
    return Container(
      color: Colors.green.shade500,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerRight,
      child: confirmIcon(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Question> dueQuestions = ref.watch(dueQuestionsProvider);

    Widget content = Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
          ),
          SizedBox(height: 25),
          Text(
            'No questions availabe to display here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Try adding some questions through the add question button in the task bar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );

    if (dueQuestions.isNotEmpty) {
      content = Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dueQuestions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  clipBehavior: Clip.hardEdge,
                  child: Dismissible(
                    key: ValueKey(dueQuestions[index].id),
                    background: dismissablePrimaryBackground(),
                    secondaryBackground: dismissableSecondaryBackground(),
                    child: QuestionBig(
                      question: dueQuestions[index],
                      index: index,
                    ),
                    confirmDismiss: (direction) async {
                      return await questionDismissed(
                        question: dueQuestions[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Due Questions'),
        actions: [
          IconButton(
            onPressed: reloadDueQuestions,
            icon: const Icon(Icons.replay_outlined),
            tooltip: 'Reload questions',
          ),
          IconButton(
            onPressed: addNewQuestion,
            icon: const Icon(Icons.add),
            tooltip: 'Add new question',
          ),
        ],
      ),
      body: content,
    );
  }
}
