import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<void> showAddPatientDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 850),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC), // Juda och kulrang/oq fon
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const AddNewPatientDialog(),
        ),
      );
    },
  );
}

class AddNewPatientDialog extends StatefulWidget {
  const AddNewPatientDialog({super.key});

  @override
  State<AddNewPatientDialog> createState() => _AddNewPatientDialogState();
}

class _AddNewPatientDialogState extends State<AddNewPatientDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllerlar
  final _fullNameController = TextEditingController();
  final _ownPhoneController = TextEditingController(text: "+998 ");
  final _relativePhoneController = TextEditingController(text: "+998 ");
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  final _passportSeriesController = TextEditingController();
  final _passportNumberController = TextEditingController();
  final _apiBirthDateController = TextEditingController();

  String? _selectedGender;
  String? _selectedBloodType;
  bool _loadingPassport = false;

  final Color _primaryBlue = const Color(0xFF2563EB);
  final Color _slate700 = const Color(0xFF334155);
  final Color _slate400 = const Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPassportSection(),
                  const SizedBox(height: 32),
                  _buildSectionTitle("SHAXSIY MA'LUMOTLAR"),
                  const SizedBox(height: 16),
                  _buildPersonalData(),
                  const SizedBox(height: 32),
                  _buildSectionTitle("ALOQA VA MANZIL"),
                  const SizedBox(height: 16),
                  _buildContactData(),
                  const SizedBox(height: 32),
                  _buildSectionTitle("QO'SHIMCHA QAYDLAR"),
                  const SizedBox(height: 16),
                  _buildNotesField(),
                  const SizedBox(height: 40),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.person_add_rounded, color: _primaryBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Yangi bemor qo'shish",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _slate700,
                ),
              ),
              Text(
                "Tizimga yangi pasient ma'lumotlarini kiriting",
                style: GoogleFonts.plusJakartaSans(fontSize: 13, color: _slate400),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close_rounded, color: _slate400),
          ),
        ],
      ),
    );
  }

  Widget _buildPassportSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.badge_outlined, color: _primaryBlue, size: 20),
              const SizedBox(width: 10),
              Text(
                "Passport orqali tezkor to'ldirish",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: _primaryBlue,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildSimpleInput(_passportSeriesController, "Seriya (AA)")),
              const SizedBox(width: 12),
              Expanded(child: _buildSimpleInput(_passportNumberController, "Raqam (1234567)")),
              const SizedBox(width: 12),
              Expanded(child: _buildSimpleInput(_apiBirthDateController, "Sana (YYYY-MM-DD)")),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _loadingPassport ? null : () => _fetchPassportData(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _loadingPassport
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text("Ma'lumotni olish"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalData() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildOutlineInput(
                  label: "F.I.SH (To'liq)",
                  controller: _fullNameController,
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateInput(
                  label: "Tug'ilgan sana",
                  controller: _birthDateController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdownInput(
                  label: "Jinsi",
                  value: _selectedGender,
                  items: const ['Erkak', 'Ayol'],
                  onChanged: (v) => setState(() => _selectedGender = v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownInput(
                  label: "Qon guruhi",
                  value: _selectedBloodType,
                  items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                  onChanged: (v) => setState(() => _selectedBloodType = v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactData() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildOutlineInput(
                  label: "Telefon raqami",
                  controller: _ownPhoneController,
                  icon: Icons.phone_iphone_rounded,
                  isPhone: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOutlineInput(
                  label: "Qarindosh raqami",
                  controller: _relativePhoneController,
                  icon: Icons.people_outline_rounded,
                  isPhone: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildOutlineInput(
            label: "Yashash manzili",
            controller: _addressController,
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }

  // --- Reusable Input Widgets ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: _slate400,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSimpleInput(TextEditingController c, String hint) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: _slate400),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildOutlineInput({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPhone = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: _slate700)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          inputFormatters: isPhone ? [LengthLimitingTextInputFormatter(13)] : [],
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: _slate400),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _primaryBlue, width: 1.5)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: _slate700)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1920),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() => controller.text = "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}");
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_month_outlined, size: 20, color: _slate400),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _primaryBlue, width: 1.5)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownInput({required String label, required String? value, required List<String> items, required Function(String?) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: _slate700)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: _slate400),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _primaryBlue, width: 1.5)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: TextFormField(
        controller: _notesController,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: "Bemor haqida qo'shimcha tibbiy qaydlar...",
          hintStyle: GoogleFonts.plusJakartaSans(fontSize: 14, color: _slate400),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: _slate400, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
          child: Text("Bekor qilish", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: Text("Saqlash va qo'shish", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Future<void> _fetchPassportData() async {
    setState(() => _loadingPassport = true);
    try {
      final url = "https://api.online-mahalla.uz/api/v1/public/tax/passport?series=${_passportSeriesController.text}&number=${_passportNumberController.text}&birth_date=${_apiBirthDateController.text}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        setState(() {
          _fullNameController.text = "${data['last_name']} ${data['first_name']} ${data['middle_name'] ?? ''}";
          _birthDateController.text = data['birth_date'] ?? "";
          _addressController.text = data['address'] ?? "";
          _selectedGender = data['gender'] == "1" ? "Erkak" : "Ayol";
        });
      } else {
        _showSnackBar("Ma'lumot topilmadi", Colors.redAccent);
      }
    } catch (e) {
      _showSnackBar("Aloqa xatosi", Colors.orangeAccent);
    } finally {
      setState(() => _loadingPassport = false);
    }
  }

  void _showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }
}