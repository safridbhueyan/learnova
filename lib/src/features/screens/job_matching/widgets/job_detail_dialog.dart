import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/job_match_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class JobDetailDialog extends StatelessWidget {
  final JobMatchModel job;

  const JobDetailDialog({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.cardBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
            ),
            4.verticalSpace,
            Text(
              job.company,
              style: TextStyle(fontSize: 13.sp, color: AppColor.accent),
            ),
            14.verticalSpace,
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                job.aiMatchingNote,
                style: TextStyle(fontSize: 12.sp, color: AppColor.textPrimary, height: 1.35),
              ),
            ),
            14.verticalSpace,
            Text("Matching Skills:", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.mastered)),
            6.verticalSpace,
            Text(job.matchingSkills.isEmpty ? "None" : job.matchingSkills.join(", "), style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary)),
            10.verticalSpace,
            Text("Missing Requirements:", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.missing)),
            6.verticalSpace,
            Text(job.missingSkills.isEmpty ? "None! You are 100% matched." : job.missingSkills.join(", "), style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary)),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close", style: TextStyle(color: AppColor.textMuted, fontSize: 12.sp)),
                ),
                10.horizontalSpace,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColor.mastered,
                        content: Text("Application submitted via Learnova Career Hub!"),
                      ),
                    );
                  },
                  child: Text("One-Click Apply", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
