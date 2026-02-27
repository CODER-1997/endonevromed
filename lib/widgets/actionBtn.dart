import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget actionBtn(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      child: Row(children: [Icon(icon, color: Colors.white), const SizedBox(width: 12), Text(text, style: const TextStyle(color: Colors.white))]),
    ),
  );
}
