import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../../result_analyzer/provider/result_analyzer_provider.dart';
import '../../result_analyzer/widgets/crop_image_screen.dart';
import '../../result_analyzer/widgets/in_app_camera_screen.dart';
import '../../result_analyzer/widgets/manual_grade_dialog.dart';
import '../provider/onboarding_provider.dart';

class StepResultsUploadWidget extends ConsumerWidget {
  const StepResultsUploadWidget({super.key});

  Future<void> _handleCameraTap(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const InAppCameraScreen()),
    ).then((_) {
      ref.read(resultAnalyzerProvider.notifier).markResultsUploaded();
      ref.read(onboardingProvider.notifier).completeOnboarding();
    });
  }

  Future<void> _handleGalleryTap(BuildContext context, WidgetRef ref) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      final imagePath = file?.path ?? "gallery_transcript.png";

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CropImageScreen(
              imagePath: imagePath,
              sourceName: "Gallery Upload",
            ),
          ),
        ).then((_) {
          ref.read(resultAnalyzerProvider.notifier).markResultsUploaded();
          ref.read(onboardingProvider.notifier).completeOnboarding();
        });
      }
    } catch (_) {
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const CropImageScreen(
              imagePath: "gallery_transcript.png",
              sourceName: "Gallery Upload",
            ),
          ),
        ).then((_) {
          ref.read(resultAnalyzerProvider.notifier).markResultsUploaded();
          ref.read(onboardingProvider.notifier).completeOnboarding();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);

    if (onboarding.isAnalyzingResults) {
      return Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: AppColor.cardBg,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColor.cardBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.verticalSpace,
            Container(
              padding: EdgeInsets.all(18.r),
              decoration: const BoxDecoration(
                color: AppColor.primarySubtle,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 40.r,
                height: 40.r,
                child: const CircularProgressIndicator(
                  color: AppColor.primary,
                  strokeWidth: 3.5,
                ),
              ),
            ),
            24.verticalSpace,
            Text(
              "AI Neural Scanner Active",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),
            10.verticalSpace,
            Text(
              "Analyzing semester marksheet & extracting subject achievements...\nSaving results to SQLite local database & calculating 3 career tech stacks.",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColor.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColor.masteredLight,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome_rounded, size: 16.sp, color: AppColor.mastered),
                  6.horizontalSpace,
                  Flexible(
                    child: Text(
                      "Generating Verified Tech Stacks...",
                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.mastered),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Step 5: Academic Results",
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            6.horizontalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColor.primarySubtle,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "Optional • Skip",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Text(
          "Launch real camera or pick gallery marksheet to crop, extract text with OCR, and store in SQLite database.",
          style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary, height: 1.35),
        ),
        16.verticalSpace,
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColor.accentLight,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColor.accent.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded, color: AppColor.accent, size: 20.sp),
              10.horizontalSpace,
              Expanded(
                child: Text(
                  "Skipping this step will show dummy tech stacks until you scan marksheets via camera or gallery.",
                  style: TextStyle(fontSize: 11.sp, color: AppColor.accentSecondary, height: 1.3),
                ),
              ),
            ],
          ),
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _handleCameraTap(context, ref),
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppColor.cardBg,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColor.primary, width: 1.5.w),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: const BoxDecoration(
                          color: AppColor.primarySubtle,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt_rounded, color: AppColor.primary, size: 24.sp),
                      ),
                      10.verticalSpace,
                      Text(
                        "Real Camera",
                        style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                      ),
                      4.verticalSpace,
                      Text(
                        "Crop & OCR",
                        style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: InkWell(
                onTap: () => _handleGalleryTap(context, ref),
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppColor.cardBg,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColor.cardBorder, width: 1.w),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: const BoxDecoration(
                          color: AppColor.surfaceLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.photo_library_rounded, color: AppColor.primary, size: 24.sp),
                      ),
                      10.verticalSpace,
                      Text(
                        "Gallery Upload",
                        style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                      ),
                      4.verticalSpace,
                      Text(
                        "Crop & OCR",
                        style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        14.verticalSpace,
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ManualGradeDialog(),
            ).then((_) {
              ref.read(resultAnalyzerProvider.notifier).markResultsUploaded();
              ref.read(onboardingProvider.notifier).simulateResultUploadAndAnalysis("manual_grades");
            });
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColor.surfaceLight,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColor.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit_note_rounded, color: AppColor.primary, size: 20.sp),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Grades Manually",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                      ),
                      2.verticalSpace,
                      Text(
                        "Saves directly to SQLite local database",
                        style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: AppColor.textMuted, size: 20.sp),
              ],
            ),
          ),
        ),
        24.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColor.cardBorder),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            ),
            onPressed: () {
              ref.read(onboardingProvider.notifier).skipResultUpload();
            },
            child: Text(
              "Skip for Now (Add Later on Dashboard)",
              style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.bold, color: AppColor.textSecondary),
            ),
          ),
        ),
      ],
    );
  }
}
