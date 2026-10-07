class CourseMark {
  final String courseCode;
  final String courseTitle;
  final int creditHours;
  final double midtermMarks;
  final double finalMarks;
  final double quizAssignmentMarks;
  final double totalMarks;
  final String letterGrade;
  final double gradePoint;

  const CourseMark({
    required this.courseCode,
    required this.courseTitle,
    required this.creditHours,
    required this.midtermMarks,
    required this.finalMarks,
    required this.quizAssignmentMarks,
    required this.totalMarks,
    required this.letterGrade,
    required this.gradePoint,
  });

  Map<String, dynamic> toMap(String semesterName) {
    return {
      'semesterName': semesterName,
      'courseCode': courseCode,
      'courseTitle': courseTitle,
      'creditHours': creditHours,
      'midtermMarks': midtermMarks,
      'finalMarks': finalMarks,
      'quizAssignmentMarks': quizAssignmentMarks,
      'totalMarks': totalMarks,
      'letterGrade': letterGrade,
      'gradePoint': gradePoint,
    };
  }

  factory CourseMark.fromMap(Map<String, dynamic> map) {
    return CourseMark(
      courseCode: map['courseCode'] ?? 'CSE-101',
      courseTitle: map['courseTitle'] ?? 'General Computer Science',
      creditHours: map['creditHours'] ?? 3,
      midtermMarks: (map['midtermMarks'] as num?)?.toDouble() ?? 25.0,
      finalMarks: (map['finalMarks'] as num?)?.toDouble() ?? 42.0,
      quizAssignmentMarks: (map['quizAssignmentMarks'] as num?)?.toDouble() ?? 18.0,
      totalMarks: (map['totalMarks'] as num?)?.toDouble() ?? 85.0,
      letterGrade: map['letterGrade'] ?? 'A+',
      gradePoint: (map['gradePoint'] as num?)?.toDouble() ?? 4.00,
    );
  }
}

class SemesterMarksheet {
  final String semesterName;
  final double sgpa;
  final int totalCredits;
  final List<CourseMark> courses;
  final String? scannedImagePath;

  const SemesterMarksheet({
    required this.semesterName,
    required this.sgpa,
    required this.totalCredits,
    required this.courses,
    this.scannedImagePath,
  });

  SemesterMarksheet copyWith({
    String? semesterName,
    double? sgpa,
    int? totalCredits,
    List<CourseMark>? courses,
    String? scannedImagePath,
  }) {
    return SemesterMarksheet(
      semesterName: semesterName ?? this.semesterName,
      sgpa: sgpa ?? this.sgpa,
      totalCredits: totalCredits ?? this.totalCredits,
      courses: courses ?? this.courses,
      scannedImagePath: scannedImagePath ?? this.scannedImagePath,
    );
  }
}
