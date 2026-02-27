import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

Widget buildRecentPatientsTable() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.cardBorder)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Oxirgi bemorlar", style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 24),
        ...List.generate(110, (index) => _buildPatientRow()),
      ],
    ),
  );
}
Widget _buildPatientRow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        const CircleAvatar(radius: 18, backgroundColor: AppColors.mainBg, child: Icon(Icons.person, size: 20)),
        const SizedBox(width: 15),
        Text("Jasur Mavlonov", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
        const Spacer(),
        const Text("Endokrinologiya", style: TextStyle(color: AppColors.textSlate)),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.accentEmerald.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: const Text("To'langan", style: TextStyle(color: AppColors.accentEmerald, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
