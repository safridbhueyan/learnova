import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/career_path_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class CareerDetailModal extends StatelessWidget {
  final CareerPathModel career;

  const CareerDetailModal({super.key, required this.career});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColor.surfaceLight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              career.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            6.verticalSpace,
            Text(
              "${career.category} • ${career.compatibilityScore}% Compatibility",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColor.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            16.verticalSpace,
            Text(
              "Your Strengths for this Role:",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.mastered),
            ),
            8.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: career.studentStrengths.map((strength) {
                return Chip(
                  backgroundColor: AppColor.mastered.withValues(alpha: 0.15),
                  side: BorderSide(color: AppColor.mastered.withValues(alpha: 0.4)),
                  label: Text("✓ $strength", style: TextStyle(color: AppColor.mastered, fontSize: 11.sp)),
                );
              }).toList(),
            ),
            16.verticalSpace,
            Text(
              "Required Missing Skills:",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.missing),
            ),
            8.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: career.missingSkills.map((missing) {
                return Chip(
                  backgroundColor: AppColor.missing.withValues(alpha: 0.15),
                  side: BorderSide(color: AppColor.missing.withValues(alpha: 0.4)),
                  label: Text("○ $missing", style: TextStyle(color: AppColor.missing, fontSize: 11.sp)),
                );
              }).toList(),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
