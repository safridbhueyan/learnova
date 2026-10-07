import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/ai_chatbot_provider.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: AppColor.primarySubtle,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.psychology, color: AppColor.primary, size: 18.r),
            ),
            8.horizontalSpace,
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: message.isUser ? AppColor.primary : AppColor.cardBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(message.isUser ? 16.r : 4.r),
                  bottomRight: Radius.circular(message.isUser ? 4.r : 16.r),
                ),
                border: message.isUser ? null : Border.all(color: AppColor.cardBorder, width: 1.w),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.shadow,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: message.isUser ? AppColor.textOnPrimary : AppColor.textPrimary,
                  height: 1.35,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            8.horizontalSpace,
            CircleAvatar(
              radius: 12.r,
              backgroundColor: AppColor.accent,
              child: Icon(Icons.person, color: AppColor.textOnPrimary, size: 14.r),
            ),
          ],
        ],
      ),
    );
  }
}
