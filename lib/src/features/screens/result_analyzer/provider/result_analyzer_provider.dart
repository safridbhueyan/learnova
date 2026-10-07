import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/subject_grade_model.dart';

class ResultAnalyzerState {
  final List<SubjectGrade> subjects;
  final bool isPhotoScanning;
  final String? scannedPhotoName;
  final List<TechStackRecommendation> recommendations;

  const ResultAnalyzerState({
    required this.subjects,
    required this.isPhotoScanning,
    this.scannedPhotoName,
    required this.recommendations,
  });

  ResultAnalyzerState copyWith({
    List<SubjectGrade>? subjects,
    bool? isPhotoScanning,
    String? scannedPhotoName,
    List<TechStackRecommendation>? recommendations,
  }) {
    return ResultAnalyzerState(
      subjects: subjects ?? this.subjects,
      isPhotoScanning: isPhotoScanning ?? this.isPhotoScanning,
      scannedPhotoName: scannedPhotoName ?? this.scannedPhotoName,
      recommendations: recommendations ?? this.recommendations,
    );
  }
}

class ResultAnalyzerNotifier extends Notifier<ResultAnalyzerState> {
  @override
  ResultAnalyzerState build() {
    return const ResultAnalyzerState(
      isPhotoScanning: false,
      scannedPhotoName: null,
      subjects: [
        SubjectGrade(subjectName: "Data Structures & Algorithms", grade: "A+", gpa: 4.00, category: "Algorithms"),
        SubjectGrade(subjectName: "Object-Oriented Programming (Dart/Java)", grade: "A+", gpa: 4.00, category: "Software Eng"),
        SubjectGrade(subjectName: "Mobile Application Development", grade: "A", gpa: 3.75, category: "Mobile Dev"),
        SubjectGrade(subjectName: "Database Management Systems", grade: "A-", gpa: 3.50, category: "Database"),
        SubjectGrade(subjectName: "Artificial Intelligence & Neural Nets", grade: "B+", gpa: 3.25, category: "AI & ML"),
      ],
      recommendations: [
        TechStackRecommendation(
          careerPathTitle: "Mobile Application Engineer (Flutter & Native)",
          suitabilityScore: 94,
          primaryTechStack: ["Dart", "Flutter UI", "Riverpod / Provider", "Firebase", "REST APIs"],
          complementaryTools: ["Git & GitHub", "Figma to Flutter", "SQLite / Hive", "Fastlane"],
          aiReasoningText: "Your outstanding grades in Object-Oriented Programming (A+) and Mobile App Development (A) show strong logical construction and UI synthesis capabilities.",
          strongestSubjects: ["Data Structures (A+)", "OOP (A+)", "Mobile Dev (A)"],
        ),
        TechStackRecommendation(
          careerPathTitle: "Full-Stack Software Engineer (Node.js & React)",
          suitabilityScore: 86,
          primaryTechStack: ["TypeScript", "Node.js & Express", "React.js", "PostgreSQL", "Prisma"],
          complementaryTools: ["Docker", "Postman", "Redis", "JWT Auth"],
          aiReasoningText: "High performance in Database Management Systems (A-) and Data Structures makes backend architectural routing and API schema design a natural fit.",
          strongestSubjects: ["Database Systems (A-)", "OOP (A+)", "Algorithms (A+)"],
        ),
        TechStackRecommendation(
          careerPathTitle: "AI & Machine Learning Developer",
          suitabilityScore: 78,
          primaryTechStack: ["Python", "PyTorch / TensorFlow", "Scikit-Learn", "Pandas", "FastAPI"],
          complementaryTools: ["Jupyter Lab", "OpenCV", "HuggingFace", "Streamlit"],
          aiReasoningText: "Good foundation in AI & Neural Networks (B+). Strengthening linear algebra and model deployment will boost compatibility.",
          strongestSubjects: ["AI & Neural Nets (B+)", "Data Structures (A+)"],
        ),
      ],
    );
  }

  void scanPhotoTranscript(String photoFileName) {
    state = state.copyWith(isPhotoScanning: true, scannedPhotoName: photoFileName);

    // Simulate AI OCR scan & extraction
    Future.delayed(const Duration(milliseconds: 1200), () {
      final newScannedSubjects = [
        ...state.subjects,
        const SubjectGrade(subjectName: "Advanced Web Technologies", grade: "A", gpa: 3.75, category: "Web Dev"),
        const SubjectGrade(subjectName: "Software Engineering & Architecture", grade: "A+", gpa: 4.00, category: "Software Eng"),
      ];
      state = state.copyWith(
        isPhotoScanning: false,
        subjects: newScannedSubjects,
      );
    });
  }

  void addManualSubjectGrade(SubjectGrade newSubject) {
    final updated = [...state.subjects, newSubject];
    state = state.copyWith(subjects: updated);
  }

  void removeSubjectGrade(int index) {
    final updated = List<SubjectGrade>.from(state.subjects)..removeAt(index);
    state = state.copyWith(subjects: updated);
  }
}

final resultAnalyzerProvider = NotifierProvider<ResultAnalyzerNotifier, ResultAnalyzerState>(ResultAnalyzerNotifier.new);
