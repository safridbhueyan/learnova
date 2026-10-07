import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../../main_navigation/provider/navigation_provider.dart';

class AIInsightBanner extends ConsumerWidget {
  final String text;

  const AIInsightBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.primary.withValues(alpha: 0.3), width: 1.w),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: AppColor.primarySubtle,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.psychology_rounded,
                  color: AppColor.primary,
                  size: 18.r,
                ),
              ),
              8.horizontalSpace,
              Text(
                "LEARNOVA AI INSIGHT",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.accent,
                  letterSpacing: 0.8.w,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColor.textPrimary,
              height: 1.35,
            ),
          ),
          12.verticalSpace,
          GestureDetector(
            onTap: () {
              ref.read(navigationProvider.notifier).setIndex(4); // AI Chatbot tab
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ask AI Advisor",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                4.horizontalSpace,
                Icon(Icons.arrow_forward_rounded, size: 12.r, color: AppColor.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
