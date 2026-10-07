import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/career_path_model.dart';

class CareerRecommendationsNotifier extends Notifier<List<CareerPathModel>> {
  @override
  List<CareerPathModel> build() {
    return const [
      CareerPathModel(
        id: "mobile_flutter",
        title: "Mobile Application Developer (Flutter)",
        category: "Mobile Engineering",
        compatibilityScore: 92,
        demandLevel: "Very High",
        description: "Develop high-performance cross-platform mobile apps using Dart and Flutter framework.",
        requiredSkills: ["Dart", "Flutter UI", "State Management", "REST API", "Clean Architecture", "Testing"],
        studentStrengths: ["Dart", "Flutter UI", "Firebase", "Git"],
        missingSkills: ["REST API", "Clean Architecture", "Automated Testing", "CI/CD Deployment"],
      ),
      CareerPathModel(
        id: "software_eng",
        title: "Software Engineer (Full-Stack)",
        category: "Software Development",
        compatibilityScore: 84,
        demandLevel: "High",
        description: "Design and implement scalable software systems, backend APIs, and modern client applications.",
        requiredSkills: ["Dart/JavaScript", "Node.js", "REST API", "Database Design", "Git", "OOP"],
        studentStrengths: ["Dart", "Firebase Firestore", "Git", "OOP Concepts"],
        missingSkills: ["Node.js API", "SQL Databases", "System Design"],
      ),
      CareerPathModel(
        id: "ai_ml_eng",
        title: "AI / Machine Learning Engineer",
        category: "Artificial Intelligence",
        compatibilityScore: 78,
        demandLevel: "Very High",
        description: "Build predictive models, NLP skill extractors, and intelligent decision systems.",
        requiredSkills: ["Python", "TensorFlow/PyTorch", "NLP", "Linear Algebra", "Data Preprocessing"],
        studentStrengths: ["Interest in AI", "Basic Mathematics", "Data Structures"],
        missingSkills: ["Python ML Libraries", "NLP Pipelines", "Model Deployment"],
      ),
    ];
  }
}

final careerRecommendationsProvider = NotifierProvider<CareerRecommendationsNotifier, List<CareerPathModel>>(CareerRecommendationsNotifier.new);
