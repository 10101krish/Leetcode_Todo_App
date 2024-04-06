import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/database/database.dart';
import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:leetcode_todo_app/provider/due_questions_provider.dart';
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
      ref.read(dueQuestionsProvider.notifier).loadQuestions();
      return true;
    }
    return false;
  }

  Widget confirmIcon() {
    return const Icon(
      Icons.check,
      color: Colors.white,
      size: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Question> dueQuestions = ref.watch(dueQuestionsProvider);
    return Column(
      children: [
        TextButton(
          onPressed: () =>
              ref.read(dueQuestionsProvider.notifier).loadQuestions(),
          child: const Text(
            'Reload',
            style: TextStyle(
              fontSize: 17.5,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: dueQuestions.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.hardEdge,
                child: Dismissible(
                  key: ValueKey(dueQuestions[index].id),
                  background: Container(
                    color: Colors.green.shade500,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        confirmIcon(),
                        confirmIcon(),
                      ],
                    ),
                  ),
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
}
