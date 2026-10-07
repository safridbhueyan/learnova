import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../../main_navigation/provider/navigation_provider.dart';

class QuickStatsGrid extends ConsumerWidget {
  final int skillProgress;
  final int completedRoadmap;
  final int totalRoadmap;
  final int skillGaps;
  final int jobMatches;

  const QuickStatsGrid({
    super.key,
    required this.skillProgress,
    required this.completedRoadmap,
    required this.totalRoadmap,
    required this.skillGaps,
    required this.jobMatches,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.6,
      children: [
        _buildActionCard(
          id: "hub_ocr",
          icon: Icons.assessment_rounded,
          iconBg: AppColor.primarySubtle,
          iconColor: AppColor.primary,
          title: "Result OCR Scan",
          subtitle: "Detect Tech Stack",
          onTap: () {
            ref.read(navigationProvider.notifier).setIndex(4); // Result OCR & Jobs
          },
        ),
        _buildActionCard(
          id: "hub_gaps",
          icon: Icons.legend_toggle_rounded,
          iconBg: AppColor.accentLight,
          iconColor: AppColor.accent,
          title: "$skillGaps Skill Gaps",
          subtitle: "View Skill Matrix",
          onTap: () {
            ref.read(navigationProvider.notifier).setIndex(1); // Careers & Skill Gap
          },
        ),
        _buildActionCard(
          id: "hub_roadmap",
          icon: Icons.alt_route_rounded,
          iconBg: AppColor.masteredLight,
          iconColor: AppColor.mastered,
          title: "$completedRoadmap/$totalRoadmap Phases",
          subtitle: "Learning Roadmap",
          onTap: () {
            ref.read(navigationProvider.notifier).setIndex(2); // Roadmap
          },
        ),
        _buildActionCard(
          id: "hub_tutorials",
          icon: Icons.play_circle_fill_rounded,
          iconBg: Colors.red.withValues(alpha: 0.15),
          iconColor: Colors.red,
          title: "YouTube Hub",
          subtitle: "Video Tutorials",
          onTap: () {
            ref.read(navigationProvider.notifier).setIndex(3); // Tutorials
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String id,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return BouncyScaleButton(
      id: id,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColor.cardBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.cardBorder, width: 1.w),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: iconColor, size: 18.r),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColor.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
