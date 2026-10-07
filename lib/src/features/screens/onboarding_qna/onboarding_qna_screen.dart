import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../main_navigation/main_navigation_screen.dart';
import '../student_profile/provider/student_profile_provider.dart';
import 'provider/onboarding_provider.dart';
import 'widgets/step_academic_widget.dart';
import 'widgets/step_interests_widget.dart';
import 'widgets/step_results_upload_widget.dart';
import 'widgets/step_skills_widget.dart';
import 'widgets/step_target_career_widget.dart';

class OnboardingQnaScreen extends ConsumerWidget {
  const OnboardingQnaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);

    if (onboarding.isCompleted) {
      return const MainNavigationScreen();
    }

    final steps = [
      const StepAcademicWidget(),
      const StepInterestsWidget(),
      const StepSkillsWidget(),
      const StepTargetCareerWidget(),
      const StepResultsUploadWidget(),
    ];

    final isLastStep = onboarding.currentStep == 4;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Learnova Student Setup",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Step ${onboarding.currentStep + 1} of 5",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                      ),
                      Text(
                        "${((onboarding.currentStep + 1) / 5 * 100).round()}% Completed",
                        style: TextStyle(fontSize: 11.sp, color: AppColor.textMuted, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: (onboarding.currentStep + 1) / 5,
                      minHeight: 6.h,
                      backgroundColor: AppColor.surfaceLight,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: steps[onboarding.currentStep],
              ),
            ),
            // Navigation Action Bar (for steps 1-4)
            if (!isLastStep)
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: const BoxDecoration(
                  color: AppColor.surface,
                  border: Border(top: BorderSide(color: AppColor.cardBorder, width: 1)),
                ),
                child: Row(
                  children: [
                    if (onboarding.currentStep > 0) ...[
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColor.cardBorder),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                        ),
                        onPressed: () {
                          ref.read(onboardingProvider.notifier).previousStep();
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                        ),
                      ),
                      12.horizontalSpace,
                    ],
                    Expanded(
                      child: BouncyScaleButton(
                        id: "onboarding_next_btn",
                        onTap: () {
                          if (onboarding.currentStep < 4) {
                            ref.read(onboardingProvider.notifier).nextStep();
                          } else {
                            final ob = ref.read(onboardingProvider);
                            ref.read(studentProfileProvider.notifier).updateTargetCareer(ob.targetCareer);
                            ref.read(studentProfileProvider.notifier).updateAcademicInfo(
                                  university: ob.university,
                                  department: ob.department,
                                  semester: ob.semester,
                                  cgpa: ob.cgpa,
                                );
                            ref.read(studentProfileProvider.notifier).updateInterests(ob.selectedInterests);
                            ref.read(onboardingProvider.notifier).completeOnboarding();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColor.shadow,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Continue to Next Step",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textOnPrimary,
                                ),
                              ),
                              6.horizontalSpace,
                              Icon(Icons.arrow_forward_rounded, color: AppColor.textOnPrimary, size: 16.r),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
