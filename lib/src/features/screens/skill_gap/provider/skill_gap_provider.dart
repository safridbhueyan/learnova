import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/skill_gap_model.dart';
import '../../student_profile/provider/student_profile_provider.dart';

/// Dynamically computes skill gaps from the active student profile.
/// Each student skill is compared against industry-standard required
/// proficiency levels, deriving gap status and action tips automatically.
final skillGapProvider = Provider<List<SkillGapModel>>((ref) {
  final student = ref.watch(studentProfileProvider);

  // Industry-standard required proficiency per skill category
  const Map<String, int> industryBenchmark = {
    "Language": 90,
    "Framework": 85,
    "Backend": 80,
    "Architecture": 80,
    "Networking": 85,
    "Tools": 75,
    "Testing": 75,
    "DevOps": 70,
  };

  // Action tips based on proficiency range
  String actionTip(String name, int current, int required) {
    if (current >= required) return "Excellent command. Continue mentoring and staying updated.";
    final gap = required - current;
    if (gap <= 10) return "Almost there! Focus on advanced edge cases and real-world projects for $name.";
    if (gap <= 25) return "Good foundation. Complete hands-on projects and build portfolio pieces using $name.";
    if (gap <= 40) return "Significant gap. Enroll in a dedicated course and build at least 2 projects with $name.";
    return "Critical gap. Start from fundamentals with guided tutorials for $name.";
  }

  String gapStatus(int current, int required) {
    if (current >= required) return "Mastered";
    if (current >= required - 10) return "Strong";
    if (current >= 45) return "Needs Improvement";
    return "Missing";
  }

  return student.skills.map((skill) {
    final required = industryBenchmark[skill.category] ?? 80;
    return SkillGapModel(
      skillName: skill.name,
      category: skill.category,
      currentProficiency: skill.proficiency,
      requiredProficiency: required,
      gapStatus: gapStatus(skill.proficiency, required),
      actionTip: actionTip(skill.name, skill.proficiency, required),
    );
  }).toList();
});
