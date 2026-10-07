import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/student_profile_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final StudentProfileModel student;

  const ProfileHeaderWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColor.primary,
                child: Text(
                  student.name.isNotEmpty ? student.name[0] : "S",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textOnPrimary,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimary,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      student.email,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.textSecondary,
                      ),
                    ),
                    8.verticalSpace,
                    Wrap(
                      spacing: 8.w,
                      children: [
                        _buildBadge(student.university, AppColor.primary),
                        _buildBadge("CGPA: ${student.cgpa}", AppColor.mastered),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          16.verticalSpace,
          const Divider(color: AppColor.surfaceLight),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Target Career Path:",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.textSecondary,
                ),
              ),
              8.horizontalSpace,
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    gradient: AppColor.primaryGradient,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    student.targetCareer,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textOnPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 0.8.w),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
