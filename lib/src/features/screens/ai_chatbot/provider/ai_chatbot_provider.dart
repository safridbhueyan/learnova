import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../student_profile/provider/student_profile_provider.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AIChatbotState {
  final List<ChatMessage> messages;
  final bool isTyping;

  const AIChatbotState({
    required this.messages,
    required this.isTyping,
  });

  AIChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
  }) {
    return AIChatbotState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class AIChatbotNotifier extends Notifier<AIChatbotState> {
  @override
  AIChatbotState build() {
    return AIChatbotState(
      isTyping: false,
      messages: [
        ChatMessage(
          id: "msg_01",
          text: "Hello! 👋 I'm Learnova AI, your continuous career grooming assistant. Ask me anything about suitable tech stacks, skill gaps, roadmaps, or interview preparation!",
          isUser: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
    );
  }

  void sendMessage(String prompt) {
    if (prompt.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: prompt.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    final updated = [...state.messages, userMsg];
    state = state.copyWith(messages: updated, isTyping: true);

    // Read student profile for context-aware responses
    final student = ref.read(studentProfileProvider);
    final masteredSkills = student.skills.where((s) => s.status == "Mastered").map((s) => s.name).toList();
    final missingSkills = student.skills.where((s) => s.status == "Missing").map((s) => s.name).toList();
    final avgProf = student.skills.isNotEmpty
        ? (student.skills.fold<int>(0, (sum, s) => sum + s.proficiency) / student.skills.length).round()
        : 50;

    // Simulate AI intelligent response with profile-aware context
    Future.delayed(const Duration(milliseconds: 1000), () {
      String reply;
      final lower = prompt.toLowerCase();

      if (lower.contains("interview") || lower.contains("mock")) {
        reply = "For ${student.targetCareer} interviews, prepare questions on: "
            "${masteredSkills.take(3).join(', ')}. "
            "Also review ${missingSkills.take(2).join(' and ')} — interviewers often test candidates on growth areas. "
            "Practice STAR method for behavioral questions about your ${student.projects.firstOrNull?.title ?? 'capstone'} project.";
      } else if (lower.contains("tech stack") || lower.contains("career") || lower.contains("grade")) {
        reply = "Your strongest alignment is ${student.targetCareer} (avg skill proficiency: $avgProf%). "
            "Your mastered skills include: ${masteredSkills.join(', ')}. "
            "For ${student.department} students at ${student.university}, "
            "the ideal tech stack builds on these with REST API integration and Clean Architecture.";
      } else if (lower.contains("gap") || lower.contains("learn") || lower.contains("weak")) {
        reply = "Your biggest skill gaps are: ${missingSkills.join(', ')}. "
            "I recommend focusing on these in priority order. "
            "Complete your roadmap phases sequentially — each phase targets one critical gap area. "
            "Your current average proficiency is $avgProf%.";
      } else if (lower.contains("roadmap") || lower.contains("next") || lower.contains("phase")) {
        reply = "Based on your current progress, I recommend: "
            "1) Continue strengthening ${missingSkills.isNotEmpty ? missingSkills.first : 'advanced skills'}. "
            "2) Build a portfolio project demonstrating ${masteredSkills.take(2).join(' + ')}. "
            "3) Check the Roadmap tab for your personalized learning pipeline with ${student.targetCareer} focus.";
      } else if (lower.contains("job") || lower.contains("apply") || lower.contains("opportunity")) {
        reply = "With ${masteredSkills.length} mastered skills and $avgProf% average proficiency, "
            "you're ready for entry-level ${student.targetCareer} positions. "
            "Check the Scan & Jobs tab — I've matched you with positions that align with "
            "${masteredSkills.take(3).join(', ')}. Focus on closing ${missingSkills.length} remaining gaps for senior roles.";
      } else {
        reply = "Based on your profile as a ${student.semester} ${student.department} student at ${student.university} "
            "targeting ${student.targetCareer}: Your average skill proficiency is $avgProf% across ${student.skills.length} tracked skills. "
            "You have ${masteredSkills.length} mastered skills and ${missingSkills.length} skill gaps to address. "
            "How can I help you further? Try asking about interviews, tech stacks, skill gaps, or your roadmap!";
      }

      final aiMsg = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: reply,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, aiMsg],
        isTyping: false,
      );
    });
  }

  void clearHistory() {
    state = AIChatbotState(
      isTyping: false,
      messages: [
        ChatMessage(
          id: "msg_cleared_${DateTime.now().millisecondsSinceEpoch}",
          text: "Chat history cleared. How can I help you today? 💡",
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }
}

final aiChatbotProvider = NotifierProvider<AIChatbotNotifier, AIChatbotState>(AIChatbotNotifier.new);
