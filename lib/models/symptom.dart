class Symptom {
  int id;
  String category;
  String dateLogged;
  String dateLastModified;
  String title;
  String doctorsNotes;
  int patient;
  int doctor;

  Symptom(
      {this.id,
      this.category,
      this.dateLogged,
      this.dateLastModified,
      this.title,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    dateLogged = json['date_logged'];
    dateLastModified = json['date_last_modified'];
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
    data['date_last_modified'] = this.dateLastModified;
    data['title'] = this.title;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}
