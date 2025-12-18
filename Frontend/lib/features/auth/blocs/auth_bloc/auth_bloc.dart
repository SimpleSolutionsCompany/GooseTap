import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goose_tap/api/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginTelegramRequested>(_onAuthLoginTelegramRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthRetryRequested>(_onAuthRetryRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final token = _authRepository.getAccessToken();
    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLoginTelegramRequested(
    AuthLoginTelegramRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.loginTelegram(event.initData);
      emit(AuthAuthenticated());
    } catch (e) {
      log("Login failed: $e");
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.clearTokens();
    emit(AuthUnauthenticated());
  }

  Future<void> _onAuthRetryRequested(
    AuthRetryRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.reAuthenticate();
      emit(AuthAuthenticated());
    } catch (e) {
      log("Retry login failed: $e");
      emit(AuthFailure(message: e.toString()));
    }
  }
}
