import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/ai_chatbot_provider.dart';

class QuickPromptsWidget extends ConsumerWidget {
  const QuickPromptsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompts = [
      "⚡ Which tech stack fits my grades?",
      "🎯 How to prepare for Flutter interviews?",
      "🔍 What are my top skill gaps?",
      "🗺️ Suggest my next learning roadmap phase",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        children: prompts.map((prompt) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ActionChip(
              backgroundColor: AppColor.cardBg,
              side: const BorderSide(color: AppColor.cardBorder, width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              label: Text(
                prompt,
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
              ),
              onPressed: () {
                ref.read(aiChatbotProvider.notifier).sendMessage(prompt);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
