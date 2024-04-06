import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

void _createDb(Database db, int newVersion) async {
  await db.execute('''CREATE TABLE questions (
        id TEXT PRIMARY KEY UNIQUE, 
        url TEXT UNIQUE, 
        title TEXT UNIQUE, 
        description TEXT, 
        difficulty TEXT);''');
  await db.execute('''CREATE TABLE confidence (
        id TEXT PRIMARY KEY UNIQUE, 
        confidence TEXT);''');
  await db.execute('''CREATE TABLE duedate (
        id TEXT PRIMARY KEY UNIQUE, 
        due TEXT);''');
  return;
}

Future<Database> _getQuestionsDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'questionsDataBase.db'),
    onCreate: (db, version) => _createDb(
      db,
      version,
    ),
    version: 1,
  );
  return db;
}

void updateConfidence({
  required Question question,
  required ConfidenceLevel newConfidenceLevel,
}) async {
  final sql.Database db = await _getQuestionsDatabase();
  if (newConfidenceLevel == ConfidenceLevel.expierienced) {
    await db.execute("""DELETE FROM duedate WHERE id = ?""", [
      question.id,
    ]);
    await db.execute("""DELETE FROM confidence WHERE id = ?""", [
      question.id,
    ]);
    await db.execute("""DELETE FROM questions WHERE id = ?""", [
      question.id,
    ]);
  } else {
    await db.execute("""UPDATE confidence
      SET confidence = ?
      WHERE id = ?""", [
      newConfidenceLevel.name,
      question.id,
    ]);
    final dueDate = DateTime.now()
        .add(Duration(days: dueDelay[newConfidenceLevel]!))
        .toIso8601String()
        .substring(0, 10);
    await db.execute("""UPDATE duedate
      SET due = ?
      WHERE id = ?""", [
      dueDate,
      question.id,
    ]);
  }
}

void addNewQuestion({
  required Question question,
}) async {
  final dueDate = DateTime.now()
      .add(Duration(days: dueDelay[question.confidence]!))
      .toIso8601String()
      .substring(0, 10);
  final sql.Database db = await _getQuestionsDatabase();

  db.insert('questions', {
    'id': question.id,
    'url': question.url,
    'title': question.title,
    'description': question.description,
    'difficulty': question.difficulty,
  });
  db.insert('confidence', {
    'id': question.id,
    'confidence': question.confidence.name,
  });
  db.insert('duedate', {
    'id': question.id,
    'due': dueDate,
  });
}

Future<List<Question>> loadDueQuestions() async {
  final today = DateTime.now().toIso8601String().substring(0, 10);
  final questiondb = await _getQuestionsDatabase();
  final data = await questiondb.rawQuery("""SELECT * FROM questions
      INNER JOIN confidence
      ON questions.id = confidence.id
      INNER JOIN duedate
      ON questions.id = duedate.id
      WHERE duedate.due < ?
      """, [today]);
  final questions = data.map((row) {
    return Question(
      id: row['id'] as String,
      url: row['url'] as String,
      title: row['title'] as String,
      description: row['description'] as String,
      difficulty: row['difficulty'] as String,
      confidence: mapConfidence[row['confidence'] as String] as ConfidenceLevel,
    );
  }).toList();
  return questions;
}
