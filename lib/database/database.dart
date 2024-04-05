import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

void _createDb(Database db, int newVersion) async {
  await db.execute('''CREATE TABLE questions (
        id TEXT PRIMARY KEY UNIQUE, 
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

void addNewQuestion({
  required Question question,
}) async {
  final dueDate = DateTime.now()
      .add(Duration(days: -1 * dueDelay[question.confidence]!))
      .toIso8601String()
      .substring(0, 10);
  // print(dueDate);
  final sql.Database db = await _getQuestionsDatabase();

  db.insert('questions', {
    'id': question.id,
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
      title: row['title'] as String,
      description: row['description'] as String,
      difficulty: row['difficulty'] as String,
      confidence: mapConfidence[row['confidence'] as String] as ConfidenceLevel,
    );
  }).toList();
  return questions;
}
