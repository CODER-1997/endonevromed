import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  // Palette
  static const Color kPageBg = Color(0xFFF0F4F8); // Soft light grey background
  static const Color kCardBg = Colors.white;
  static const Color kPrimary = Color(0xFF3B82F6); // Blue accent
  static const Color kSecondary = Color(0xFF60A5FA); // Lighter blue
  static const Color kText = Color(0xFF1E293B);
  static const Color kTextSecondary = Color(0xFF64748B);
  static const Color kInputBg = Colors.white;
  static const Color kBorder = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: kPageBg,
      body: Stack(
        children: [
          // Floating medical icons in background
          Positioned.fill(child: _buildBackgroundIcons()),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                  decoration: BoxDecoration(
                    color: kCardBg,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 25,
                        offset: const Offset(0, 15),
                      ),
                      BoxShadow(
                        color: kPrimary.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: kPrimary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.local_hospital_rounded, color: kPrimary, size: 40),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "MediCRM",
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: kText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Sog‘liqni saqlash tizimiga kirish",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: kTextSecondary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Login Field
                      _inputField(
                        label: "Login",
                        controller: controller.emailController,
                        hint: "Email yoki Login",
                        icon: Icons.badge_outlined,
                      ),
                      const SizedBox(height: 24),

                      // Password Field
                      Obx(
                            () => _inputField(
                          label: "Parol",
                          controller: controller.passwordController,
                          hint: "••••••••",
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscure: !controller.isPasswordVisible.value,
                          onTap: controller.isPasswordVisible.toggle,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Login Button
                      Obx(
                            () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                              : Text(
                            "TIZIMGA KIRISH",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Footer
                      Text(
                        "Premium MediCRM v2.0",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: kTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: kTextSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: kInputBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: kPrimary.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.inter(
              color: kText,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(color: kTextSecondary.withOpacity(0.6)),
              prefixIcon: Icon(icon, color: kPrimary, size: 22),
              suffixIcon: isPassword
                  ? IconButton(
                onPressed: onTap,
                icon: Icon(
                  obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: kTextSecondary,
                  size: 20,
                ),
              )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundIcons() {
    // Floating semi-transparent medical icons
    return Stack(
      children: [
        Positioned(top: 50, left: 30, child: Icon(Icons.local_hospital_rounded, size: 60, color: kPrimary.withOpacity(0.1))),
        Positioned(top: 200, right: 40, child: Icon(Icons.health_and_safety_rounded, size: 80, color: kSecondary.withOpacity(0.1))),
        Positioned(bottom: 100, left: 50, child: Icon(Icons.medical_services_rounded, size: 70, color: kPrimary.withOpacity(0.08))),
        Positioned(bottom: 200, right: 80, child: Icon(Icons.favorite_rounded, size: 60, color: kSecondary.withOpacity(0.08))),
      ],
    );
  }
}