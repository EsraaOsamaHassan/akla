import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isLoading;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;

  const LoginState({
    this.isLoading = false,
    this.isPasswordHidden = true,
    this.isConfirmPasswordHidden = true,
  });


  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
    );
  }
}


final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);


class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();


  void togglePassword() {
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  void toggleConfirmPassword() {
    state = state.copyWith(isConfirmPasswordHidden: !state.isConfirmPasswordHidden);
  }

  Future<String?> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isLoading: false);
    return null;
  }

  Future<String?> signUp({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isLoading: false);
    return null;
  }
}
