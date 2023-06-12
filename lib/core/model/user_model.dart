class UserModel {
  String? name;
  int? lastName;
  String? birthdate;
  String? email;
  bool? emailVerified;
  String? password;
  String? createdAt;
  String? updatedAt;
  String? lastLogin;

  UserModel({this.name, this.lastName, this.birthdate, this.email, this.emailVerified, this.password, this.createdAt, this.updatedAt, this.lastLogin});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    birthdate = json['birthdate'];
    email = json['email'];
    emailVerified = json['email_verified'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['birthdate'] = this.birthdate;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_login'] = this.lastLogin;
    return data;
  }
}
