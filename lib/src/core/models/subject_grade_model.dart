class SubjectGrade {
  final String subjectName;
  final String grade; // A+, A, A-, B+, B, C+, etc.
  final double gpa; // 4.00, 3.75, 3.50, etc.
  final String category; // Data Structures, Web, AI, Database, Architecture

  const SubjectGrade({
    required this.subjectName,
    required this.grade,
    required this.gpa,
    required this.category,
  });
}

class TechStackRecommendation {
  final String careerPathTitle;
  final int suitabilityScore; // 0 - 100%
  final List<String> primaryTechStack;
  final List<String> complementaryTools;
  final String aiReasoningText;
  final List<String> strongestSubjects;

  const TechStackRecommendation({
    required this.careerPathTitle,
    required this.suitabilityScore,
    required this.primaryTechStack,
    required this.complementaryTools,
    required this.aiReasoningText,
    required this.strongestSubjects,
  });
}
