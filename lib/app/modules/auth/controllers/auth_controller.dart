import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_routes.dart';

/// Controller responsible for handling authentication logic.
///
/// This controller interacts with Supabase for authentication.  It
/// exposes text controllers for email and password fields, an
/// observable loading state, and methods to perform login and logout.
class AuthController extends GetxController {
  /// Controller for the email text field.
  final emailController = TextEditingController();

  /// Controller for the password text field.
  final passwordController = TextEditingController();

  /// Indicates whether a login request is in progress.
  final RxBool isLoading = false.obs;

  /// Attempts to sign the user in using Supabase's password-based auth.
  ///
  /// On success, the login state is stored using [SharedPreferences]
  /// so that the user remains logged in on subsequent launches.  On
  /// failure, an error message is displayed via a snackbar.
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        // Persist login state locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        // Navigate to home and clear previous pages
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'Login Gagal',
          'Email atau password salah',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Login Gagal',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Signs the current user out of Supabase and clears the local login state.
  Future<void> logout() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}