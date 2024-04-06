import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/screens/due_questions.dart';

void main() {
  runApp(const ProviderScope(
    child: MaterialApp(
      home: DueQuestionsScreen(),
    ),
  ));
}
