import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginController, AsyncValue<void>>((ref) => LoginController());

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1)); // mock auth
    state = const AsyncData(null);
  }
}