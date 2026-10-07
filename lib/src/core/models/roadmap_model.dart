class ResourceItem {
  final String title;
  final String type; // Course, Video, Documentation, Article, Practice
  final String estimatedTime;
  final String url;

  const ResourceItem({
    required this.title,
    required this.type,
    required this.estimatedTime,
    required this.url,
  });
}

class RecommendedProject {
  final String title;
  final String difficulty; // Beginner, Intermediate, Advanced, Job-Ready
  final String description;
  final List<String> targetSkills;

  const RecommendedProject({
    required this.title,
    required this.difficulty,
    required this.description,
    required this.targetSkills,
  });
}

class RoadmapPhaseModel {
  final int phaseNumber;
  final String title;
  final String subtitle;
  final String status; // 'completed', 'inProgress', 'upcoming'
  final String estimatedDuration;
  final List<String> topics;
  final List<ResourceItem> resources;
  final RecommendedProject project;

  const RoadmapPhaseModel({
    required this.phaseNumber,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.estimatedDuration,
    required this.topics,
    required this.resources,
    required this.project,
  });

  RoadmapPhaseModel copyWith({
    int? phaseNumber,
    String? title,
    String? subtitle,
    String? status,
    String? estimatedDuration,
    List<String>? topics,
    List<ResourceItem>? resources,
    RecommendedProject? project,
  }) {
    return RoadmapPhaseModel(
      phaseNumber: phaseNumber ?? this.phaseNumber,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      status: status ?? this.status,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      topics: topics ?? this.topics,
      resources: resources ?? this.resources,
      project: project ?? this.project,
    );
  }
}
