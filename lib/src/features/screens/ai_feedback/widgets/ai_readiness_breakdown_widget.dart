import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/models/ai_feedback_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class AIReadinessBreakdownWidget extends StatelessWidget {
  final AIFeedbackModel aiData;

  const AIReadinessBreakdownWidget({super.key, required this.aiData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Multi-Dimensional Job Readiness Analysis",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
          ),
          14.verticalSpace,
          _buildScoreRow("Technical Skills Competency", aiData.technicalScore, AppColor.mastered),
          12.verticalSpace,
          _buildScoreRow("Project Portfolio Strength", aiData.projectScore, AppColor.accent),
          12.verticalSpace,
          _buildScoreRow("Work / Internship Experience", aiData.experienceScore, AppColor.warning),
          12.verticalSpace,
          _buildScoreRow("Soft Skills & Communication", aiData.communicationScore, AppColor.primaryLight),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, int score, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary)),
            Text("$score%", style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        6.verticalSpace,
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 6.h,
          percent: (score / 100).clamp(0.0, 1.0),
          backgroundColor: AppColor.surfaceLight,
          progressColor: color,
          barRadius: Radius.circular(3.r),
        ),
      ],
    );
  }
}
