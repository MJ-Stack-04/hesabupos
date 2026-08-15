import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/otp_controller.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

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
              _buildTitle(),
              const SizedBox(height: 16),
              _buildSubtitle(),
              const SizedBox(height: 32),
              _buildOtpFields(),
              const SizedBox(height: 24),
              _buildResendButton(),
              const SizedBox(height: 32),
              _buildVerifyButton(context),
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

  Widget _buildTitle() {
    return Text(
      'Enter Verification Code',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Obx(() => Text(
      'We sent a 6-digit verification code to ${controller.email.value}',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
      textAlign: TextAlign.center,
    ));
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) => _buildOtpField(index)),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(Get.context!).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(Get.context!).previousFocus();
          }
          final currentCode = controller.otpCode.value;
          List<String> codeChars = currentCode.split('');
          if (value.length == 1) {
            if (codeChars.length > index) {
              codeChars[index] = value;
            } else {
              codeChars.add(value);
            }
          } else if (value.isEmpty && codeChars.length > index) {
            codeChars.removeAt(index);
          }
          controller.setOtpCode(codeChars.join());
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: Theme.of(Get.context!).primaryColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't get a code? ",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        TextButton(
          onPressed: controller.isSendingOtp.value ? null : controller.resendOtp,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: controller.isSendingOtp.value
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  'Resend',
                  style: TextStyle(
                    color: Theme.of(Get.context!).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ],
    ));
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Verify',
      onPressed: controller.verifyOtp,
      isLoading: controller.isVerifyingOtp.value,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderRadius: 0,
    ));
  }

  Widget _buildErrorMessage() {
    return Obx(() => controller.otpError.value.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
            ),
            child: Text(
              controller.otpError.value,
              style: TextStyle(color: Colors.red.shade700),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        : const SizedBox.shrink());
  }
}