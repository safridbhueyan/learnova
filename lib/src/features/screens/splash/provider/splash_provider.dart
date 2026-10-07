import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashState {
  final bool isInitialized;
  final String statusMessage;

  const SplashState({
    required this.isInitialized,
    required this.statusMessage,
  });

  SplashState copyWith({
    bool? isInitialized,
    String? statusMessage,
  }) {
    return SplashState(
      isInitialized: isInitialized ?? this.isInitialized,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}

class SplashNotifier extends Notifier<SplashState> {
  @override
  SplashState build() {
    _startInitializationSequence();
    return const SplashState(
      isInitialized: false,
      statusMessage: "Initializing AI Recommendation Engine...",
    );
  }

  void _startInitializationSequence() {
    Future.delayed(const Duration(milliseconds: 700), () {
      state = state.copyWith(statusMessage: "Loading Student Skill Matrix...");
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      state = state.copyWith(statusMessage: "Connecting to Learnova Cloud...");
    });

    Future.delayed(const Duration(milliseconds: 2100), () {
      state = state.copyWith(isInitialized: true, statusMessage: "Ready!");
    });
  }
}

final splashProvider = NotifierProvider<SplashNotifier, SplashState>(SplashNotifier.new);
