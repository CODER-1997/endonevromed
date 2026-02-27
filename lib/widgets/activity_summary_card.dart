import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

Widget buildActivitySummary() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.cardBorder)),
    child: const Center(child: Text("Bugungi statistik grafik")),
  );
}