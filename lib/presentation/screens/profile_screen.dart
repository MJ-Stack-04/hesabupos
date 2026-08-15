import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
              controller.userName.value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            Obx(() => Text(
              controller.userEmail.value,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            )),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}