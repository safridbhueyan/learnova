class LearningResourceModel {
  final String id;
  final String title;
  final String channelName;
  final String category;
  final String duration;
  final String difficulty;
  final String youtubeUrl;
  final String views;
  final double rating;
  final bool isBookmarked;
  final List<String> keyTopics;
  final String summary;

  const LearningResourceModel({
    required this.id,
    required this.title,
    required this.channelName,
    required this.category,
    required this.duration,
    required this.difficulty,
    required this.youtubeUrl,
    required this.views,
    required this.rating,
    this.isBookmarked = false,
    required this.keyTopics,
    required this.summary,
  });

  LearningResourceModel copyWith({
    String? id,
    String? title,
    String? channelName,
    String? category,
    String? duration,
    String? difficulty,
    String? youtubeUrl,
    String? views,
    double? rating,
    bool? isBookmarked,
    List<String>? keyTopics,
    String? summary,
  }) {
    return LearningResourceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      channelName: channelName ?? this.channelName,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      views: views ?? this.views,
      rating: rating ?? this.rating,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      keyTopics: keyTopics ?? this.keyTopics,
      summary: summary ?? this.summary,
    );
  }
}
