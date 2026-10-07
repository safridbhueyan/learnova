class CareerPathModel {
  final String id;
  final String title;
  final String category;
  final int compatibilityScore; // e.g. 92
  final String demandLevel; // High, Very High, Moderate
  final String description;
  final List<String> requiredSkills;
  final List<String> studentStrengths;
  final List<String> missingSkills;

  const CareerPathModel({
    required this.id,
    required this.title,
    required this.category,
    required this.compatibilityScore,
    required this.demandLevel,
    required this.description,
    required this.requiredSkills,
    required this.studentStrengths,
    required this.missingSkills,
  });
}
