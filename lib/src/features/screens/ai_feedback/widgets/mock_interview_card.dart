import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/ai_feedback_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class MockInterviewCard extends StatelessWidget {
  final MockQuestion question;

  const MockInterviewCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  question.category,
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                ),
              ),
              Icon(Icons.quiz_outlined, size: 16.r, color: AppColor.textMuted),
            ],
          ),
          10.verticalSpace,
          Text(
            question.question,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary, height: 1.3),
          ),
          10.verticalSpace,
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColor.surfaceLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 14.r, color: AppColor.accent),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    "AI Answer Hint: ${question.sampleAnswerHint}",
                    style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
