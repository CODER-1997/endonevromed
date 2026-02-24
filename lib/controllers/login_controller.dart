import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;

      // Xavfsiz login: Bo'sh joylarni olib tashlash (trim) va Firebase-ga yuborish
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim() + "@mail.com",
        password: passwordController.text.trim(),
      );

      Get.offAllNamed('/dashboard'); // Dashboard-ga o'tish va orqaga yo'lni yopish
    } on FirebaseAuthException catch (e) {
      String msg = "Xatolik yuz berdi";
      if (e.code == 'user-not-found') msg = "Foydalanuvchi topilmadi";
      if (e.code == 'wrong-password') msg = "Parol noto'g'ri";
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.sentiment_dissatisfied_rounded,
                  color: Colors.redAccent,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Kirishda xatolik",
                  style: TextStyle(
                    fontSize: 18,
                     fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () => Get.back(),
                  child: const Text("Yopish",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}