import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/learning_resources_provider.dart';

class CategoryChipFilter extends ConsumerWidget {
  const CategoryChipFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCategory = ref.watch(learningResourcesProvider.select((s) => s.activeCategory));

    final categories = [
      "All",
      "Flutter & Dart",
      "Riverpod",
      "Clean Architecture",
      "REST API & Dio",
      "Testing",
      "Firebase & Cloud",
    ];

    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => 8.horizontalSpace,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = activeCategory == cat;

          return InkWell(
            onTap: () {
              ref.read(learningResourcesProvider.notifier).setCategory(cat);
            },
            borderRadius: BorderRadius.circular(20.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primary : AppColor.chipBackground,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColor.primary : AppColor.cardBorder,
                  width: 1.w,
                ),
              ),
              child: Center(
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColor.textOnPrimary : AppColor.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
