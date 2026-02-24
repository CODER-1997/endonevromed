import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Premium SaaS Palette ---
class AppColors {
  static const sidebarBg = Color(0xFF0F172A); // To'q Slate (Sidebar)
  static const primaryBlue = Color(0xFF0EA5E9); // Tibbiy ko'k
  static const mainBg = Color(0xFFF1F5F9); // Och kulrang fon
  static const cardWhite = Colors.white;
  static const textNavy = Color(0xFF1E293B); // Asosiy matn
  static const textSlate = Color(0xFF64748B); // Ikkinchi darajali matn
  static const accentEmerald = Color(0xFF10B981); // Muvaffaqiyat rangi
}

class EndnevromedDashboard extends StatefulWidget {
  const EndnevromedDashboard({Key? key}) : super(key: key);

  @override
  State<EndnevromedDashboard> createState() => _EndnevromedDashboardState();
}

class _EndnevromedDashboardState extends State<EndnevromedDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      body: Row(
        children: [
          // --- SIDEBAR ---
          _buildSidebar(),

          // --- MAIN CONTENT ---
          Expanded(
            child: Column(
              children: [
                _buildTopAppBar(),
                Expanded(
                  child: _buildBodyContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 1. Sidebar Redesign
  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: AppColors.sidebarBg,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // App Brand
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.health_and_safety, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  "ENDNEUROMED",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _sidebarItem(0, Icons.grid_view_rounded, "Boshqaruv paneli"),
          _sidebarItem(1, Icons.assignment_ind_rounded, "Bemorlar ro'yxati"),
          _sidebarItem(2, Icons.medical_services_rounded, "Muolajalar"),
          _sidebarItem(3, Icons.bar_chart_rounded, "Analitika"),
          _sidebarItem(4, Icons.settings_rounded, "Sozlamalar"),
          const Spacer(),
          // Logout
          _sidebarItem(99, Icons.logout_rounded, "Chiqish", isLogout: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 2. Top Navigation Bar
  Widget _buildTopAppBar() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Row(
        children: [
          Text(
            "Xush kelibsiz, Dr. Alisherov",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textNavy,
            ),
          ),
          const Spacer(),
          // Search box (SaaS style)
          Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.mainBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textSlate, size: 20),
                const SizedBox(width: 8),
                Text("Qidiruv...", style: TextStyle(color: AppColors.textSlate.withOpacity(0.6))),
              ],
            ),
          ),
          const SizedBox(width: 24),
          const Icon(Icons.notifications_none_rounded, color: AppColors.textSlate),
          const SizedBox(width: 24),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=doc'),
          ),
        ],
      ),
    );
  }

  // 3. Body Content
  Widget _buildBodyContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat Cards Grid
          Row(
            children: [
              _buildModernStatCard("Jami Bemorlar", "1,842", "+12%", Icons.people_alt_rounded, AppColors.primaryBlue),
              const SizedBox(width: 24),
              _buildModernStatCard("Bugungi Tashrif", "24", "+4%", Icons.today_rounded, AppColors.accentEmerald),
              const SizedBox(width: 24),
              _buildModernStatCard("Kutilayotgan Foyda", "48.2M", "high", Icons.account_balance_wallet_rounded, Colors.purple),
            ],
          ),
          const SizedBox(height: 32),
          // Tables and Activity
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRecentPatientsTable()),
              const SizedBox(width: 24),
              Expanded(flex: 1, child: _buildQuickActionsCard()),
            ],
          ),
        ],
      ),
    );
  }

  // Sidebar item component
  Widget _sidebarItem(int index, IconData icon, String title, {bool isLogout = false}) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.redAccent : (isSelected ? Colors.white : AppColors.textSlate), size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: isLogout ? Colors.redAccent : (isSelected ? Colors.white : AppColors.textSlate),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modern Stat Card
  Widget _buildModernStatCard(String title, String value, String percent, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 24),
                ),
                Text(percent, style: GoogleFonts.inter(color: AppColors.accentEmerald, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 20),
            Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textNavy)),
            Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textSlate, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPatientsTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Oxirgi qabul qilingan bemorlar", style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          // Simple list acting as table
          ...List.generate(5, (index) => _patientListTile()),
        ],
      ),
    );
  }

  Widget _patientListTile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border:   Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),

      ),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: Color(0xFFF1F5F9), child: Icon(Icons.person, color: AppColors.primaryBlue)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ibragimov Davron", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 15)),
              Text("ID: #48291", style: GoogleFonts.plusJakartaSans(color: AppColors.textSlate, fontSize: 12)),
            ],
          ),
          const Spacer(),
          Text("Nevrologiya", style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textNavy)),
          const SizedBox(width: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.accentEmerald.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Text("To'langan", style: TextStyle(color: AppColors.accentEmerald, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primaryBlue, Color(0xFF0369A1)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tezkor amallar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _actionButton(Icons.add, "Yangi bemor"),
          _actionButton(Icons.calendar_month, "Navbat yozish"),
          _actionButton(Icons.print, "Hisobot yuklash"),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {},
        child: Row(
          children: [Icon(icon, size: 20), const SizedBox(width: 12), Text(text)],
        ),
      ),
    );
  }
}