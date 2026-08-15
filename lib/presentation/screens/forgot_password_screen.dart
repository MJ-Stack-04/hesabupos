import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/forgot_password_controller.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';
import 'package:hesabuapp/presentation/widgets/custom_textfield_widget.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

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
              _buildEmailField(),
              const SizedBox(height: 24),
              _buildSendButton(context),
              const SizedBox(height: 16),
              _buildBackToLogin(),
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
      'Forgot Password?',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'No worries. We\'ll send you reset instructions.',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Enter your email address',
          prefixIcon: Icons.email_outlined,
          onChanged: controller.setEmail,
          errorText: controller.emailError.value.isEmpty ? null : controller.emailError.value,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    ));
  }

  Widget _buildSendButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Reset Password',
      onPressed: controller.requestReset,
      isLoading: controller.isLoading.value,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderRadius: 8,
    ));
  }

  Widget _buildBackToLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Remember your password? "),
        TextButton(
          onPressed: () => Get.offAllNamed(AppRoutes.login),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Text(
            'Back to Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ),
      ],
    );
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