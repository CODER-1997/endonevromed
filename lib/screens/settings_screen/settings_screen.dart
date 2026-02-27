import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 32),

            // Settings Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - Settings Navigation/Categories
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildProfileCard(),
                      const SizedBox(height: 24),
                      _buildSettingsCategories(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),

                // Right Column - Settings Details
                Expanded(
                  flex: 7,
                  child: _buildSettingsDetails(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sozlamalar",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Tizim sozlamalari va profil ma'lumotlarini boshqaring",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Icon(Icons.save_rounded, size: 20, color: const Color(0xFF2563EB)),
              const SizedBox(width: 8),
              Text(
                "Saqlash",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    "DA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 16,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            "Dr. Alisherov",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Nevrolog • Senior Shifokor",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileStat("245", "Bemorlar"),
              Container(width: 1, height: 30, color: const Color(0xFFE2E8F0)),
              _buildProfileStat("4.9", "Reyting"),
              Container(width: 1, height: 30, color: const Color(0xFFE2E8F0)),
              _buildProfileStat("5", "Yillik"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCategories() {
    final categories = [
      {"icon": Icons.person_rounded, "name": "Profil", "count": "3", "selected": true},
      {"icon": Icons.notifications_rounded, "name": "Bildirishnomalar", "count": "5", "selected": false},
      {"icon": Icons.security_rounded, "name": "Xavfsizlik", "count": "2", "selected": false},
      {"icon": Icons.palette_rounded, "name": "Tashqi ko'rinish", "count": "", "selected": false},
      {"icon": Icons.language_rounded, "name": "Til va Mintaqa", "count": "", "selected": false},
      {"icon": Icons.backup_rounded, "name": "Zaxiralash", "count": "", "selected": false},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kategoriyalar",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          ...categories.map((cat) => _buildCategoryItem(
            icon: cat["icon"] as IconData,
            name: cat["name"] as String,
            count: cat["count"] as String,
            selected: cat["selected"] as bool,
          )),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String name,
    required String count,
    required bool selected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF2563EB).withOpacity(0.04) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: selected ? const Color(0xFF2563EB) : const Color(0xFF64748B), size: 22),
        title: Text(
          name,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? const Color(0xFF2563EB) : const Color(0xFF475569),
          ),
        ),
        trailing: count.isNotEmpty
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFEF4444),
            ),
          ),
        )
            : null,
        onTap: () {},
      ),
    );
  }

  Widget _buildSettingsDetails() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profil Sozlamalari",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Shaxsiy ma'lumotlaringizni boshqaring",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 32),

          _buildTextField("To'liq ism", "Dr. Alisherov"),
          const SizedBox(height: 20),
          _buildTextField("Email", "dr.alisherov@endoneuro.uz"),
          const SizedBox(height: 20),
          _buildTextField("Telefon", "+998 90 123 45 67"),
          const SizedBox(height: 20),
          _buildTextField("Mutaxassislik", "Nevrologiya"),
          const SizedBox(height: 24),

          Divider(color: const Color(0xFFE2E8F0)),
          const SizedBox(height: 24),

          // Two column layout for additional info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ish vaqti",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildWorkingHours(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Xabar berish usuli",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationMethod(),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("O'zgarishlarni saqlash"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: const Text("Bekor qilish"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextFormField(
            initialValue: value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              color: const Color(0xFF1E293B),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHours() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _buildTimeRow("Dushanba - Juma", "09:00 - 18:00"),
          const SizedBox(height: 12),
          _buildTimeRow("Shanba", "10:00 - 15:00"),
          const SizedBox(height: 12),
          _buildTimeRow("Yakshanba", "Dam olish"),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String day, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: const Color(0xFF475569),
          ),
        ),
        Text(
          time,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: time == "Dam olish"
                ? const Color(0xFFEF4444)
                : const Color(0xFF2563EB),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationMethod() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _buildNotificationOption("SMS", true),
          const SizedBox(height: 12),
          _buildNotificationOption("Telegram", false),
          const SizedBox(height: 12),
          _buildNotificationOption("Email", true),
        ],
      ),
    );
  }

  Widget _buildNotificationOption(String method, bool enabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          method,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: const Color(0xFF475569),
          ),
        ),
        Switch(
          value: enabled,
          onChanged: (value) {},
          activeColor: const Color(0xFF2563EB),
          activeTrackColor: const Color(0xFF2563EB).withOpacity(0.3),
          inactiveTrackColor: const Color(0xFFE2E8F0),
        ),
      ],
    );
  }
}

// Additional Security Settings Section (can be added to the right column when selected)
class SecuritySettings extends StatelessWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xavfsizlik Sozlamalari",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Hisobingiz xavfsizligini boshqaring",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 32),

          _buildSecurityOption(
            icon: Icons.lock_rounded,
            title: "Parolni o'zgartirish",
            subtitle: "Oxirgi o'zgartirish: 2 oy oldin",
          ),
          const Divider(height: 32),
          _buildSecurityOption(
            icon: Icons.fingerprint_rounded,
            title: "Ikki bosqichli autentifikatsiya",
            subtitle: "Hisobingiz xavfsizligini oshiring",
            trailing: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: const Color(0xFF2563EB),
            ),
          ),
          const Divider(height: 32),
          _buildSecurityOption(
            icon: Icons.devices_rounded,
            title: "Faol seanslar",
            subtitle: "2 ta qurilma: iPhone 15, MacBook Pro",
          ),
          const Divider(height: 32),
          _buildSecurityOption(
            icon: Icons.history_rounded,
            title: "Kirish tarixi",
            subtitle: "Oxirgi 30 kunlik faollik",
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB).withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: const Color(0xFF2563EB), size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
        if (trailing == null)
          Icon(Icons.arrow_forward_rounded, size: 20, color: const Color(0xFF64748B)),
      ],
    );
  }
}