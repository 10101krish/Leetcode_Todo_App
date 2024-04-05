import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/database/database.dart';
import 'package:leetcode_todo_app/models/question.dart';

class QuestionsNotifier extends StateNotifier<List<Question>> {
  QuestionsNotifier() : super([]);

  void addQuestion(Question question) async {
    addNewQuestion(
      question: question,
    );
    state = [...state, question];
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsNotifier, List<Question>>((ref) {
  return QuestionsNotifier();
});
