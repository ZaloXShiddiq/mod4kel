import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_routes.dart';

/// Controller responsible for user registration.
///
/// This controller collects email, password and confirmation password
/// from the user. It then calls Supabase's `signUp` method to create a
/// new user. On successful registration, the user is redirected to
/// the login page. A loading state is exposed via an RxBool.
class RegisterController extends GetxController {
  /// Controller for the email text field.
  final emailController = TextEditingController();

  /// Controller for the password text field.
  final passwordController = TextEditingController();

  /// Controller for the password confirmation text field.
  final confirmController = TextEditingController();

  /// Indicates whether a registration request is in progress.
  final RxBool isLoading = false.obs;

  /// Attempts to sign the user up with Supabase.
  ///
  /// Validates that the password and confirmation match. On error
  /// displays a snackbar. On success redirects to the login page.
  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmController.text.trim();
    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua kolom harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (password != confirm) {
      Get.snackbar(
        'Error',
        'Password dan konfirmasi tidak sama',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    isLoading.value = true;
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        Get.snackbar(
          'Registrasi Berhasil',
          'Silakan login dengan akun baru',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar(
          'Registrasi Gagal',
          'Tidak dapat membuat akun',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Registrasi Gagal',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}