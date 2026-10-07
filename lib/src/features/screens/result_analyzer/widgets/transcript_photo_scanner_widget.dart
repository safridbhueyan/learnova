import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/result_analyzer_provider.dart';
import 'manual_grade_dialog.dart';

class TranscriptPhotoScannerWidget extends ConsumerWidget {
  const TranscriptPhotoScannerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzerState = ref.watch(resultAnalyzerProvider);

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Upload Academic Result",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.primarySubtle,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "AI OCR Powered",
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColor.primary),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            "Upload a photo of your transcript or enter grades manually. Learnova AI extracts your subject strengths to detect your ideal career tech stack.",
            style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.35),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: analyzerState.isPhotoScanning
                      ? null
                      : () {
                          ref.read(resultAnalyzerProvider.notifier).scanPhotoTranscript("transcript_semester_07.png");
                        },
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppColor.surfaceLight,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColor.primary.withValues(alpha: 0.3), width: 1.w),
                    ),
                    child: analyzerState.isPhotoScanning
                        ? Column(
                            children: [
                              SizedBox(
                                width: 22.r,
                                height: 22.r,
                                child: const CircularProgressIndicator(color: AppColor.primary, strokeWidth: 2.5),
                              ),
                              8.verticalSpace,
                              Text(
                                "Scanning Transcript OCR...",
                                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Icon(Icons.add_a_photo_outlined, color: AppColor.primary, size: 26.r),
                              8.verticalSpace,
                              Text(
                                "Upload Result Photo",
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                              ),
                              4.verticalSpace,
                              Text(
                                "JPG, PNG, PDF Grade Sheet",
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ManualGradeDialog(),
                    );
                  },
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppColor.accentLight,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColor.accent.withValues(alpha: 0.4), width: 1.w),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.edit_note_rounded, color: AppColor.accent, size: 26.r),
                        8.verticalSpace,
                        Text(
                          "Manual Grade Entry",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.accent),
                        ),
                        4.verticalSpace,
                        Text(
                          "Enter Subject & Letter Grade",
                          style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
