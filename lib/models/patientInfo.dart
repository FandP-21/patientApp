import 'package:thcMobile/models/pharmacy.dart';
import 'package:thcMobile/models/doctor.dart';

class PatientInfo {
  int id;
  List<MedicalRecord> medicalRecord;
  List<Symptom> symptom;
  List<Diagnosis> diagnosis;
  List<Prescription> prescription;
  List<Doctor> doctor;
  List<PatientHistory> patientHistory;
  List<PatientVital> patientVital;
  List<PatientDocument> patientDocument;
  // List<LabTesti> labTesti;
  List<HospitalNotes> hospitalNotes;
  List<HospitalLogs> hospitalLogs;
  List<Hospitals> hospitals;
  User user;
  String patientType;
  int validity;
  String middleName;
  int age;
  String gender;
  String occupation;
  String maritalStatus;
  String address;
  String dateOfBirth;
  String religion;
  String registrationDate;
  bool isActive;
  String nextOfKinName;

  PatientInfo(
      {this.id,
      this.medicalRecord,
      this.symptom,
      this.diagnosis,
      this.prescription,
      this.doctor,
      this.patientHistory,
      this.patientVital,
      this.patientDocument,
      // this.labTesti,
      this.hospitalNotes,
      this.hospitalLogs,
      this.hospitals,
      this.user,
      this.patientType,
      this.validity,
      this.middleName,
      this.age,
      this.gender,
      this.occupation,
      this.maritalStatus,
      this.address,
      this.dateOfBirth,
      this.religion,
      this.registrationDate,
      this.isActive});

  PatientInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['medical_record'] != null) {
      medicalRecord = new List<MedicalRecord>();
      json['medical_record'].forEach((v) {
        medicalRecord.add(new MedicalRecord.fromJson(v));
      });
    }
    if (json['symptom'] != null) {
      symptom = new List<Symptom>();
      json['symptom'].forEach((v) {
        symptom.add(new Symptom.fromJson(v));
      });
    }
    if (json['diagnosis'] != null) {
      diagnosis = new List<Diagnosis>();
      json['diagnosis'].forEach((v) {
        diagnosis.add(new Diagnosis.fromJson(v));
      });
    }
    if (json['prescription'] != null) {
      prescription = new List<Prescription>();
      json['prescription'].forEach((v) {
        prescription.add(new Prescription.fromJson(v));
      });
    }
    if (json['doctor'] != null) {
      doctor = new List<Doctor>();
      json['doctor'].forEach((v) {
        doctor.add(new Doctor.fromJson(v));
      });
    }
    if (json['patient_history'] != null) {
      patientHistory = new List<PatientHistory>();
      json['patient_history'].forEach((v) {
        patientHistory.add(new PatientHistory.fromJson(v));
      });
    }
    if (json['patient_vital'] != null) {
      patientVital = new List<PatientVital>();
      json['patient_vital'].forEach((v) {
        patientVital.add(new PatientVital.fromJson(v));
      });
    }
    if (json['patient_document'] != null) {
      patientDocument = new List<PatientDocument>();
      json['patient_document'].forEach((v) {
        patientDocument.add(new PatientDocument.fromJson(v));
      });
    }
    // if (json['lab_testi'] != null) {
    //   labTesti = new List<LabTesti>();
    //   json['lab_testi'].forEach((v) {
    //     labTesti.add(new LabTesti.fromJson(v));
    //   });
    // }
    if (json['hospital_notes'] != null) {
      hospitalNotes = new List<HospitalNotes>();
      json['hospital_notes'].forEach((v) {
        hospitalNotes.add(new HospitalNotes.fromJson(v));
      });
    }
    if (json['hospital_logs'] != null) {
      hospitalLogs = new List<HospitalLogs>();
      json['hospital_logs'].forEach((v) {
        hospitalLogs.add(new HospitalLogs.fromJson(v));
      });
    }
    if (json['hospitals'] != null) {
      hospitals = new List<Hospitals>();
      json['hospitals'].forEach((v) {
        hospitals.add(new Hospitals.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    patientType = json['patient_type'];
    validity = json['validity'];
    middleName = json['middle_name'];
    age = json['age'];
    gender = json['gender'];
    occupation = json['occupation'];
    maritalStatus = json['marital_status'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    religion = json['religion'];
    registrationDate = json['registration_date'];
    isActive = json['is_active'];
    nextOfKinName = json['next_of_kin_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.medicalRecord != null) {
      data['medical_record'] =
          this.medicalRecord.map((v) => v.toJson()).toList();
    }
    if (this.symptom != null) {
      data['symptom'] = this.symptom.map((v) => v.toJson()).toList();
    }
    if (this.diagnosis != null) {
      data['diagnosis'] = this.diagnosis.map((v) => v.toJson()).toList();
    }
    if (this.prescription != null) {
      data['prescription'] = this.prescription.map((v) => v.toJson()).toList();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor.map((v) => v.toJson()).toList();
    }
    if (this.patientHistory != null) {
      data['patient_history'] =
          this.patientHistory.map((v) => v.toJson()).toList();
    }
    if (this.patientVital != null) {
      data['patient_vital'] = this.patientVital.map((v) => v.toJson()).toList();
    }
    if (this.patientDocument != null) {
      data['patient_document'] =
          this.patientDocument.map((v) => v.toJson()).toList();
    }
    // if (this.labTesti != null) {
    //   data['lab_testi'] = this.labTesti.map((v) => v.toJson()).toList();
    // }
    if (this.hospitalNotes != null) {
      data['hospital_notes'] =
          this.hospitalNotes.map((v) => v.toJson()).toList();
    }
    if (this.hospitalLogs != null) {
      data['hospital_logs'] = this.hospitalLogs.map((v) => v.toJson()).toList();
    }
    if (this.hospitals != null) {
      data['hospitals'] = this.hospitals.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['patient_type'] = this.patientType;
    data['validity'] = this.validity;
    data['middle_name'] = this.middleName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['marital_status'] = this.maritalStatus;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['religion'] = this.religion;
    data['registration_date'] = this.registrationDate;
    return data;
  }
}

class MedicalRecord {
  int id;
  String severity;
  String dateLogged;
  String activityDate;
  String doctorsNotes;
  int patient;
  int doctor;

  MedicalRecord(
      {this.id,
      this.severity,
      this.dateLogged,
      this.activityDate,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'];
    dateLogged = json['date_logged'];
    activityDate = json['activity_date'];
    doctorsNotes = json['doctors_notes'];
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['date_logged'] = this.dateLogged;
    data['activity_date'] = this.activityDate;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}

class Symptom {
  int id;
  String category;
  String dateLogged;
  String title;
  String doctorsNotes;
  int patient;
  int doctor;

  Symptom(
      {this.id,
      this.category,
      this.dateLogged,
      this.title,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    dateLogged = json['date_logged'];
    title = json['title'];
    doctorsNotes = json['doctors_notes'];
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['date_logged'] = this.dateLogged;
    data['title'] = this.title;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}

class Diagnosis {
  int id;
  String dateLogged;
  String title;
  Null generalDiagnosis;
  Null investigationResult;
  Null clinicalSummary;
  String doctorsNotes;
  int patient;
  int doctor;

  Diagnosis(
      {this.id,
      this.dateLogged,
      this.title,
      this.generalDiagnosis,
      this.investigationResult,
      this.clinicalSummary,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateLogged = json['date_logged'];
    title = json['title'];
    generalDiagnosis = json['general_diagnosis'];
    investigationResult = json['investigation_result'];
    clinicalSummary = json['clinical_summary'];
    doctorsNotes = json['doctors_notes'];
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_logged'] = this.dateLogged;
    data['title'] = this.title;
    data['general_diagnosis'] = this.generalDiagnosis;
    data['investigation_result'] = this.investigationResult;
    data['clinical_summary'] = this.clinicalSummary;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}

class Prescription {
  int id;
  TreatmentCategory treatmentCategory;
  List<PharmacyDrug> drugs;
  String dosage;
  String unit;
  String frequency;
  String noOfTablets;
  int doctor;
  int patient;
  String logged;
  String dateLastModified;
  bool isDeleted;

  Prescription(
      {this.id,
      this.treatmentCategory,
      this.drugs,
      this.dosage,
      this.unit,
      this.frequency,
      this.noOfTablets,
      this.logged,
      this.dateLastModified,
      this.isDeleted,
      this.doctor,
      this.patient});

  Prescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treatmentCategory = json['treatment_category'] != null
        ? new TreatmentCategory.fromJson(json['treatment_category'])
        : null;
    if (json['drugs'] != null) {
      drugs = new List<PharmacyDrug>();
      json['drugs'].forEach((v) {
        drugs.add(new PharmacyDrug.fromJson(v));
      });
    }
    dosage = json['dosage'];
    unit = json['unit'];
    frequency = json['frequency'];
    noOfTablets = json['no_of_tablets'];
    logged = json['logged'];
    dateLastModified = json['date_last_modified'];
    isDeleted = json['is_deleted'];
    doctor = json['doctor'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.treatmentCategory != null) {
      data['treatment_category'] = this.treatmentCategory.toJson();
    }
    if (this.drugs != null) {
      data['drugs'] = this.drugs.map((v) => v.toJson()).toList();
    }
    data['dosage'] = this.dosage;
    data['unit'] = this.unit;
    data['frequency'] = this.frequency;
    data['no_of_tablets'] = this.noOfTablets;
    data['logged'] = this.logged;
    data['date_last_modified'] = this.dateLastModified;
    data['is_deleted'] = this.isDeleted;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    return data;
  }
}

class TreatmentCategory {
  int id;
  String name;

  TreatmentCategory({this.id, this.name});

  TreatmentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Drugs {
  int id;
  String name;
  String drugDivision;
  double price;
  int drugType;

  Drugs({this.id, this.name, this.drugDivision, this.price, this.drugType});

  Drugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drugDivision = json['drug_division'];
    price = json['price'];
    drugType = json['drug_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['drug_division'] = this.drugDivision;
    data['price'] = this.price;
    data['drug_type'] = this.drugType;
    return data;
  }
}

// class Doctor {
//   int id;
//   String accessLevel;
//   String status;
//   String rating;
//   Null photo;
//   Null languages;
//   Null facebookUrl;
//   Null twitterUrl;
//   Null instagramUrl;
//   Null phoneNumber;
//   String mdcnLicenseNumber;
//   Null mdcnLicense;
//   bool isActive;
//   bool isDisabled;
//   int yearsInSpecialization;
//   String bioInfoOnSpecialization;
//   double rate;
//   String location;
//   String mondayFromHour;
//   String mondayToHour;
//   String tuesdayFromHour;
//   String tuesdayToHour;
//   String wednesdayFromHour;
//   String wednesdayToHour;
//   String thursdayFromHour;
//   String thursdayToHour;
//   String fridayFromHour;
//   String fridayToHour;
//   String saturdayFromHour;
//   String saturdayToHour;
//   String sundayFromHour;
//   String sundayToHour;
//   int user;
//   int hospital;
//   List<int> areaOfSpecialization;
//   List<int> diseasesSpeciality;

//   Doctor(
//       {this.id,
//       this.accessLevel,
//       this.status,
//       this.rating,
//       this.photo,
//       this.languages,
//       this.facebookUrl,
//       this.twitterUrl,
//       this.instagramUrl,
//       this.phoneNumber,
//       this.mdcnLicenseNumber,
//       this.mdcnLicense,
//       this.isActive,
//       this.isDisabled,
//       this.yearsInSpecialization,
//       this.bioInfoOnSpecialization,
//       this.rate,
//       this.location,
//       this.mondayFromHour,
//       this.mondayToHour,
//       this.tuesdayFromHour,
//       this.tuesdayToHour,
//       this.wednesdayFromHour,
//       this.wednesdayToHour,
//       this.thursdayFromHour,
//       this.thursdayToHour,
//       this.fridayFromHour,
//       this.fridayToHour,
//       this.saturdayFromHour,
//       this.saturdayToHour,
//       this.sundayFromHour,
//       this.sundayToHour,
//       this.user,
//       this.hospital,
//       this.areaOfSpecialization,
//       this.diseasesSpeciality});

//   Doctor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     accessLevel = json['access_level'];
//     status = json['status'];
//     rating = json['rating'];
//     photo = json['photo'];
//     languages = json['languages'];
//     facebookUrl = json['facebookUrl'];
//     twitterUrl = json['twitterUrl'];
//     instagramUrl = json['instagram_url'];
//     phoneNumber = json['phone_number'];
//     mdcnLicenseNumber = json['mdcn_license_number'];
//     mdcnLicense = json['mdcn_license'];
//     isActive = json['is_active'];
//     isDisabled = json['is_disabled'];
//     yearsInSpecialization = json['years_in_specialization'];
//     bioInfoOnSpecialization = json['bio_info_on_specialization'];
//     rate = json['rate'];
//     location = json['location'];
//     mondayFromHour = json['monday_from_hour'];
//     mondayToHour = json['monday_to_hour'];
//     tuesdayFromHour = json['tuesday_from_hour'];
//     tuesdayToHour = json['tuesday_to_hour'];
//     wednesdayFromHour = json['wednesday_from_hour'];
//     wednesdayToHour = json['wednesday_to_hour'];
//     thursdayFromHour = json['thursday_from_hour'];
//     thursdayToHour = json['thursday_to_hour'];
//     fridayFromHour = json['friday_from_hour'];
//     fridayToHour = json['friday_to_hour'];
//     saturdayFromHour = json['saturday_from_hour'];
//     saturdayToHour = json['saturday_to_hour'];
//     sundayFromHour = json['sunday_from_hour'];
//     sundayToHour = json['sunday_to_hour'];
//     user = json['user'];
//     hospital = json['hospital'];
//     areaOfSpecialization = json['areaOfSpecialization'].cast<int>();
//     diseasesSpeciality = json['diseases_speciality'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['access_level'] = this.accessLevel;
//     data['status'] = this.status;
//     data['rating'] = this.rating;
//     data['photo'] = this.photo;
//     data['languages'] = this.languages;
//     data['facebookUrl'] = this.facebookUrl;
//     data['twitterUrl'] = this.twitterUrl;
//     data['instagram_url'] = this.instagramUrl;
//     data['phone_number'] = this.phoneNumber;
//     data['mdcn_license_number'] = this.mdcnLicenseNumber;
//     data['mdcn_license'] = this.mdcnLicense;
//     data['is_active'] = this.isActive;
//     data['is_disabled'] = this.isDisabled;
//     data['years_in_specialization'] = this.yearsInSpecialization;
//     data['bio_info_on_specialization'] = this.bioInfoOnSpecialization;
//     data['rate'] = this.rate;
//     data['location'] = this.location;
//     data['monday_from_hour'] = this.mondayFromHour;
//     data['monday_to_hour'] = this.mondayToHour;
//     data['tuesday_from_hour'] = this.tuesdayFromHour;
//     data['tuesday_to_hour'] = this.tuesdayToHour;
//     data['wednesday_from_hour'] = this.wednesdayFromHour;
//     data['wednesday_to_hour'] = this.wednesdayToHour;
//     data['thursday_from_hour'] = this.thursdayFromHour;
//     data['thursday_to_hour'] = this.thursdayToHour;
//     data['friday_from_hour'] = this.fridayFromHour;
//     data['friday_to_hour'] = this.fridayToHour;
//     data['saturday_from_hour'] = this.saturdayFromHour;
//     data['saturday_to_hour'] = this.saturdayToHour;
//     data['sunday_from_hour'] = this.sundayFromHour;
//     data['sunday_to_hour'] = this.sundayToHour;
//     data['user'] = this.user;
//     data['hospital'] = this.hospital;
//     data['areaOfSpecialization'] = this.areaOfSpecialization;
//     data['diseases_speciality'] = this.diseasesSpeciality;
//     return data;
//   }
// }

class PatientHistory {
  int id;
  String severity;
  String notes;
  String dateLogged;
  String dateLastModified;
  int patient;

  PatientHistory(
      {this.id,
      this.severity,
      this.notes,
      this.dateLogged,
      this.dateLastModified,
      this.patient});

  PatientHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'];
    notes = json['notes'];
    dateLogged = json['date_logged'];
    dateLastModified = json['date_last_modified'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['notes'] = this.notes;
    data['date_logged'] = this.dateLogged;
    data['date_last_modified'] = this.dateLastModified;
    data['patient'] = this.patient;
    return data;
  }
}

class PatientVital {
  int id;
  String severity;
  String bp;
  String bmi;
  String pulse;
  String bloodOxygen;
  String temperature;
  String height;
  String weight;
  String dateLogged;
  String dateLastModified;
  bool selfRecord;
  int patient;

  PatientVital(
      {this.id,
      this.severity,
      this.bp,
      this.bmi,
      this.pulse,
      this.bloodOxygen,
      this.temperature,
      this.height,
      this.weight,
      this.dateLogged,
      this.dateLastModified,
      this.selfRecord,
      this.patient});

  PatientVital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'];
    bp = json['bp'];
    bmi = json['bmi'];
    pulse = json['pulse'];
    bloodOxygen = json['blood_oxygen'];
    temperature = json['temperature'];
    height = json['height'];
    weight = json['weight'];
    dateLogged = json['date_logged'];
    dateLastModified = json['date_last_modified'];
    selfRecord = json['self_record'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['bp'] = this.bp;
    data['bmi'] = this.bmi;
    data['pulse'] = this.pulse;
    data['blood_oxygen'] = this.bloodOxygen;
    data['temperature'] = this.temperature;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['date_logged'] = this.dateLogged;
    data['date_last_modified'] = this.dateLastModified;
    data['self_record'] = this.selfRecord;
    data['patient'] = this.patient;
    return data;
  }
}

class PatientDocument {
  int id;
  String name;
  String document;
  String dateLogged;

  PatientDocument({this.id, this.name, this.document, this.dateLogged});

  PatientDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    document = json['document'];
    dateLogged = json['date_logged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['document'] = this.document;
    data['date_logged'] = this.dateLogged;
    return data;
  }
}

// class LabTesti {
//   int patient;
//   int laboratory;
//   TestName testName;
//   TreatmentCategory category;
//   var testResult;

//   LabTesti(
//       {this.patient,
//       this.laboratory,
//       this.testName,
//       this.category,
//       this.testResult});

//   LabTesti.fromJson(Map<String, dynamic> json) {
//     patient = json['patient'];
//     laboratory = json['laboratory'];
//     testName = json['test_name'] != null
//         ? new TestName.fromJson(json['test_name'])
//         : null;
//     category = json['category'] != null
//         ? new TreatmentCategory.fromJson(json['category'])
//         : null;
//     try {
//       var a = json['test_result'] + '';
//       testResult = json['test_result']
//     } catch (e) {
//       if (json['test_result'] != null) {
//         testResult = new List<TestResult>();
//         json['test_result'].forEach((v) {
//           testResult.add(new TestResult.fromJson(v));
//         });
//       }
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['patient'] = this.patient;
//     data['laboratory'] = this.laboratory;
//     if (this.testName != null) {
//       data['test_name'] = this.testName.toJson();
//     }
//     if (this.category != null) {
//       data['category'] = this.category.toJson();
//     }
//     if (this.testResult != null) {
//       data['test_result'] = this.testResult.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class TestName {
  int id;
  String name;
  int service;

  TestName({this.id, this.name, this.service});

  TestName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service'] = this.service;
    return data;
  }
}

class TestResult {
  int id;
  String name;
  String value;

  TestResult({this.id, this.name, this.value});

  TestResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class HospitalNotes {
  int id;
  String referralNotes;
  String doctorNotes;
  String dischargeInstructions;
  String dateLogged;
  String dateLastModified;
  int hospital;
  int doctor;
  int patient;

  HospitalNotes(
      {this.id,
      this.referralNotes,
      this.doctorNotes,
      this.dischargeInstructions,
      this.dateLogged,
      this.dateLastModified,
      this.hospital,
      this.doctor,
      this.patient});

  HospitalNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referralNotes = json['referral_notes'];
    doctorNotes = json['doctor_notes'];
    dischargeInstructions = json['discharge_instructions'];
    dateLogged = json['date_logged'];
    dateLastModified = json['date_last_modified'];
    hospital = json['hospital'];
    doctor = json['doctor'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referral_notes'] = this.referralNotes;
    data['doctor_notes'] = this.doctorNotes;
    data['discharge_instructions'] = this.dischargeInstructions;
    data['date_logged'] = this.dateLogged;
    data['date_last_modified'] = this.dateLastModified;
    data['hospital'] = this.hospital;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    return data;
  }
}

class HospitalLogs {
  int id;
  String callLogs;
  String photos;
  String dateLogged;
  String dateLastModified;
  int hospital;
  int doctor;
  int patient;

  HospitalLogs(
      {this.id,
      this.callLogs,
      this.photos,
      this.dateLogged,
      this.dateLastModified,
      this.hospital,
      this.doctor,
      this.patient});

  HospitalLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    callLogs = json['call_logs'];
    photos = json['photos'];
    dateLogged = json['date_logged'];
    dateLastModified = json['date_last_modified'];
    hospital = json['hospital'];
    doctor = json['doctor'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['call_logs'] = this.callLogs;
    data['photos'] = this.photos;
    data['date_logged'] = this.dateLogged;
    data['date_last_modified'] = this.dateLastModified;
    data['hospital'] = this.hospital;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    return data;
  }
}

class Hospitals {
  int id;
  User user;
  String rating;
  String officeAddress;
  String cacNumber;
  List<int> patients;
  List<int> areasOfSpecialization;
  List<int> diseasesSpeciality;
  List<int> hospitalBranch;

  Hospitals(
      {this.id,
      this.user,
      this.rating,
      this.officeAddress,
      this.cacNumber,
      this.patients,
      this.areasOfSpecialization,
      this.diseasesSpeciality,
      this.hospitalBranch});

  Hospitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rating = json['rating'];
    officeAddress = json['office_address'];
    cacNumber = json['cac_number'];
    patients = json['patients'].cast<int>();
    areasOfSpecialization = json['areas_of_specialization'].cast<int>();
    diseasesSpeciality = json['diseases_speciality'].cast<int>();
    hospitalBranch = json['hospital_branch'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['rating'] = this.rating;
    data['office_address'] = this.officeAddress;
    data['cac_number'] = this.cacNumber;
    data['patients'] = this.patients;
    data['areas_of_specialization'] = this.areasOfSpecialization;
    data['diseases_speciality'] = this.diseasesSpeciality;
    data['hospital_branch'] = this.hospitalBranch;
    return data;
  }
}

class User {
  int id;
  String email;
  String username;
  String password;
  String firstName;
  String lastName;

  User(
      {this.id,
      this.email,
      this.username,
      this.password,
      this.firstName,
      this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
