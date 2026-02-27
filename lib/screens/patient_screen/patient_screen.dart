import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bemorlar Ro'yxati",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.5,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded, color: Colors.white),
                  label: const Text("Yangi Bemor"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                _buildStatCard(
                  "Jami Bemorlar",
                  "2,847",
                  Icons.people_rounded,
                  const Color(0xFF0066FF),
                  "+12.5%",
                ),
                const SizedBox(width: 20),
                _buildStatCard(
                  "Bugungi Bemorlar",
                  "12",
                  Icons.today_rounded,
                  const Color(0xFF10B981),
                  "",
                ),
                const SizedBox(width: 20),
                _buildStatCard(
                  "Kutilayotgan",
                  "8",
                  Icons.schedule_rounded,
                  const Color(0xFFF59E0B),
                  "",
                ),
              ],
            ),
          ),

          // Patient List Header
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text("Bemor", style: _tableHeaderStyle)),
                          Expanded(child: Text("Telefon", style: _tableHeaderStyle)),
                          Expanded(child: Text("Oxirgi Tashrif", style: _tableHeaderStyle)),
                          Expanded(child: Text("Holat", style: _tableHeaderStyle)),
                          Expanded(child: Text("", style: _tableHeaderStyle)),
                        ],
                      ),
                    ),
                    // Patient Rows
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return _buildPatientRow(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final TextStyle _tableHeaderStyle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Color(0xFF64748B),
    letterSpacing: 0.5,
  );

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String trend) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      if (trend.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            trend,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientRow(int index) {
    final statuses = ['Yangi', 'Jarayonda', 'Tugatilgan'];
    final status = statuses[index % 3];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0).withOpacity(0.5))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: index % 2 == 0
                          ? [const Color(0xFF0066FF), const Color(0xFF0052CC)]
                          : [const Color(0xFF10B981), const Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "B${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bemor Ismi ${index + 1}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "ID: #NE-2024-001",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              "+998 99 123 45 67",
              style: const TextStyle(color: Color(0xFF475569)),
            ),
          ),
          Expanded(
            child: Text(
              "12 Mar, 2024",
              style: const TextStyle(color: Color(0xFF475569)),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: status == 'Yangi'
                    ? const Color(0xFF10B981).withOpacity(0.1)
                    : status == 'Jarayonda'
                    ? const Color(0xFFF59E0B).withOpacity(0.1)
                    : const Color(0xFF94A3B8).withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: status == 'Yangi'
                      ? const Color(0xFF10B981)
                      : status == 'Jarayonda'
                      ? const Color(0xFFF59E0B)
                      : const Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () {},
                  color: const Color(0xFF64748B),
                ),
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 20),
                  onPressed: () {},
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
