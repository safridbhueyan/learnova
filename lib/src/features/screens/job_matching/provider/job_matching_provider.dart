import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/job_match_model.dart';

class JobMatchingNotifier extends Notifier<List<JobMatchModel>> {
  @override
  List<JobMatchModel> build() {
    return const [
      JobMatchModel(
        id: "job_01",
        title: "Junior Flutter Developer",
        company: "TechNova Solutions Ltd.",
        location: "Dhaka (Hybrid)",
        type: "Full-Time",
        matchPercentage: 87,
        salaryRange: "\$600 - \$900 / month",
        requiredSkills: ["Flutter", "Dart", "Firebase", "REST API", "Git", "Riverpod"],
        matchingSkills: ["Flutter", "Dart", "Firebase", "Git", "Riverpod"],
        missingSkills: ["REST API"],
        aiMatchingNote: "High Match! Your profile meets 5 out of 6 key technical requirements. Recommended to apply now.",
      ),
      JobMatchModel(
        id: "job_02",
        title: "Mobile App Engineer Intern",
        company: "InnovateX Labs",
        location: "Remote",
        type: "Internship",
        matchPercentage: 94,
        salaryRange: "\$300 - \$450 / month",
        requiredSkills: ["Dart", "Flutter UI", "State Management", "Git"],
        matchingSkills: ["Dart", "Flutter UI", "State Management", "Git"],
        missingSkills: [],
        aiMatchingNote: "Perfect Match! You exceed all baseline requirements for this mobile engineering internship.",
      ),
      JobMatchModel(
        id: "job_03",
        title: "Associate Software Engineer",
        company: "BrainStation 23",
        location: "Dhaka (On-site)",
        type: "Full-Time",
        matchPercentage: 78,
        salaryRange: "\$700 - \$1000 / month",
        requiredSkills: ["Dart/Java", "REST APIs", "SQL", "Clean Architecture", "Git"],
        matchingSkills: ["Dart", "Git", "OOP Concepts"],
        missingSkills: ["Clean Architecture", "SQL Databases"],
        aiMatchingNote: "Moderate Match. Completing Roadmap Phase 4 (Clean Architecture) will boost compatibility to 90%+.",
      ),
      JobMatchModel(
        id: "job_04",
        title: "Frontend Mobile Specialist",
        company: "Selise Digital Platforms",
        location: "Dhaka / Remote",
        type: "Full-Time",
        matchPercentage: 82,
        salaryRange: "\$800 - \$1200 / month",
        requiredSkills: ["Flutter", "Animations", "State Management", "REST API", "CI/CD"],
        matchingSkills: ["Flutter", "Animations", "State Management"],
        missingSkills: ["REST API", "CI/CD"],
        aiMatchingNote: "Strong candidate for UI development. Focus on REST API integration to complete eligibility.",
      ),
    ];
  }
}

final jobMatchingProvider = NotifierProvider<JobMatchingNotifier, List<JobMatchModel>>(JobMatchingNotifier.new);
