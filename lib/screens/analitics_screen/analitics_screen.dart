import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekran kengligini aniqlash
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isMobile),
            const SizedBox(height: 32),
            _buildMetricsRow(isMobile),
            const SizedBox(height: 32),

            // Layout mantiqi: Keng ekranda Row, Mobil/Planshetda Column
            if (isMobile)
              Column(
                children: [
                  _buildPatientOverviewChart(),
                  const SizedBox(height: 24),
                  _buildRevenueChart(),
                  const SizedBox(height: 24),
                  _buildTopServices(),
                  const SizedBox(height: 24),
                  _buildDoctorPerformance(),
                  const SizedBox(height: 24),
                  _buildDemographicsCard(),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        _buildPatientOverviewChart(),
                        const SizedBox(height: 24),
                        _buildRevenueChart(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        _buildTopServices(),
                        const SizedBox(height: 24),
                        _buildDoctorPerformance(),
                        const SizedBox(height: 24),
                        _buildDemographicsCard(),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return isMobile
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerText(),
        const SizedBox(height: 16),
        _headerActions(),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _headerText(),
        _headerActions(),
      ],
    );
  }

  Widget _headerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Analitika va Hisobotlar",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1E293B),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Klinika faoliyati haqida batafsil statistik ma'lumotlar",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _headerActions() {
    return Row(
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
              Icon(Icons.calendar_today_rounded, size: 18, color: const Color(0xFF2563EB)),
              const SizedBox(width: 8),
              Text(
                "24 Fev 2026 - 2 Mar 2026",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF64748B)),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Icon(Icons.file_download_rounded, size: 20, color: Color(0xFF2563EB)),
        ),
      ],
    );
  }

  Widget _buildMetricsRow(bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _metric1()),
              const SizedBox(width: 16),
              Expanded(child: _metric2()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _metric3()),
              const SizedBox(width: 16),
              Expanded(child: _metric4()),
            ],
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: _metric1()),
        const SizedBox(width: 20),
        Expanded(child: _metric2()),
        const SizedBox(width: 20),
        Expanded(child: _metric3()),
        const SizedBox(width: 20),
        Expanded(child: _metric4()),
      ],
    );
  }

  // Metric kartalarini alohida metodlarga ajratish (kod tozaligi uchun)
  Widget _metric1() => _buildMetricCard(title: "Jami Bemorlar", value: "2,847", change: "+12.3%", icon: Icons.people_rounded, color: const Color(0xFF2563EB), gradient: const [Color(0xFF2563EB), Color(0xFF3B82F6)]);
  Widget _metric2() => _buildMetricCard(title: "Jami Muolajalar", value: "4,521", change: "+8.1%", icon: Icons.medical_services_rounded, color: const Color(0xFF10B981), gradient: const [Color(0xFF10B981), Color(0xFF059669)]);
  Widget _metric3() => _buildMetricCard(title: "Daromad", value: "₿ 847.5M", change: "+15.7%", icon: Icons.trending_up_rounded, color: const Color(0xFFF59E0B), gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)]);
  Widget _metric4() => _buildMetricCard(title: "Reyting", value: "4.8", change: "+0.3", icon: Icons.star_rounded, color: const Color(0xFF8B5CF6), gradient: const [Color(0xFF8B5CF6), Color(0xFF7C3AED)]);

  Widget _buildMetricCard({required String title, required String value, required String change, required IconData icon, required Color color, required List<Color> gradient}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF64748B), fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                FittedBox(
                  child: Row(
                    children: [
                      Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B), letterSpacing: -0.5)),
                      const SizedBox(width: 8),
                      _changeBadge(change),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _changeBadge(String change) {
    bool isPositive = change.startsWith('+');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPositive ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFEF4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        change,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
        ),
      ),
    );
  }

  Widget _buildPatientOverviewChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chartHeader("Bemorlar statistikasi", "Oxirgi 7 kunlik bemorlar tashrifi"),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildChartBar("Du", 65, 45),
                _buildChartBar("Se", 80, 55),
                _buildChartBar("Chor", 45, 70),
                _buildChartBar("Pay", 90, 60),
                _buildChartBar("Jum", 75, 85),
                _buildChartBar("Shan", 40, 35),
                _buildChartBar("Yak", 30, 25),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildSummaryChip(Icons.trending_up, "O'rtacha 64 bemor/kun"),
              _buildSummaryChip(Icons.rocket_launch_rounded, "Eng yuqori 155 (Payshanba)"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chartHeader(String title, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
        const SizedBox(height: 4),
        Text(sub, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildChartBar(String day, double value1, double value2) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(height: value2, width: 25, decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.3), borderRadius: const BorderRadius.vertical(top: Radius.circular(6)))),
          const SizedBox(height: 4),
          Container(height: value1, width: 25, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF3B82F6)]), borderRadius: const BorderRadius.vertical(top: Radius.circular(6)))),
          const SizedBox(height: 12),
          Text(day, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _buildSummaryChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2563EB)),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF475569))),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chartHeader("Daromad dinamikasi", "Oxirgi 6 oylik daromad"),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: CustomPaint(painter: LineChartPainter()),
          ),
          const SizedBox(height: 16),
          Row(
            children: ["Sent", "Okt", "Noy", "Dek", "Yan", "Fev"].map((m) => Expanded(child: Text(m, textAlign: TextAlign.center, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF64748B))))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopServices() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          _cardHeader(Icons.medical_services_rounded, "Top xizmatlar", const Color(0xFFF59E0B)),
          const SizedBox(height: 20),
          _buildServiceItem("MRI tekshiruvi", 245, 45, Colors.blue),
          _buildServiceItem("Fizioterapiya", 189, 32, Colors.green),
          _buildServiceItem("Konsultatsiya", 156, 28, Colors.orange),
        ],
      ),
    );
  }

  Widget _cardHeader(IconData icon, String title, Color color) {
    return Row(
      children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: color, size: 22)),
        const SizedBox(width: 12),
        Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
      ],
    );
  }

  Widget _buildServiceItem(String name, int count, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600)),
              Text("$count ta", style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: const Color(0xFFE2E8F0),
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorPerformance() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))]),
      child: Column(
        children: [
          _cardHeader(Icons.people_alt_rounded, "Shifokorlar", const Color(0xFF8B5CF6)),
          const SizedBox(height: 20),
          _buildDoctorItem("Dr. Karimov A.", 156, 4.9, 1),
          _buildDoctorItem("Dr. Rustamova N.", 142, 4.8, 2),
        ],
      ),
    );
  }

  Widget _buildDoctorItem(String name, int patients, double rating, int rank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(radius: 16, backgroundColor: const Color(0xFFF59E0B).withOpacity(0.1), child: Text("$rank", style: const TextStyle(fontSize: 12, color: Color(0xFFF59E0B), fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600))),
          Row(children: [const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)), Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold))]),
        ],
      ),
    );
  }

  Widget _buildDemographicsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E293B), Color(0xFF0F172A)]), borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          _cardHeader(Icons.pie_chart_rounded, "Demografiya", Colors.white),
          const SizedBox(height: 24),
          _demoRow("Erkaklar", 45, Colors.blue),
          const SizedBox(height: 16),
          _demoRow("Ayollar", 52, Colors.pink),
        ],
      ),
    );
  }

  Widget _demoRow(String label, int val, Color color) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: Colors.white70)), Text("$val%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: val / 100, backgroundColor: Colors.white12, color: color, minHeight: 6, borderRadius: BorderRadius.circular(10)),
      ],
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF2563EB)..strokeWidth = 3..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.4, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.9, size.width, size.height * 0.2);
    canvas.drawPath(path, paint);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}