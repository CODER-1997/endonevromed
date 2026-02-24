import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Sahifalar va optsiyalar importi
import 'firebase_options.dart';
import 'package:endonevromed/screens/auth/login.dart';
import 'package:endonevromed/screens/dashboard/dashboard.dart';

void main() async {
  // 1. Flutter bog'lamalarini ishga tushirish
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Firebase-ni faqat BIR MARTA va to'g'ri optsiyalar bilan ishga tushirish
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const EndnevromedApp());
}

class EndnevromedApp extends StatelessWidget {
  const EndnevromedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Endnevromed CRM',
      theme: ThemeData(
        useMaterial3: true,
        // Tibbiy brend ranglari (Light Blue & Slate)
        colorSchemeSeed: const Color(0xFF0EA5E9),
        brightness: Brightness.light,
      ),

      // 3. Boshlang'ich sahifa mantiqi
      home: const AuthWrapper(),

      // 4. GetX marshrutlari
      getPages: [
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/dashboard', page: () => const EndnevromedDashboard()),
      ],
    );
  }
}

// 5. AuthWrapper: Tizimga kirish holatini doimiy kuzatuvchi kichik vidjet
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Yuklanish jarayoni
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        // Foydalanuvchi tizimda bo'lsa Dashboard-ga
        if (snapshot.hasData) {
          return const EndnevromedDashboard();
        }

        // Aks holda Login sahifasiga
        return const LoginView();
      },
    );
  }
}