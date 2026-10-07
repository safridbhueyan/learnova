class MockQuestion {
  final String question;
  final String category; // Technical, HR, System Design
  final String sampleAnswerHint;

  const MockQuestion({
    required this.question,
    required this.category,
    required this.sampleAnswerHint,
  });
}

class AIFeedbackModel {
  final int overallReadinessScore; // e.g. 78%
  final int technicalScore; // 82%
  final int projectScore; // 75%
  final int experienceScore; // 65%
  final int communicationScore; // 70%
  final String readinessClassification; // 'Job Ready', 'Almost Ready', etc.
  final String summaryFeedbackText;
  final List<String> topStrengths;
  final List<String> focusAreas;
  final List<String> immediateActionPlan;
  final List<MockQuestion> mockInterviewQuestions;

  const AIFeedbackModel({
    required this.overallReadinessScore,
    required this.technicalScore,
    required this.projectScore,
    required this.experienceScore,
    required this.communicationScore,
    required this.readinessClassification,
    required this.summaryFeedbackText,
    required this.topStrengths,
    required this.focusAreas,
    required this.immediateActionPlan,
    required this.mockInterviewQuestions,
  });
}
