class AllHmo {
  int id;
  User user;
  bool isActive;
  List<int> hospitals;
  List<int> diagnosticCenters;
  List<int> pharmacy;
  String officeAddress;
  String annualPractisingAddress;
  String websiteUrl;
  String facebookUrl;
  String twitterUrl;
  String instagramUrl;
  String phoneNumber;
  String location;
  List<int> patients;

  AllHmo(
      {this.id,
      this.user,
      this.isActive,
      this.hospitals,
      this.diagnosticCenters,
      this.pharmacy,
      this.officeAddress,
      this.annualPractisingAddress,
      this.websiteUrl,
      this.facebookUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.phoneNumber,
      this.location,
      this.patients});

  AllHmo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isActive = json['is_active'];
    hospitals = json['hospitals'].cast<int>();
    diagnosticCenters = json['diagnostic_centers'].cast<int>();
    pharmacy = json['pharmacy'].cast<int>();
    officeAddress = json['office_address'] ?? "";
    annualPractisingAddress = json['annual_practising_address'] ?? "";
    websiteUrl = json['website_url'] ?? "";
    facebookUrl = json['facebookUrl'] ?? "";
    twitterUrl = json['twitterUrl'] ?? "";
    instagramUrl = json['instagram_url'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    location = json['location'] ?? "";
    patients = json['patients'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['is_active'] = this.isActive;
    data['hospitals'] = this.hospitals;
    data['diagnostic_centers'] = this.diagnosticCenters;
    data['pharmacy'] = this.pharmacy;
    data['office_address'] = this.officeAddress;
    data['annual_practising_address'] = this.annualPractisingAddress;
    data['website_url'] = this.websiteUrl;
    data['facebookUrl'] = this.facebookUrl;
    data['twitterUrl'] = this.twitterUrl;
    data['instagram_url'] = this.instagramUrl;
    data['phone_number'] = this.phoneNumber;
    data['location'] = this.location;
    data['patients'] = this.patients;
    return data;
  }
}

class User {
  String email;
  String username;

  User({this.email, this.username});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}
