import 'doctor.dart';
import 'hospital.dart';

class Request {
  int id;
  // PatientInfo patient;
  Doctor doctor;
  Hospital hospital;
  String location;
  String status;
  String preferredTime;
  String estimatedDuration;
  String description;
  String notes;
  String dateRequested;
  bool callRecording;

  Request(
      {this.id,
      // this.patient,
      this.doctor,
      this.hospital,
      this.location,
      this.status,
      this.notes,
      this.dateRequested,
      this.preferredTime,
      this.estimatedDuration,
      this.description,
      this.callRecording});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // try {
    //   var c = json['patient'] + 1;
    //   patient = json['patient'];
    // } catch (e) {
    //   patient = json['patient'] != null
    //       ? new PatientInfo.fromJson(json['patient'])
    //       : null;
    // }
    notes = json['notes'] ?? 'N/A';
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    dateRequested = json['date_required'];
    location = json['location'];
    status = json['status'];
    preferredTime = json['preferred_time'];
    estimatedDuration = json['estimated_duration'];
    description = json['description'];
    callRecording = json['call_recording'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // if (this.patient != null) {
    //   data['patient'] = this.patient.toJson();
    // }
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    data['location'] = this.location;
    data['status'] = this.status;
    data['preferred_time'] = this.preferredTime;
    data['estimated_duration'] = this.estimatedDuration;
    data['description'] = this.description;
    data['call_recording'] = this.callRecording;
    data['date_requested'] = this.dateRequested;
    return data;
  }
}
