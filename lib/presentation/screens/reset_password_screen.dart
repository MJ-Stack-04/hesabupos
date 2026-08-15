import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/reset_password_controller.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';
import 'package:hesabuapp/presentation/widgets/custom_textfield_widget.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 16),
              _buildSubtitle(),
              const SizedBox(height: 32),
              _buildOtpField(),
              const SizedBox(height: 16),
              _buildNewPasswordField(),
              const SizedBox(height: 16),
              _buildConfirmPasswordField(),
              const SizedBox(height: 24),
              _buildResetButton(context),
              const SizedBox(height: 16),
              _buildErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Reset Password',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Enter the OTP from your email',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildOtpField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'OTP Code',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Enter OTP from email',
          prefixIcon: Icons.security_outlined,
          onChanged: controller.setOtp,
          errorText: controller.otpError.value.isEmpty ? null : controller.otpError.value,
          keyboardType: TextInputType.number,
        ),
      ],
    ));
  }

  Widget _buildNewPasswordField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New Password',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Enter new password',
          prefixIcon: Icons.lock_outline,
          suffixIcon: controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
          onSuffixIconTap: controller.togglePasswordVisibility,
          obscureText: controller.obscurePassword.value,
          onChanged: controller.setNewPassword,
          errorText: controller.newPasswordError.value.isEmpty ? null : controller.newPasswordError.value,
        ),
      ],
    ));
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirm Password',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Confirm your new password',
          prefixIcon: Icons.lock_outline,
          suffixIcon: controller.obscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
          onSuffixIconTap: controller.toggleConfirmPasswordVisibility,
          obscureText: controller.obscureConfirmPassword.value,
          onChanged: controller.setConfirmPassword,
          errorText: controller.confirmPasswordError.value.isEmpty ? null : controller.confirmPasswordError.value,
        ),
      ],
    ));
  }

  Widget _buildResetButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Reset Password',
      onPressed: controller.resetPassword,
      isLoading: controller.isLoading.value,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderRadius: 8,
    ));
  }

  Widget _buildErrorMessage() {
    return Obx(() => controller.generalError.value.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              controller.generalError.value,
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          )
        : const SizedBox.shrink());
  }
}