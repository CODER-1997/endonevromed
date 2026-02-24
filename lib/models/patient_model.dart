// lib/app/data/models/patient_model.dart
class PatientModel {
  String? id;
  String firstName;
  String lastName;
  DateTime dob;
  String gender;
  List<String> phoneNumbers;
  String region;
  String department;
  String? photoUrl;
  DateTime arrivalDate;
  DateTime? treatmentStartDate;
  DateTime? dischargeDate;
  DateTime? nextVisitDate;

  PatientModel({
    this.id, required this.firstName, required this.lastName,
    required this.dob, required this.gender, required this.phoneNumbers,
    required this.region, required this.department, this.photoUrl,
    required this.arrivalDate, this.treatmentStartDate,
    this.dischargeDate, this.nextVisitDate,
  });

  Map<String, dynamic> toMap() => {
    "firstName": firstName, "lastName": lastName, "dob": dob,
    "gender": gender, "phoneNumbers": phoneNumbers, "region": region,
    "department": department, "photoUrl": photoUrl,
    "arrivalDate": arrivalDate, "treatmentStartDate": treatmentStartDate,
    "dischargeDate": dischargeDate, "nextVisitDate": nextVisitDate,
  };
}