import 'package:flutter/material.dart';
import 'package:leetcode_todo_app/models/confidence.dart';

class Question {
  const Question({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.confidence,
  });

  final String id;
  final String url;
  final String title;
  final String description;
  final String difficulty;
  final ConfidenceLevel confidence;
}

Map<String, Color> difficultyColor = {
  'Easy': Colors.green.shade900,
  'Medium': Colors.yellow.shade900,
  'Hard': Colors.redAccent.shade700,
};
