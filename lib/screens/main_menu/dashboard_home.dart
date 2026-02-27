import 'package:endonevromed/screens/main_menu/widgets/add_new_patient_modal_shhet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('EEEE, d MMMM').format(DateTime.now());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // BuildContext uzatildi
          _buildSliverAppBar(context, isDark),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildHeader(currentDate, context, isDark),
                const SizedBox(height: 28),
                _buildMetricsGrid(isDark),
                const SizedBox(height: 32),
                _buildSectionHeader("Bugungi qabullar", "Barchasini ko'rish", isDark),
                const SizedBox(height: 16),
                _buildScheduleTable(isDark),
                const SizedBox(height: 24),
                _buildSectionHeader("So'nggi bemorlar", "Barchasini ko'rish", isDark),
                const SizedBox(height: 16),
                _buildRecentPatients(isDark),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - App Bar (Context xatosi tuzatildi)
  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)).withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "EN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Qidirish...",
                  hintStyle: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                style: GoogleFonts.plusJakartaSans(
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Yangi bemor tugmasi - showAddPatientSheet ulandi
          _buildGradientButton(
            onPressed: () => showAddPatientDialog(context),
            icon: Icons.add_rounded,
            label: "Yangi bemor",
            isDark: isDark,
          ),
          const SizedBox(width: 8),
          _buildFilterButton(isDark),
          const SizedBox(width: 8),
          _buildIconButton(Icons.notifications_none_rounded, isDark, hasBadge: true),
          const SizedBox(width: 8),
          _buildIconButton(Icons.settings_outlined, isDark),
          const SizedBox(width: 16),
          _buildDoctorProfile(isDark),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.filter_list_rounded,
                  size: 18,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                ),
                const SizedBox(width: 4),
                Text(
                  "Filter",
                  style: TextStyle(
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, bool isDark, {bool hasBadge = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0),
            ),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 20,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
            ),
            onPressed: () {},
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        if (hasBadge)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? const Color(0xFF1E293B) : Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDoctorProfile(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://ui-avatars.com/api/?name=Dr+Alisherov&background=2563EB&color=fff&bold=true',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Dr. Alisherov",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              Text(
                "Neurologist",
                style: GoogleFonts.plusJakartaSans(
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String date, BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(fontSize: 22),
                children: [
                  TextSpan(
                    text: "Xush kelibsiz, ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                    ),
                  ),
                  TextSpan(
                    text: "Dr. Alisherov",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  TextSpan(
                    text: " 👋",
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF1E293B)]
                      : [const Color(0xFFEFF6FF), const Color(0xFFEEF2FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFCBD5E1).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 16,
                    color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildQuickStat(Icons.people_alt_rounded, "12.8k", "Bemorlar", isDark),
              Container(
                height: 30,
                width: 1,
                color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              _buildQuickStat(Icons.today_rounded, "8", "Bugun", isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStat(IconData icon, String value, String label, bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF2563EB)),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(bool isDark) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _buildEnhancedMetricCard("Jami Bemorlar", "12,847", "+12.5%", Icons.people_alt_rounded, const Color(0xFF2563EB), true, isDark),
        _buildEnhancedMetricCard("Qabullar", "452", "+3.2%", Icons.calendar_month_rounded, const Color(0xFF10B981), true, isDark),
        _buildEnhancedMetricCard("Tushum", "₽42.5k", "+18.4%", Icons.account_balance_wallet_rounded, const Color(0xFF8B5CF6), true, isDark),
        _buildEnhancedMetricCard("Konsultatsiya", "84", "-2.1%", Icons.medical_services_rounded, const Color(0xFFF59E0B), false, isDark),
      ],
    );
  }

  Widget _buildEnhancedMetricCard(String title, String value, String change, IconData icon, Color color, bool isPositive, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8)),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                change,
                style: TextStyle(color: isPositive ? Colors.green.shade700 : Colors.red.shade700, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)),
          ),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF0F172A))),
        TextButton(onPressed: () {}, child: Text(action, style: const TextStyle(fontWeight: FontWeight.w600))),
      ],
    );
  }

  Widget _buildScheduleTable(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: Text("Jadval ma'lumotlari yuklanmoqda...")),
      ),
    );
  }

  Widget _buildRecentPatients(bool isDark) {
    return const SizedBox(height: 100, child: Center(child: Text("Bemorlar ro'yxati")));
  }

  Widget _buildEnhancedAppointmentTile(Map<String, dynamic> app, bool isDark) {
    return const ListTile();
  }

  Widget _buildEnhancedStatusChip(String status, bool isDark) {
    return const SizedBox();
  }

  Widget _buildEnhancedFilterChip(String label, bool isSelected, bool isDark) {
    return const SizedBox();
  }

  IconData _getStatusIcon(String status) => Icons.circle;
  Color _getStatusColor(String status) => Colors.grey;
}