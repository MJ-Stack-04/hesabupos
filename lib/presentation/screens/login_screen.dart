import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/login_controller.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';
import 'package:hesabuapp/presentation/widgets/custom_textfield_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 40),
              _buildToggleButtons(context),
              const SizedBox(height: 32),
              _buildLoginText(),
              const SizedBox(height: 24),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildLoginButton(context),
              const SizedBox(height: 12),
              _buildForgotPassword(context),
              const SizedBox(height: 16),
              _buildErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hesabu',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Get all your business Transactions right',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: Theme.of(context).primaryColor,
              child: const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Get.offNamed(AppRoutes.register),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Registration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginText() {
    return Text(
      'Log in to your account',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildEmailField() {
    return Obx(() => CustomTextField(
      label: 'Email',
      hint: 'input email',
      prefixIcon: Icons.email_outlined,
      onChanged: controller.setEmail,
      errorText: controller.emailError.value.isEmpty ? null : controller.emailError.value,
      keyboardType: TextInputType.emailAddress,
    ));
  }

  Widget _buildPasswordField() {
    return Obx(() => CustomTextField(
      label: 'Password',
      hint: 'input password',
      prefixIcon: Icons.lock_outline,
      suffixIcon: controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
      onSuffixIconTap: controller.togglePasswordVisibility,
      obscureText: controller.obscurePassword.value,
      onChanged: controller.setPassword,
      errorText: controller.passwordError.value.isEmpty ? null : controller.passwordError.value,
    ));
  }

  Widget _buildLoginButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Login to account',
      onPressed: controller.login,
      isLoading: controller.isLoading.value,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderRadius: 0,
    ));
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Get.toNamed(AppRoutes.forgotPassword);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          'Reset password',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Obx(() => controller.generalError.value.isNotEmpty
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
            ),
            child: Text(
              controller.generalError.value,
              style: TextStyle(color: Colors.red.shade700),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        : const SizedBox.shrink());
  }
}