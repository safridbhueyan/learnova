import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/ai_chatbot_provider.dart';

class ChatInputWidget extends ConsumerWidget {
  final TextEditingController inputController = TextEditingController();

  ChatInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(aiChatbotProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: const BoxDecoration(
        color: AppColor.surface,
        border: Border(
          top: BorderSide(color: AppColor.cardBorder, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: inputController,
                style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                decoration: InputDecoration(
                  hintText: "Ask Learnova AI career advisor...",
                  hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.textMuted),
                  filled: true,
                  fillColor: AppColor.background,
                  contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    ref.read(aiChatbotProvider.notifier).sendMessage(value);
                    inputController.clear();
                  }
                },
              ),
            ),
            8.horizontalSpace,
            GestureDetector(
              onTap: chatState.isTyping
                  ? null
                  : () {
                      final text = inputController.text;
                      if (text.trim().isNotEmpty) {
                        ref.read(aiChatbotProvider.notifier).sendMessage(text);
                        inputController.clear();
                      }
                    },
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send_rounded, color: AppColor.textOnPrimary, size: 18.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
