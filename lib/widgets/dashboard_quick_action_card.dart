import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'actionBtn.dart';

Widget buildQuickActionsCard() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: AppColors.primaryGradient),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tezkor amallar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        actionBtn(Icons.add, "Yangi bemor"),
        actionBtn(Icons.print, "Hisobot yuklash"),
      ],
    ),
  );
}
