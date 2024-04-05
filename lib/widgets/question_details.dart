import 'package:flutter/material.dart';
import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';

class QuestionDetails extends StatelessWidget {
  const QuestionDetails({
    super.key,
    required this.question,
  });

  final Question question;

  TextStyle headingTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
  }

  TextStyle informationTextStyle() {
    return const TextStyle(
      fontSize: 15,
    );
  }

  String formatConfidenceText(String rawConfidenceText) {
    return rawConfidenceText[0].toUpperCase() + rawConfidenceText.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(question.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.5,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question Description',
                style: headingTextStyle(),
              ),
              const SizedBox(height: 10),
              Text(
                question.description,
                style: informationTextStyle(),
              ),
              const SizedBox(height: 20),
              Text(
                'Question Difficulty',
                style: headingTextStyle(),
              ),
              const SizedBox(height: 10),
              Text(
                question.difficulty,
                style: informationTextStyle().copyWith(
                  color: difficultyColor[question.difficulty],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Question Confidence Level',
                style: headingTextStyle(),
              ),
              const SizedBox(height: 10),
              Text(
                formatConfidenceText(question.confidence.name),
                style: informationTextStyle().copyWith(
                  color: confidenceColor(question.confidence),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
