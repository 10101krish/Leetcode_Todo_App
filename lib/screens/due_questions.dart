import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:leetcode_todo_app/provider/due_questions_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Question> dueQuestions = ref.watch(dueQuestionsProvider);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: dueQuestions.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(dueQuestions[index].id),
                onDismissed: (direction) {},
                child: QuestionBig(
                  question: dueQuestions[index],
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
