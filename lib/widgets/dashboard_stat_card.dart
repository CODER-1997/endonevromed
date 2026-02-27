import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

Widget buildStatCard(String title, String value, String growth, IconData icon, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: color, size: 26),
              ),
              Text(growth, style: TextStyle(color: growth.contains('+') ? AppColors.accentEmerald : AppColors.accentRose, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w800)),
          Text(title, style: const TextStyle(color: AppColors.textSlate)),
        ],
      ),
    ),
  );
}
