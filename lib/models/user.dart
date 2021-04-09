class User {
  String email;
  String username;
  String password;
  String firstName;
  String lastName;
  int id;
  String get name => firstName + ' ' + lastName;

  User(
      {this.email,
      this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['id'] = this.id;
    return data;
  }
}
