import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/database/database.dart';
import 'package:leetcode_todo_app/models/question.dart';

class DueQuestionsNotifier extends StateNotifier<List<Question>> {
  // DueQuestionsNotifier(List<Question> questions) : super(questions);
  DueQuestionsNotifier() : super(const []);

  Future<void> loadQuestions() async {
    final List<Question> questions = await loadDueQuestions();
    state = questions;
  }
}

final dueQuestionsProvider =
    StateNotifierProvider<DueQuestionsNotifier, List<Question>>((ref) {
  return DueQuestionsNotifier();
});
