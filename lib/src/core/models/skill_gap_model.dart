class SkillGapModel {
  final String skillName;
  final String category;
  final int currentProficiency; // 0 - 100
  final int requiredProficiency; // 0 - 100
  final String gapStatus; // 'Mastered', 'Strong', 'Needs Improvement', 'Missing'
  final String actionTip;

  const SkillGapModel({
    required this.skillName,
    required this.category,
    required this.currentProficiency,
    required this.requiredProficiency,
    required this.gapStatus,
    required this.actionTip,
  });
}
