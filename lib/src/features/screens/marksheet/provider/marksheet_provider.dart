import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/semester_marksheet_model.dart';
import '../../../../core/services/database_helper.dart';

class MarksheetState {
  final String selectedSemester;
  final List<String> availableSemesters;
  final Map<String, List<CourseMark>> semesterCourses;
  final bool isLoading;

  const MarksheetState({
    required this.selectedSemester,
    required this.availableSemesters,
    required this.semesterCourses,
    required this.isLoading,
  });

  List<CourseMark> get currentCourses => semesterCourses[selectedSemester] ?? [];

  double get currentSGPA {
    final courses = currentCourses;
    if (courses.isEmpty) return 0.0;
    double totalPoints = 0.0;
    int totalCredits = 0;
    for (var c in courses) {
      totalPoints += (c.gradePoint * c.creditHours);
      totalCredits += c.creditHours;
    }
    return totalCredits > 0 ? (totalPoints / totalCredits) : 0.0;
  }

  int get currentCredits {
    final courses = currentCourses;
    return courses.fold(0, (sum, c) => sum + c.creditHours);
  }

  double get cumulativeCGPA {
    int totalCredits = 0;
    double totalPoints = 0.0;
    for (var entry in semesterCourses.entries) {
      for (var c in entry.value) {
        totalPoints += (c.gradePoint * c.creditHours);
        totalCredits += c.creditHours;
      }
    }
    return totalCredits > 0 ? (totalPoints / totalCredits) : 3.82;
  }

  MarksheetState copyWith({
    String? selectedSemester,
    List<String>? availableSemesters,
    Map<String, List<CourseMark>>? semesterCourses,
    bool? isLoading,
  }) {
    return MarksheetState(
      selectedSemester: selectedSemester ?? this.selectedSemester,
      availableSemesters: availableSemesters ?? this.availableSemesters,
      semesterCourses: semesterCourses ?? this.semesterCourses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MarksheetNotifier extends Notifier<MarksheetState> {
  @override
  MarksheetState build() {
    _loadFromSQLite();

    return const MarksheetState(
      selectedSemester: "7th Semester",
      availableSemesters: [
        "1st Semester",
        "2nd Semester",
        "3rd Semester",
        "4th Semester",
        "5th Semester",
        "6th Semester",
        "7th Semester",
        "8th Semester",
      ],
      semesterCourses: {
        "7th Semester": [
          CourseMark(
            courseCode: "CSE-701",
            courseTitle: "Mobile Application Development with Flutter",
            creditHours: 3,
            midtermMarks: 27.5,
            finalMarks: 46.0,
            quizAssignmentMarks: 19.0,
            totalMarks: 92.5,
            letterGrade: "A+",
            gradePoint: 4.00,
          ),
          CourseMark(
            courseCode: "CSE-702",
            courseTitle: "Artificial Intelligence & Neural Networks",
            creditHours: 3,
            midtermMarks: 24.0,
            finalMarks: 42.5,
            quizAssignmentMarks: 18.0,
            totalMarks: 84.5,
            letterGrade: "A",
            gradePoint: 3.75,
          ),
          CourseMark(
            courseCode: "CSE-703",
            courseTitle: "Cloud Computing & Distributed Systems",
            creditHours: 3,
            midtermMarks: 23.0,
            finalMarks: 40.0,
            quizAssignmentMarks: 17.5,
            totalMarks: 80.5,
            letterGrade: "A-",
            gradePoint: 3.50,
          ),
        ],
        "6th Semester": [
          CourseMark(
            courseCode: "CSE-601",
            courseTitle: "Database Management Systems & SQL",
            creditHours: 3,
            midtermMarks: 26.0,
            finalMarks: 44.0,
            quizAssignmentMarks: 18.5,
            totalMarks: 88.5,
            letterGrade: "A+",
            gradePoint: 4.00,
          ),
          CourseMark(
            courseCode: "CSE-602",
            courseTitle: "Software Engineering & Clean Architecture",
            creditHours: 3,
            midtermMarks: 25.0,
            finalMarks: 43.0,
            quizAssignmentMarks: 18.0,
            totalMarks: 86.0,
            letterGrade: "A+",
            gradePoint: 4.00,
          ),
        ],
      },
      isLoading: false,
    );
  }

  Future<void> _loadFromSQLite() async {
    try {
      final dbData = await DatabaseHelper.instance.getAllSemesterCourses();
      if (dbData.isNotEmpty) {
        final Map<String, List<CourseMark>> merged = Map.from(state.semesterCourses);
        for (var entry in dbData.entries) {
          merged[entry.key] = entry.value;
        }
        state = state.copyWith(semesterCourses: merged);
      }
    } catch (e) {
      debugPrint("SQLite load semester courses warning: $e");
    }
  }

  void selectSemester(String semesterName) {
    state = state.copyWith(selectedSemester: semesterName);
  }

  Future<void> addCourseMark(String semesterName, CourseMark course) async {
    await DatabaseHelper.instance.insertCourseMark(semesterName, course);
    final Map<String, List<CourseMark>> updated = Map.from(state.semesterCourses);
    if (!updated.containsKey(semesterName)) {
      updated[semesterName] = [];
    }
    updated[semesterName] = [...updated[semesterName]!, course];
    state = state.copyWith(semesterCourses: updated);
  }

  Future<void> removeCourseMark(String semesterName, String courseCode) async {
    await DatabaseHelper.instance.deleteCourseMark(semesterName, courseCode);
    final Map<String, List<CourseMark>> updated = Map.from(state.semesterCourses);
    if (updated.containsKey(semesterName)) {
      updated[semesterName] = List<CourseMark>.from(updated[semesterName]!)
        ..removeWhere((c) => c.courseCode == courseCode);
      state = state.copyWith(semesterCourses: updated);
    }
  }
}

final marksheetProvider = NotifierProvider<MarksheetNotifier, MarksheetState>(MarksheetNotifier.new);
