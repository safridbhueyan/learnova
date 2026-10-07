import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../core/models/semester_marksheet_model.dart';
import '../../core/models/subject_grade_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('learnova_academic.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(
        path,
        version: 2,
        onCreate: _createDB,
        onUpgrade: _onUpgradeDB,
      );
    } catch (e) {
      debugPrint("SQLite initialization error fallback: $e");
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE academic_marks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subjectName TEXT NOT NULL,
        grade TEXT NOT NULL,
        gpa REAL NOT NULL,
        category TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE scanned_marksheets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT NOT NULL,
        scanDate TEXT NOT NULL,
        extractedText TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE semester_courses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        semesterName TEXT NOT NULL,
        courseCode TEXT NOT NULL,
        courseTitle TEXT NOT NULL,
        creditHours INTEGER NOT NULL,
        midtermMarks REAL NOT NULL,
        finalMarks REAL NOT NULL,
        quizAssignmentMarks REAL NOT NULL,
        totalMarks REAL NOT NULL,
        letterGrade TEXT NOT NULL,
        gradePoint REAL NOT NULL
      )
    ''');

    // Pre-populate initial sample records
    final initialSubjects = [
      const SubjectGrade(subjectName: "Data Structures & Algorithms", grade: "A+", gpa: 4.00, category: "Algorithms"),
      const SubjectGrade(subjectName: "Object-Oriented Programming (Dart/Java)", grade: "A+", gpa: 4.00, category: "Software Eng"),
      const SubjectGrade(subjectName: "Mobile Application Development", grade: "A", gpa: 3.75, category: "Mobile Dev"),
      const SubjectGrade(subjectName: "Database Management Systems", grade: "A-", gpa: 3.50, category: "Database"),
      const SubjectGrade(subjectName: "Artificial Intelligence & Neural Nets", grade: "B+", gpa: 3.25, category: "AI & ML"),
    ];

    for (var sub in initialSubjects) {
      await db.insert('academic_marks', {
        'subjectName': sub.subjectName,
        'grade': sub.grade,
        'gpa': sub.gpa,
        'category': sub.category,
        'createdAt': DateTime.now().toIso8601String(),
      });
    }

    // Pre-populate initial semester courses
    final sampleSemesterCourses = [
      {
        'semesterName': '7th Semester',
        'courseCode': 'CSE-701',
        'courseTitle': 'Mobile Application Development with Flutter',
        'creditHours': 3,
        'midtermMarks': 27.5,
        'finalMarks': 46.0,
        'quizAssignmentMarks': 19.0,
        'totalMarks': 92.5,
        'letterGrade': 'A+',
        'gradePoint': 4.00,
      },
      {
        'semesterName': '7th Semester',
        'courseCode': 'CSE-702',
        'courseTitle': 'Artificial Intelligence & Machine Learning',
        'creditHours': 3,
        'midtermMarks': 24.0,
        'finalMarks': 42.5,
        'quizAssignmentMarks': 18.0,
        'totalMarks': 84.5,
        'letterGrade': 'A',
        'gradePoint': 3.75,
      },
      {
        'semesterName': '7th Semester',
        'courseCode': 'CSE-703',
        'courseTitle': 'Cloud Computing & Distributed Systems',
        'creditHours': 3,
        'midtermMarks': 23.0,
        'finalMarks': 40.0,
        'quizAssignmentMarks': 17.5,
        'totalMarks': 80.5,
        'letterGrade': 'A-',
        'gradePoint': 3.50,
      },
      {
        'semesterName': '6th Semester',
        'courseCode': 'CSE-601',
        'courseTitle': 'Database Systems & SQL Optimization',
        'creditHours': 3,
        'midtermMarks': 26.0,
        'finalMarks': 44.0,
        'quizAssignmentMarks': 18.5,
        'totalMarks': 88.5,
        'letterGrade': 'A+',
        'gradePoint': 4.00,
      },
      {
        'semesterName': '6th Semester',
        'courseCode': 'CSE-602',
        'courseTitle': 'Software Engineering & Clean Architecture',
        'creditHours': 3,
        'midtermMarks': 25.0,
        'finalMarks': 43.0,
        'quizAssignmentMarks': 18.0,
        'totalMarks': 86.0,
        'letterGrade': 'A+',
        'gradePoint': 4.00,
      },
    ];

    for (var course in sampleSemesterCourses) {
      await db.insert('semester_courses', course);
    }
  }

  Future<void> _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS semester_courses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          semesterName TEXT NOT NULL,
          courseCode TEXT NOT NULL,
          courseTitle TEXT NOT NULL,
          creditHours INTEGER NOT NULL,
          midtermMarks REAL NOT NULL,
          finalMarks REAL NOT NULL,
          quizAssignmentMarks REAL NOT NULL,
          totalMarks REAL NOT NULL,
          letterGrade TEXT NOT NULL,
          gradePoint REAL NOT NULL
        )
      ''');
    }
  }

  Future<int> insertSubjectGrade(SubjectGrade subject) async {
    try {
      final db = await instance.database;
      return await db.insert('academic_marks', {
        'subjectName': subject.subjectName,
        'grade': subject.grade,
        'gpa': subject.gpa,
        'category': subject.category,
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint("SQLite insert error: $e");
      return -1;
    }
  }

  Future<List<SubjectGrade>> getAcademicMarks() async {
    try {
      final db = await instance.database;
      final maps = await db.query('academic_marks', orderBy: 'id DESC');

      if (maps.isEmpty) return [];

      return List.generate(maps.length, (i) {
        return SubjectGrade(
          subjectName: maps[i]['subjectName'] as String,
          grade: maps[i]['grade'] as String,
          gpa: (maps[i]['gpa'] as num).toDouble(),
          category: maps[i]['category'] as String,
        );
      });
    } catch (e) {
      debugPrint("SQLite fetch error: $e");
      return [];
    }
  }

  Future<int> deleteSubjectByName(String name) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'academic_marks',
        where: 'subjectName = ?',
        whereArgs: [name],
      );
    } catch (e) {
      debugPrint("SQLite delete error: $e");
      return 0;
    }
  }

  Future<int> insertCourseMark(String semesterName, CourseMark course) async {
    try {
      final db = await instance.database;
      return await db.insert('semester_courses', course.toMap(semesterName));
    } catch (e) {
      debugPrint("SQLite semester course insert error: $e");
      return -1;
    }
  }

  Future<List<CourseMark>> getSemesterCourses(String semesterName) async {
    try {
      final db = await instance.database;
      final maps = await db.query(
        'semester_courses',
        where: 'semesterName = ?',
        whereArgs: [semesterName],
        orderBy: 'id ASC',
      );

      return List.generate(maps.length, (i) => CourseMark.fromMap(maps[i]));
    } catch (e) {
      debugPrint("SQLite getSemesterCourses error: $e");
      return [];
    }
  }

  Future<Map<String, List<CourseMark>>> getAllSemesterCourses() async {
    try {
      final db = await instance.database;
      final maps = await db.query('semester_courses', orderBy: 'id ASC');

      Map<String, List<CourseMark>> result = {};
      for (var map in maps) {
        final sem = map['semesterName'] as String;
        final course = CourseMark.fromMap(map);
        if (!result.containsKey(sem)) {
          result[sem] = [];
        }
        result[sem]!.add(course);
      }
      return result;
    } catch (e) {
      debugPrint("SQLite getAllSemesterCourses error: $e");
      return {};
    }
  }

  Future<int> deleteCourseMark(String semesterName, String courseCode) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'semester_courses',
        where: 'semesterName = ? AND courseCode = ?',
        whereArgs: [semesterName, courseCode],
      );
    } catch (e) {
      debugPrint("SQLite deleteCourseMark error: $e");
      return 0;
    }
  }

  Future<int> insertMarksheetScan(String imagePath, String extractedText) async {
    try {
      final db = await instance.database;
      return await db.insert('scanned_marksheets', {
        'imagePath': imagePath,
        'scanDate': DateTime.now().toIso8601String(),
        'extractedText': extractedText,
      });
    } catch (e) {
      debugPrint("SQLite marksheet insert error: $e");
      return -1;
    }
  }
}
