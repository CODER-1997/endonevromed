import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../analitics_screen/analitics_screen.dart';
import '../main_menu/dashboard_home.dart';
import '../patient_screen/patient_screen.dart';
import '../procedure_screen/procedure_screen.dart';
import '../settings_screen/settings_screen.dart';

class EndnevromedDashboard extends StatefulWidget {
  const EndnevromedDashboard({Key? key}) : super(key: key);

  @override
  State<EndnevromedDashboard> createState() => _EndnevromedDashboardState();
}

class _EndnevromedDashboardState extends State<EndnevromedDashboard> {
  int _selectedIndex = 0;
  bool _isSidebarExpanded = true;

  late final List<Widget> _pages = [
      DashboardHome(),
    const PatientsScreen(),
    const ProceduresScreen(),
    const AnalyticsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Modern Sidebar
          _buildModernSidebar(),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                 Expanded(
                  child: _buildPageContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Modern Sidebar with Collapsible Feature
  Widget _buildModernSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isSidebarExpanded ? 280 : 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 30,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Area with Toggle
          Container(
            height: 90,
            padding: EdgeInsets.symmetric(
              horizontal: _isSidebarExpanded ? 24 : 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0066FF), Color(0xFF0052CC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.healing_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "EndoNeuro",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
                if (_isSidebarExpanded)
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () => setState(() => _isSidebarExpanded = false),
                    color: const Color(0xFF64748B),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Navigation Items
          _buildNavItem(0, Icons.dashboard_rounded, "Boshqaruv"),
          _buildNavItem(1, Icons.people_rounded, "Bemorlar"),
          _buildNavItem(2, Icons.medical_services_rounded, "Muolajalar"),
          _buildNavItem(3, Icons.analytics_rounded, "Analitika"),
          _buildNavItem(4, Icons.settings_rounded, "Sozlamalar"),

          const Spacer(),

          // Doctor Profile
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "DA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dr. Alisherov",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0066FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Nevrolog",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0066FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Logout Button
          _buildNavItem(5, Icons.logout_rounded, "Chiqish", isLogout: true),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {bool isLogout = false}) {
    bool isSelected = _selectedIndex == index && !isLogout;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!isLogout) {
              setState(() => _selectedIndex = index);
            }
          },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _isSidebarExpanded ? 16 : 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : isLogout
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF64748B),
                  size: 22,
                ),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isLogout
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF475569),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }



  // Page Content with Fade Transition
  Widget _buildPageContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey<int>(_selectedIndex),
        color: const Color(0xFFF8FAFC),
        child: _pages[_selectedIndex],
      ),
    );
  }
}

// --- Modern Screens with Medical CRM Design ---





// Update AppColors class in your constants
class AppColors {
  static const Color background = Color(0xFFF8FAFC);
  static const Color primary = Color(0xFF0066FF);
  static const Color secondary = Color(0xFF10B981);
  static const Color accent = Color(0xFFF59E0B);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
}