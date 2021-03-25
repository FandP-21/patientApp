class PatientVital {
  int id;
  String severity;
  String bp;
  String bmi;
  String pulse;
  String blood_oxygen;
  String temperature;
  String height;
  String weight;
  String date_logged;
  bool self_record;
  int patient;

  PatientVital(
      {this.id,
      this.severity,
      this.bp,
      this.bmi,
      this.pulse,
      this.blood_oxygen,
      this.temperature,
      this.height,
      this.weight,
      this.date_logged,
      this.self_record,
      this.patient});

  PatientVital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'];
    bp = json['bp'];
    bmi = json['bmi'];
    pulse = json['pulse'];
    blood_oxygen = json['blood_oxygen'];
    temperature = json['temperature'];
    height = json['height'];
    weight = json['weight'];
    date_logged = json['date_logged'];
    self_record = json['self_record'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['bp'] = this.bp;
    data['bmi'] = this.bmi;
    data['pulse'] = this.pulse;
    data['blood_oxygen'] = this.blood_oxygen;
    data['temperature'] = this.temperature;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['date_logged'] = this.date_logged;
    data['self_record'] = this.self_record;
    data['patient'] = this.patient;
    return data;
  }
}
