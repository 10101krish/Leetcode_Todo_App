import 'package:flutter/material.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:leetcode_todo_app/widgets/question_details.dart';

class QuestionBig extends StatelessWidget {
  const QuestionBig({
    super.key,
    required this.question,
    required this.index,
  });

  final Question question;
  final int index;

  String formatConfidenceText(String rawConfidenceText) {
    return rawConfidenceText[0].toUpperCase() + rawConfidenceText.substring(1);
  }

  void expandQuestion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return QuestionDetails(
            question: question,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        tileColor: Colors.grey.shade100,
        splashColor: difficultyColor[question.difficulty]!.withOpacity(0.75),
        selectedColor: difficultyColor[question.difficulty]!.withOpacity(0.25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onTap: () => expandQuestion(context),
        leading: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(question.title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17.5,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text(question.difficulty),
        subtitleTextStyle: TextStyle(
          color: difficultyColor[question.difficulty],
        ),
      ),
    );
  }
}
