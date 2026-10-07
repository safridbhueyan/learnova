import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to manage press state for BouncyScaleButton without setState
final _buttonPressProvider = NotifierProvider.family<_ButtonPressNotifier, bool, String>(_ButtonPressNotifier.new);

class _ButtonPressNotifier extends FamilyNotifier<bool, String> {
  @override
  bool build(String arg) => false;

  void setPressed(bool pressed) => state = pressed;
}

/// A wrapper widget that animates scale and opacity on entrance.
class ScaleFadeEntrance extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double startScale;
  final Curve curve;

  const ScaleFadeEntrance({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.startScale = 0.88,
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration + delay,
      curve: curve,
      builder: (context, value, childWidget) {
        final opacity = value.clamp(0.0, 1.0);
        final scale = startScale + (1.0 - startScale) * value;

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}

/// A interactive pressable button that scales down on press and springs back on release.
class BouncyScaleButton extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String id;
  final double pressedScale;

  const BouncyScaleButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.id,
    this.pressedScale = 0.94,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPressed = ref.watch(_buttonPressProvider(id));

    return GestureDetector(
      onTapDown: (_) {
        if (onTap != null) {
          ref.read(_buttonPressProvider(id).notifier).setPressed(true);
        }
      },
      onTapUp: (_) {
        if (onTap != null) {
          ref.read(_buttonPressProvider(id).notifier).setPressed(false);
          onTap!();
        }
      },
      onTapCancel: () {
        ref.read(_buttonPressProvider(id).notifier).setPressed(false);
      },
      child: AnimatedScale(
        scale: isPressed ? pressedScale : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}

/// Animated counting text that ticks up smoothly from 0 to target value
class AnimatedCountText extends StatelessWidget {
  final int targetValue;
  final String prefix;
  final String suffix;
  final TextStyle style;
  final Duration duration;

  const AnimatedCountText({
    super.key,
    required this.targetValue,
    this.prefix = "",
    this.suffix = "",
    required this.style,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: targetValue.toDouble()),
      duration: duration,
      curve: Curves.easeOutExpo,
      builder: (context, value, child) {
        return Text(
          "$prefix${value.round()}$suffix",
          style: style,
        );
      },
    );
  }
}

/// Smooth page switcher transition with scale & fade
class CustomAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  const CustomAnimatedSwitcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      reverseDuration: const Duration(milliseconds: 240),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(animation);
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
