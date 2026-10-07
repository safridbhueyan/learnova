import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/job_match_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class JobCardWidget extends StatelessWidget {
  final JobMatchModel job;
  final VoidCallback onTap;

  const JobCardWidget({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  job.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColor.masteredLight,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColor.mastered.withValues(alpha: 0.4)),
                ),
                child: Text(
                  "${job.matchPercentage}% Match",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mastered,
                  ),
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Text(
            "${job.company} • ${job.location} • ${job.type}",
            style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary),
          ),
          10.verticalSpace,
          Row(
            children: [
              Icon(Icons.payments_outlined, size: 14.r, color: AppColor.accent),
              6.horizontalSpace,
              Text(
                job.salaryRange,
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColor.accent),
              ),
            ],
          ),
          12.verticalSpace,
          Wrap(
            spacing: 6.w,
            children: job.matchingSkills.map((s) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.masteredLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text("✓ $s", style: TextStyle(fontSize: 10.sp, color: AppColor.mastered)),
              );
            }).toList(),
          ),
          14.verticalSpace,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: onTap,
                  child: Text(
                    "View Job Match Details",
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
