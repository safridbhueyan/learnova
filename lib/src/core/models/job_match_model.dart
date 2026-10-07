class JobMatchModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type; // Internship, Full-Time, Remote
  final int matchPercentage;
  final String salaryRange;
  final List<String> requiredSkills;
  final List<String> matchingSkills;
  final List<String> missingSkills;
  final String aiMatchingNote;

  const JobMatchModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.matchPercentage,
    required this.salaryRange,
    required this.requiredSkills,
    required this.matchingSkills,
    required this.missingSkills,
    required this.aiMatchingNote,
  });
}
