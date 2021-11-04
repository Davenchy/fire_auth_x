import 'package:fire_auth_x/controllers/auth_controller.dart';
import 'package:fire_auth_x/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => AuthController.instance.signOut(),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return GestureDetector(
                onTap: _changePhoto,
                child: CircleAvatar(
                  radius: 50,
                  child: AuthController.instance.user?.photoURL != null
                      ? Image.network(AuthController.instance.user!.photoURL!)
                      : const Icon(Icons.person, size: 60),
                ),
              );
            }),
            const SizedBox(height: 16),
            Obx(() {
              return Text(
                'Welcome, ${AuthController.instance.user?.displayName ?? 'Unknown'}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _changePhoto() {
    Get.defaultDialog(
      title: 'Change photo',
      content: const Text('Edit your profile photo'),
      actions: [
        TextButton(
          child: const Text('Camera'),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: const Text('Gallery'),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: const Text('Remove', style: TextStyle(color: Colors.red)),
          onPressed: _removePhoto,
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  void _removePhoto() {
    Get.back();
    Get.defaultDialog(
      title: 'Remove photo',
      content: const Text('Remove your profile photo'),
      actions: [
        TextButton(
          child: const Text('Remove', style: TextStyle(color: Colors.red)),
          onPressed: () {
            AuthController.instance.user?.updatePhotoURL(null);
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
