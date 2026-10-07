import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../../main_navigation/provider/navigation_provider.dart';

class CareerGoalCard extends ConsumerWidget {
  final String careerGoal;
  final int matchPercentage;

  const CareerGoalCard({
    super.key,
    required this.careerGoal,
    required this.matchPercentage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppColor.accent,
                      size: 14.r,
                    ),
                    6.horizontalSpace,
                    Text(
                      "TARGET TRACK",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textOnPrimary,
                        letterSpacing: 0.8.w,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.accent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "$matchPercentage% Match",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textOnPrimary,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            careerGoal,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: AppColor.textOnPrimary,
              height: 1.2,
            ),
          ),
          14.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Skill Mastery: 74%",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColor.textOnPrimary.withValues(alpha: 0.85),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref.read(navigationProvider.notifier).setIndex(1); // Careers tab
                },
                child: Row(
                  children: [
                    Text(
                      "Change Target",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.accent,
                      ),
                    ),
                    4.horizontalSpace,
                    Icon(Icons.arrow_forward_ios_rounded, size: 10.r, color: AppColor.accent),
                  ],
                ),
              ),
            ],
          ),
          8.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: 0.74,
              minHeight: 6.h,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColor.accent),
            ),
          ),
        ],
      ),
    );
  }
}
