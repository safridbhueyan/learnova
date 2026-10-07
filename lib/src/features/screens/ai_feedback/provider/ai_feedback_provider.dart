import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/ai_feedback_model.dart';
import '../../personalized_roadmap/provider/roadmap_provider.dart';
import '../../result_analyzer/provider/result_analyzer_provider.dart';
import '../../student_profile/provider/student_profile_provider.dart';

/// Dynamically computes AI feedback from student profile, roadmap progress,
/// and academic results — making the advisor screen always reflect real state.
final aiFeedbackProvider = Provider<AIFeedbackModel>((ref) {
  final student = ref.watch(studentProfileProvider);
  final roadmap = ref.watch(roadmapProvider);
  final analyzer = ref.watch(resultAnalyzerProvider);

  // Compute technical score from average skill proficiency
  final totalProf = student.skills.fold<int>(0, (sum, s) => sum + s.proficiency);
  final technicalScore = student.skills.isNotEmpty ? (totalProf / student.skills.length).round() : 50;

  // Compute project score from project count and status
  final completedProjects = student.projects.where((p) => p.status == "Completed").length;
  final projectScore = (completedProjects * 30 + student.projects.length * 10).clamp(25, 95);

  // Compute experience score from roadmap completion
  final completedPhases = roadmap.where((p) => p.status == "completed").length;
  final experienceScore = (completedPhases * 15 + analyzer.subjects.length * 5).clamp(30, 95);

  // Communication score is stable baseline
  const communicationScore = 70;

  final overallScore = ((technicalScore + projectScore + experienceScore + communicationScore) / 4).round();

  String classification;
  if (overallScore >= 85) {
    classification = "Highly Competitive ($overallScore%)";
  } else if (overallScore >= 70) {
    classification = "Job Ready ($overallScore%)";
  } else if (overallScore >= 55) {
    classification = "Developing ($overallScore%)";
  } else {
    classification = "Needs Foundation ($overallScore%)";
  }

  // Derive top strengths from mastered/strong skills
  final topStrengths = student.skills
      .where((s) => s.status == "Mastered" || s.status == "Strong")
      .take(4)
      .map((s) => "${s.name} (${s.proficiency}%)")
      .toList();
  if (topStrengths.isEmpty) topStrengths.add("Building foundational skills");

  // Derive focus areas from missing/needs improvement skills
  final focusAreas = student.skills
      .where((s) => s.status == "Missing" || s.status == "Needs Improvement")
      .take(4)
      .map((s) => "${s.name} – currently at ${s.proficiency}%")
      .toList();
  if (focusAreas.isEmpty) focusAreas.add("Continue advanced skill refinement");

  // Immediate action plan
  final nextPhase = roadmap.where((p) => p.status == "inProgress").toList();
  final upcomingPhases = roadmap.where((p) => p.status == "upcoming").toList();
  final actionPlan = <String>[];
  if (nextPhase.isNotEmpty) {
    actionPlan.add("Complete ${nextPhase.first.title} (Currently In Progress)");
  }
  if (upcomingPhases.isNotEmpty) {
    actionPlan.add("Begin ${upcomingPhases.first.title} next");
  }
  if (focusAreas.isNotEmpty) {
    actionPlan.add("Strengthen weakest skill: ${student.skills.where((s) => s.status == "Missing").firstOrNull?.name ?? "identified gaps"}");
  }
  actionPlan.add("Apply to top matching internship roles on Learnova Opportunity Hub");

  final summaryText = "Based on your profile as a ${student.department} student targeting ${student.targetCareer}, "
      "your technical skill average is $technicalScore%. "
      "You have completed $completedPhases of ${roadmap.length} roadmap phases and "
      "${analyzer.subjects.length} graded academic subjects. "
      "Focus on closing ${focusAreas.length} skill gap(s) to boost your readiness score.";

  return AIFeedbackModel(
    overallReadinessScore: overallScore,
    technicalScore: technicalScore,
    projectScore: projectScore,
    experienceScore: experienceScore,
    communicationScore: communicationScore,
    readinessClassification: classification,
    summaryFeedbackText: summaryText,
    topStrengths: topStrengths,
    focusAreas: focusAreas,
    immediateActionPlan: actionPlan,
    mockInterviewQuestions: const [
      MockQuestion(
        question: "Explain the difference between NotifierProvider and FutureProvider in Riverpod.",
        category: "Technical",
        sampleAnswerHint: "NotifierProvider is synchronous/stateful for local state mutation; FutureProvider listens to asynchronous futures and returns AsyncValue.",
      ),
      MockQuestion(
        question: "How do you optimize Flutter build methods to avoid unnecessary widget rebuilds?",
        category: "Performance",
        sampleAnswerHint: "Use const constructors, ref.watch with select(), extract sub-widgets, and avoid calling heavy methods inside build().",
      ),
      MockQuestion(
        question: "Describe your approach to handling HTTP 401 Unauthorized errors in a production app.",
        category: "System Design",
        sampleAnswerHint: "Use Dio interceptor queued retry, request new OAuth token using refresh token, persist new token, and retry failed request seamlessly.",
      ),
    ],
  );
});
