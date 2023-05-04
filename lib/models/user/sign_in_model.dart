class ProfileResponse {
  Null address;
  Null birthday;
  String? email;
  String? firstName;
  String? gender;
  String? id;
  String? lastName;
  String? phone;

  ProfileResponse(
      {this.address,
      this.birthday,
      this.email,
      this.firstName,
      this.gender,
      this.id,
      this.lastName,
      this.phone});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    birthday = json['birthday'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    id = json['id'];
    lastName = json['lastName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    return data;
  }
}
