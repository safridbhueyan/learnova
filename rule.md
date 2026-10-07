# Project Architectural & Coding Rules

## 1. State Management (STRICT)
- **NO `setState()`**: Do NOT use `setState()` in any widget across the project.
- **Use Riverpod**: ALWAYS use Flutter Riverpod (`ConsumerWidget`, `ConsumerStatefulWidget`, `ref.watch`, `ref.read`) for state management.
- **Providers**: Create state notifiers using `Notifier<T>` and expose them via `NotifierProvider<NotifierClass, T>(NotifierClass.new)`.

## 2. Color Styling
- **AppColor**: ALWAYS use colors from `AppColor` located in `lib/src/core/theme/theme_extension/color_scheme.dart`.
- Do NOT hardcode colors directly in widgets unless defining brand tokens in `AppColor`.


## 4. Folder Structure Standards
Each feature screen directory under `lib/src/features/screens/` must follow this structure:
```
feature_name/
├── feature_screen.dart        # Main screen widget
├── widgets/                   # Sub-folder for reusable UI component widgets
└── provider/                  # Sub-folder for Riverpod providers
```

## 5. Responsive Layouts
- **ScreenUtil**: ALWAYS use `flutter_screenutil` extensions (`.w`, `.h`, `.sp`, `.r`, `.verticalSpace`, `.horizontalSpace`) for layout dimensions and padding.
