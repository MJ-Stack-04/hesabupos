import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/google_controller.dart';
import 'package:hesabuapp/presentation/controllers/register_controller.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';
import 'package:hesabuapp/presentation/widgets/custom_textfield_widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleController googleController = Get.find();

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
              _buildRegisterText(),
              const SizedBox(height: 24),
              _buildFirstNameField(),
              const SizedBox(height: 16),
              _buildLastNameField(),
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPhoneField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 16),
              _buildRepeatPasswordField(),
              const SizedBox(height: 24),
              _buildRegisterButton(context),
              const SizedBox(height: 16),
              _buildOrDivider(),
              const SizedBox(height: 16),
              _buildGoogleButton(context, googleController),
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
            child: GestureDetector(
              onTap: () => Get.offNamed(AppRoutes.login),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: Theme.of(context).primaryColor,
              child: const Text(
                'Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterText() {
    return Text(
      'Create your account',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildFirstNameField() {
    return Obx(() => CustomTextField(
      label: 'First Name',
      hint: 'Enter your first name',
      prefixIcon: Icons.person_outline,
      onChanged: controller.setRegisterFirstName,
      errorText: controller.registerFirstNameError.value.isEmpty ? null : controller.registerFirstNameError.value,
    ));
  }

  Widget _buildLastNameField() {
    return Obx(() => CustomTextField(
      label: 'Last Name',
      hint: 'Enter your last name',
      prefixIcon: Icons.person_outline,
      onChanged: controller.setRegisterLastName,
      errorText: controller.registerLastNameError.value.isEmpty ? null : controller.registerLastNameError.value,
    ));
  }

  Widget _buildEmailField() {
    return Obx(() => CustomTextField(
      label: 'Email',
      hint: 'Enter your email',
      prefixIcon: Icons.email_outlined,
      onChanged: controller.setRegisterEmail,
      errorText: controller.registerEmailError.value.isEmpty ? null : controller.registerEmailError.value,
      keyboardType: TextInputType.emailAddress,
    ));
  }

  Widget _buildPhoneField() {
    return Obx(() => CustomTextField(
      label: 'Phone number',
      hint: '+254 712345678',
      prefixIcon: Icons.phone_outlined,
      onChanged: controller.setRegisterPhone,
      errorText: controller.registerPhoneError.value.isEmpty ? null : controller.registerPhoneError.value,
      keyboardType: TextInputType.phone,
    ));
  }

  Widget _buildPasswordField() {
    return Obx(() => CustomTextField(
      label: 'Password',
      hint: 'input password',
      prefixIcon: Icons.lock_outline,
      suffixIcon: controller.registerObscurePassword.value ? Icons.visibility_off : Icons.visibility,
      onSuffixIconTap: controller.toggleRegisterPasswordVisibility,
      obscureText: controller.registerObscurePassword.value,
      onChanged: controller.setRegisterPassword,
      errorText: controller.registerPasswordError.value.isEmpty ? null : controller.registerPasswordError.value,
    ));
  }

  Widget _buildRepeatPasswordField() {
    return Obx(() => CustomTextField(
      label: 'Repeat password',
      hint: 'Confirm your password',
      prefixIcon: Icons.lock_outline,
      suffixIcon: controller.registerObscureRepeatPassword.value ? Icons.visibility_off : Icons.visibility,
      onSuffixIconTap: controller.toggleRegisterRepeatPasswordVisibility,
      obscureText: controller.registerObscureRepeatPassword.value,
      onChanged: controller.setRegisterRepeatPassword,
      errorText: controller.registerRepeatPasswordError.value.isEmpty ? null : controller.registerRepeatPasswordError.value,
    ));
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Create account',
      onPressed: controller.register,
      isLoading: controller.isRegisterLoading.value,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderRadius: 0,
    ));
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('or', style: TextStyle(color: Colors.grey.shade600)),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildGoogleButton(BuildContext context, GoogleController controller) {
    return Obx(() => OutlinedButton(
      onPressed: controller.isGoogleLoading.value ? null : controller.loginWithGoogle,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: Colors.grey.shade300),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: controller.isGoogleLoading.value
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata),
                SizedBox(width: 12),
                Text('Continue with Google'),
              ],
            ),
    ));
  }

  Widget _buildErrorMessage() {
    return Obx(() => controller.registerGeneralError.value.isNotEmpty
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
            ),
            child: Text(
              controller.registerGeneralError.value,
              style: TextStyle(color: Colors.red.shade700),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        : const SizedBox.shrink());
  }
}