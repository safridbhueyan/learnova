import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/navigation_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    final items = [
      _NavItemData(icon: Icons.grid_view_rounded, label: 'Home'),
      _NavItemData(icon: Icons.track_changes_rounded, label: 'Careers'),
      _NavItemData(icon: Icons.alt_route_rounded, label: 'Roadmap'),
      _NavItemData(icon: Icons.play_circle_fill_rounded, label: 'Tutorials'),
      _NavItemData(icon: Icons.auto_awesome_rounded, label: 'Scan & Jobs'),
      _NavItemData(icon: Icons.forum_rounded, label: 'AI Chat'),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.h, top: 4.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColor.cardBg,
            borderRadius: BorderRadius.circular(26.r),
            border: Border.all(color: AppColor.cardBorder, width: 1.w),
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadow,
                blurRadius: 18,
                spreadRadius: 2,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final isSelected = selectedIndex == index;
              final item = items[index];

              return Flexible(
                child: GestureDetector(
                  onTap: () {
                    ref.read(navigationProvider.notifier).setIndex(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColor.primary.withValues(alpha: 0.14) : AppColor.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale: isSelected ? 1.15 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutBack,
                          child: Icon(
                            item.icon,
                            size: 19.r,
                            color: isSelected ? AppColor.primary : AppColor.textMuted,
                          ),
                        ),
                        3.verticalSpace,
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? AppColor.primary : AppColor.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  _NavItemData({required this.icon, required this.label});
}
