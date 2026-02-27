import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProceduresScreen extends StatelessWidget {
  const ProceduresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with action buttons
            _buildHeader(),
            const SizedBox(height: 32),

            // Quick stats for procedures
            _buildStatsRow(),
            const SizedBox(height: 32),

            // Categories and Procedures Grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - Categories
                Expanded(
                  flex: 3,
                  child: _buildCategoriesCard(),
                ),
                const SizedBox(width: 24),

                // Right Column - Procedures List
                Expanded(
                  flex: 7,
                  child: _buildProceduresList(),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Today's Schedule
            _buildTodaySchedule(),
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
              "Muolajalar",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Barcha tibbiy muolajalar va xizmatlar ro'yxati",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 20, color: const Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Text(
                    "Qidirish...",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded, size: 20),
              label: Text(
                "Yangi Muolaja",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Jami Muolajalar",
            value: "156",
            change: "+12",
            icon: Icons.medical_services_rounded,
            color: const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildStatCard(
            title: "Bugungi",
            value: "24",
            change: "+8",
            icon: Icons.today_rounded,
            color: const Color(0xFF10B981),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildStatCard(
            title: "Kutilayotgan",
            value: "18",
            change: "-3",
            icon: Icons.schedule_rounded,
            color: const Color(0xFFF59E0B),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildStatCard(
            title: "Kategoriyalar",
            value: "12",
            change: "+2",
            icon: Icons.category_rounded,
            color: const Color(0xFF8B5CF6),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      value,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: change.startsWith('+')
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        change,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: change.startsWith('+')
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesCard() {
    final categories = [
      {"name": "MRI Tekshiruvi", "count": "24", "icon": Icons.memory_rounded, "color": const Color(0xFF2563EB)},
      {"name": "Fizioterapiya", "count": "18", "icon": Icons.fitness_center_rounded, "color": const Color(0xFF10B981)},
      {"name": "Laboratoriya", "count": "32", "icon": Icons.science_rounded, "color": const Color(0xFFF59E0B)},
      {"name": "Konsultatsiya", "count": "45", "icon": Icons.chat_rounded, "color": const Color(0xFF8B5CF6)},
      {"name": "Massaj", "count": "12", "icon": Icons.spa_rounded, "color": const Color(0xFFEC4899)},
      {"name": "Ultra-tovush", "count": "15", "icon": Icons.surround_sound, "color": const Color(0xFF6366F1)},
      {"name": "Rentgen", "count": "8", "icon": Icons.radar_rounded, "color": const Color(0xFFEF4444)},
      {"name": "Stomatologiya", "count": "22", "icon": Icons.health_and_safety_rounded, "color": const Color(0xFF14B8A6)},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kategoriyalar",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Barchasi",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...categories.map((cat) => _buildCategoryItem(
            name: cat["name"] as String,
            count: cat["count"] as String,
            icon: cat["icon"] as IconData,
            color: cat["color"] as Color,
          )),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required String name,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              count,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceduresList() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mavjud Muolajalar",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sort_rounded, size: 14, color: const Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Text(
                      "Narx bo'yicha",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Procedures List
          ...List.generate(6, (index) => _buildProcedureItem(index)),
        ],
      ),
    );
  }

  Widget _buildProcedureItem(int index) {
    final procedures = [
      {
        "name": "MRI (Magnit-rezonans tomografiya)",
        "category": "Tekshiruv",
        "price": "850 000 so'm",
        "duration": "45 min",
        "doctors": 4,
        "status": "active"
      },
      {
        "name": "Fizioterapiya seansi",
        "category": "Davolash",
        "price": "250 000 so'm",
        "duration": "60 min",
        "doctors": 3,
        "status": "active"
      },
      {
        "name": "Umumiy qon tahlili",
        "category": "Laboratoriya",
        "price": "80 000 so'm",
        "duration": "15 min",
        "doctors": 2,
        "status": "active"
      },
      {
        "name": "Nevrolog konsultatsiyasi",
        "category": "Konsultatsiya",
        "price": "200 000 so'm",
        "duration": "30 min",
        "doctors": 5,
        "status": "active"
      },
      {
        "name": "Terapevtik massaj",
        "category": "Massaj",
        "price": "180 000 so'm",
        "duration": "50 min",
        "doctors": 2,
        "status": "inactive"
      },
      {
        "name": "Ultratovush tekshiruvi",
        "category": "Tekshiruv",
        "price": "320 000 so'm",
        "duration": "25 min",
        "doctors": 3,
        "status": "active"
      },
    ];

    final procedure = procedures[index];
    bool isActive = procedure["status"] == "active";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? const Color(0xFFE2E8F0) : const Color(0xFFEF4444).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // Procedure Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isActive
                    ? [const Color(0xFF2563EB), const Color(0xFF3B82F6)]
                    : [const Color(0xFF94A3B8), const Color(0xFF64748B)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Procedure Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        procedure["name"] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isActive ? "Faol" : "Faol emas",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Tags Row
                Wrap(
                  spacing: 8,
                  children: [
                    _buildInfoTag(Icons.category_rounded, procedure["category"] as String),
                    _buildInfoTag(Icons.access_time_rounded, procedure["duration"] as String),
                    _buildInfoTag(Icons.people_rounded, "${procedure["doctors"]} ta shifokor"),
                  ],
                ),
                const SizedBox(height: 8),

                // Price
                Text(
                  procedure["price"] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {},
                color: const Color(0xFF64748B),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded, size: 20),
                onPressed: () {},
                color: const Color(0xFF64748B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySchedule() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.schedule_rounded, color: Color(0xFFF59E0B), size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bugungi Muolajalar",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "24-fevral, 2026 | 12 ta rejalashtirilgan",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Barchasini ko'rish",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Schedule List
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildScheduleTimeSlot("09:00", "MRI", "Karimov A.", const Color(0xFF2563EB), true),
                const SizedBox(width: 12),
                _buildScheduleTimeSlot("10:30", "Fizioterapiya", "Rustamova N.", const Color(0xFF10B981), false),
                const SizedBox(width: 12),
                _buildScheduleTimeSlot("11:45", "Konsultatsiya", "Tursunov B.", const Color(0xFFF59E0B), false),
                const SizedBox(width: 12),
                _buildScheduleTimeSlot("14:00", "Massaj", "Sodiqova M.", const Color(0xFF8B5CF6), false),
                const SizedBox(width: 12),
                _buildScheduleTimeSlot("15:30", "Ultratovush", "Aliyeva D.", const Color(0xFFEC4899), false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTimeSlot(String time, String procedure, String patient, Color color, bool isNow) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNow ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isNow ? color : const Color(0xFFE2E8F0),
          width: isNow ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14, color: isNow ? color : const Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                time,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isNow ? color : const Color(0xFF1E293B),
                ),
              ),
              if (isNow) ...[
                const Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            procedure,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            patient,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}