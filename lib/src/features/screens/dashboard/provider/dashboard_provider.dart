import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../job_matching/provider/job_matching_provider.dart';
import '../../personalized_roadmap/provider/roadmap_provider.dart';
import '../../result_analyzer/provider/result_analyzer_provider.dart';
import '../../student_profile/provider/student_profile_provider.dart';

class DashboardSummary {
  final String careerGoal;
  final int careerMatchPercentage;
  final int skillProgressPercentage;
  final int jobReadinessScore;
  final int completedRoadmapItems;
  final int totalRoadmapItems;
  final int skillGapsCount;
  final int recommendedJobsCount;

  const DashboardSummary({
    required this.careerGoal,
    required this.careerMatchPercentage,
    required this.skillProgressPercentage,
    required this.jobReadinessScore,
    required this.completedRoadmapItems,
    required this.totalRoadmapItems,
    required this.skillGapsCount,
    required this.recommendedJobsCount,
  });
}

final dashboardProvider = Provider<DashboardSummary>((ref) {
  final student = ref.watch(studentProfileProvider);
  final roadmap = ref.watch(roadmapProvider);
  final analyzer = ref.watch(resultAnalyzerProvider);
  final jobs = ref.watch(jobMatchingProvider);

  final completedRoadmap = roadmap.where((p) => p.status == "completed").length;
  final totalRoadmap = roadmap.length;

  final totalProficiency = student.skills.fold<int>(0, (sum, item) => sum + item.proficiency);
  final skillProgress = student.skills.isNotEmpty ? (totalProficiency / student.skills.length).round() : 74;

  final masteredSkillsCount = student.skills.where((s) => s.status == "Mastered" || s.proficiency >= 80).length;
  final baseReadiness = (masteredSkillsCount * 12) + (completedRoadmap * 10) + (analyzer.subjects.length * 4);
  final readinessScore = baseReadiness.clamp(45, 98);

  final missingSkillsCount = student.skills.where((s) => s.status == "Missing" || s.proficiency < 45).length;

  final strongSkillsCount = student.skills.where((s) => s.status == "Mastered" || s.status == "Strong").length;
  final careerMatch = student.skills.isNotEmpty
      ? ((strongSkillsCount / student.skills.length) * 100).round().clamp(40, 98)
      : 50;

  return DashboardSummary(
    careerGoal: student.targetCareer,
    careerMatchPercentage: careerMatch,
    skillProgressPercentage: skillProgress,
    jobReadinessScore: readinessScore,
    completedRoadmapItems: completedRoadmap,
    totalRoadmapItems: totalRoadmap,
    skillGapsCount: missingSkillsCount > 0 ? missingSkillsCount : 3,
    recommendedJobsCount: jobs.length,
  );
});

