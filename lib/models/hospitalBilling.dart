class HospitalBilling {
  int id;
  String name;
  String notes;
  double price;

  HospitalBilling(
      {this.id,
      this.name,
      this.notes,
      this.price,});

  HospitalBilling.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    notes = json['notes'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['notes'] = this.notes;
    data['price'] = this.price;
    return data;
  }
}


class HospitalMainServices {
  int id;
  String name;

  HospitalMainServices(
      {this.id,
      this.name,});

  HospitalMainServices.fromJson(Map<String, dynamic> json) {
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
