import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoginMode;
  final String email;
  final String password;
  final String name;
  final String university;
  final String department;
  final String semester;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({
    required this.isAuthenticated,
    required this.isLoginMode,
    required this.email,
    required this.password,
    required this.name,
    required this.university,
    required this.department,
    required this.semester,
    this.errorMessage,
    required this.isLoading,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoginMode,
    String? email,
    String? password,
    String? name,
    String? university,
    String? department,
    String? semester,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoginMode: isLoginMode ?? this.isLoginMode,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      university: university ?? this.university,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState(
      isAuthenticated: false, // Opens Auth Screen directly on launch
      isLoginMode: true,
      email: "safrid.student@university.edu",
      password: "",
      name: "Safrid Bhueyan",
      university: "UITS",
      department: "CSE",
      semester: "7th Semester",
      isLoading: false,
    );
  }

  void toggleAuthMode() {
    state = state.copyWith(isLoginMode: !state.isLoginMode);
  }

  void login(String email, String password) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 600), () {
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        email: email,
      );
    });
  }

  void register({
    required String name,
    required String university,
    required String department,
    required String semester,
    required String email,
    required String password,
  }) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 600), () {
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        name: name,
        university: university,
        department: department,
        semester: semester,
        email: email,
      );
    });
  }

  void logout() {
    state = state.copyWith(isAuthenticated: false);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
