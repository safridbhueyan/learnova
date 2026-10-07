import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../result_analyzer/widgets/crop_image_screen.dart';
import '../result_analyzer/widgets/in_app_camera_screen.dart';
import 'provider/marksheet_provider.dart';
import 'widgets/add_semester_marks_dialog.dart';
import 'widgets/course_marks_table_widget.dart';
import 'widgets/marksheet_summary_card_widget.dart';

class MarksheetScreen extends ConsumerWidget {
  const MarksheetScreen({super.key});

  Future<void> _handleCameraScan(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const InAppCameraScreen()),
    );
  }

  Future<void> _handleGalleryPick(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      final imagePath = file?.path ?? "gallery_semester_marksheet.png";

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CropImageScreen(
              imagePath: imagePath,
              sourceName: "Gallery Marksheet",
            ),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const CropImageScreen(
              imagePath: "gallery_semester_marksheet.png",
              sourceName: "Gallery Marksheet",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marksheetState = ref.watch(marksheetProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Academic Marksheets & SGPA",
          style: TextStyle(fontSize: 16.5.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Semester Selector Scroll Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: marksheetState.availableSemesters.map((sem) {
                  final isSelected = sem == marksheetState.selectedSemester;

                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => ref.read(marksheetProvider.notifier).selectSemester(sem),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primary : AppColor.cardBg,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected ? AppColor.primary : AppColor.cardBorder,
                            width: 1.w,
                          ),
                          boxShadow: isSelected
                              ? const [
                                  BoxShadow(
                                    color: AppColor.shadow,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          sem,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? AppColor.textOnPrimary : AppColor.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            16.verticalSpace,

            // Summary Card
            const ScaleFadeEntrance(
              delay: Duration.zero,
              child: MarksheetSummaryCardWidget(),
            ),
            16.verticalSpace,

            // Action Bar: Scan Camera, Upload Gallery, Add Manual Mark
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () => _handleCameraScan(context),
                    icon: Icon(Icons.camera_alt_rounded, size: 16.sp, color: AppColor.textOnPrimary),
                    label: Text(
                      "Camera Scan",
                      style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                    ),
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () => _handleGalleryPick(context),
                    icon: Icon(Icons.photo_library_rounded, size: 16.sp, color: AppColor.primary),
                    label: Text(
                      "Gallery Scan",
                      style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                    ),
                  ),
                ),
                8.horizontalSpace,
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.accentLight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddSemesterMarksDialog(),
                    );
                  },
                  icon: Icon(Icons.add_rounded, color: AppColor.accent, size: 24.sp),
                  tooltip: "Add Course Mark",
                ),
              ],
            ),
            20.verticalSpace,

            // Course Marks Breakdown Table
            const ScaleFadeEntrance(
              delay: Duration(milliseconds: 100),
              child: CourseMarksTableWidget(),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
