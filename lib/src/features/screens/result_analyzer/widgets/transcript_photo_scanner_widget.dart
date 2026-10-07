import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/result_analyzer_provider.dart';
import 'crop_image_screen.dart';
import 'in_app_camera_screen.dart';
import 'manual_grade_dialog.dart';

class TranscriptPhotoScannerWidget extends ConsumerWidget {
  const TranscriptPhotoScannerWidget({super.key});

  Future<void> _handleCameraTap(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const InAppCameraScreen()),
    );
  }

  Future<void> _handleGalleryTap(BuildContext context) async {
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
        );
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
        );
      }
    }
  }

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
                  overflow: TextOverflow.ellipsis,
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
                  "Real Camera + OCR",
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            "Launch the real in-app camera or pick from gallery. Crop your marksheet image to scan course titles & grades via OCR into your SQLite database.",
            style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.35),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: analyzerState.isPhotoScanning ? null : () => _handleCameraTap(context),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppColor.surfaceLight,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColor.primary.withValues(alpha: 0.4), width: 1.w),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt_rounded, color: AppColor.primary, size: 24.r),
                        8.verticalSpace,
                        Text(
                          "Real Camera",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                        ),
                        4.verticalSpace,
                        Text(
                          "In-App Viewfinder",
                          style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: InkWell(
                  onTap: analyzerState.isPhotoScanning ? null : () => _handleGalleryTap(context),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppColor.surfaceLight,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColor.primary.withValues(alpha: 0.3), width: 1.w),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.photo_library_rounded, color: AppColor.primary, size: 24.r),
                        8.verticalSpace,
                        Text(
                          "Gallery Upload",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                        ),
                        4.verticalSpace,
                        Text(
                          "Crop & Extract Text",
                          style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ManualGradeDialog(),
              );
            },
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColor.accentLight,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColor.accent.withValues(alpha: 0.4), width: 1.w),
              ),
              child: Row(
                children: [
                  Icon(Icons.edit_note_rounded, color: AppColor.accent, size: 22.r),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Grades Manually",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.accent),
                        ),
                        2.verticalSpace,
                        Text(
                          "Saves directly to SQLite local database",
                          style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 14.r, color: AppColor.accent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
