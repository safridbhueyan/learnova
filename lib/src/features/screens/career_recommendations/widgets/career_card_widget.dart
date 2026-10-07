import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/career_path_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class CareerCardWidget extends StatelessWidget {
  final CareerPathModel career;
  final bool isSelectedTarget;
  final VoidCallback onTap;
  final VoidCallback onSelectAsTarget;

  const CareerCardWidget({
    super.key,
    required this.career,
    required this.isSelectedTarget,
    required this.onTap,
    required this.onSelectAsTarget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelectedTarget ? AppColor.primary : AppColor.cardBorder,
          width: isSelectedTarget ? 2.w : 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  career.title,
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
                  gradient: AppColor.accentGradient,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "${career.compatibilityScore}% Match",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textOnPrimary,
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Row(
            children: [
              Icon(Icons.category_outlined, size: 14.r, color: AppColor.textMuted),
              4.horizontalSpace,
              Text(
                career.category,
                style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary),
              ),
              12.horizontalSpace,
              Icon(Icons.trending_up, size: 14.r, color: AppColor.mastered),
              4.horizontalSpace,
              Text(
                "Demand: ${career.demandLevel}",
                style: TextStyle(fontSize: 11.sp, color: AppColor.mastered, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            career.description,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.textSecondary,
              height: 1.35,
            ),
          ),
          14.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.cardBorder),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: onTap,
                  child: Text(
                    "View Skill Analysis",
                    style: TextStyle(fontSize: 11.sp, color: AppColor.textPrimary),
                  ),
                ),
              ),
              10.horizontalSpace,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelectedTarget ? AppColor.mastered : AppColor.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                onPressed: onSelectAsTarget,
                child: Text(
                  isSelectedTarget ? "Target Selected ✓" : "Set as Target",
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
