import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import 'provider/ai_feedback_provider.dart';
import 'widgets/ai_readiness_breakdown_widget.dart';
import 'widgets/mock_interview_card.dart';

class AIFeedbackScreen extends ConsumerWidget {
  const AIFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiData = ref.watch(aiFeedbackProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Learnova AI Continuous Advisor",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                gradient: AppColor.heroGradient,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AI DIAGNOSTIC SUMMARY",
                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary, letterSpacing: 1.w),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          aiData.readinessClassification,
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Text(
                    aiData.summaryFeedbackText,
                    style: TextStyle(fontSize: 12.sp, color: AppColor.textOnPrimary, height: 1.4),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            AIReadinessBreakdownWidget(aiData: aiData),
            20.verticalSpace,
            Text(
              "Immediate Action Plan",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
            ),
            12.verticalSpace,
            ...aiData.immediateActionPlan.map((action) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right_alt_rounded, color: AppColor.accent, size: 20.r),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(action, style: TextStyle(fontSize: 12.sp, color: AppColor.textPrimary)),
                    ),
                  ],
                ),
              );
            }),
            20.verticalSpace,
            Text(
              "AI Mock Technical Interview Simulator",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
            ),
            12.verticalSpace,
            ...aiData.mockInterviewQuestions.map((q) => MockInterviewCard(question: q)),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
