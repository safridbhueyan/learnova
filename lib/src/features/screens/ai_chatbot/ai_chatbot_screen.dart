import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import 'provider/ai_chatbot_provider.dart';
import 'widgets/chat_bubble_widget.dart';
import 'widgets/chat_input_widget.dart';
import 'widgets/quick_prompts_widget.dart';

class AIChatbotScreen extends ConsumerWidget {
  const AIChatbotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(aiChatbotProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: AppColor.primarySubtle,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.psychology, color: AppColor.primary, size: 20.r),
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Learnova AI Advisor",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
                Text(
                  chatState.isTyping ? "AI is typing..." : "Online • Real-Time Career Grooming",
                  style: TextStyle(fontSize: 10.sp, color: chatState.isTyping ? AppColor.accent : AppColor.mastered),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              physics: const BouncingScrollPhysics(),
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final message = chatState.messages[index];
                return ScaleFadeEntrance(
                  key: ValueKey(message.id),
                  duration: const Duration(milliseconds: 350),
                  startScale: 0.9,
                  child: ChatBubbleWidget(message: message),
                );
              },
            ),
          ),
          if (chatState.isTyping)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 14.r,
                    height: 14.r,
                    child: const CircularProgressIndicator(color: AppColor.primary, strokeWidth: 2),
                  ),
                  8.horizontalSpace,
                  Text(
                    "Learnova AI is evaluating recommendations...",
                    style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                  ),
                ],
              ),
            ),
          const QuickPromptsWidget(),
          ChatInputWidget(),
        ],
      ),
    );
  }
}
