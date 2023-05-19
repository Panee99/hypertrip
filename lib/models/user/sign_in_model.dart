// class ProfileResponse {
//   Null address;
//   Null birthday;
//   String? email;
//   String? firstName;
//   String? gender;
//   String? id;
//   String? lastName;
//   String? phone;

//   ProfileResponse(
//       {this.address,
//       this.birthday,
//       this.email,
//       this.firstName,
//       this.gender,
//       this.id,
//       this.lastName,
//       this.phone});

//   ProfileResponse.fromJson(Map<String, dynamic> json) {
//     address = json['address'];
//     birthday = json['birthday'];
//     email = json['email'];
//     firstName = json['firstName'];
//     gender = json['gender'];
//     id = json['id'];
//     lastName = json['lastName'];
//     phone = json['phone'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address'] = this.address;
//     data['birthday'] = this.birthday;
//     data['email'] = this.email;
//     data['firstName'] = this.firstName;
//     data['gender'] = this.gender;
//     data['id'] = this.id;
//     data['lastName'] = this.lastName;
//     data['phone'] = this.phone;
//     return data;
//   }
// }
class ProfileResponse {
  String? firstName;
  String? lastName;
  String? birthDay;
  String? gender;
  String? address;
  String? id;
  String? phone;
  String? email;
  String? bankName;
  String? bankAccountNumber;
  String? role;
  String? status;
  String? avatarUrl;

  ProfileResponse(
      {this.firstName,
      this.lastName,
      this.birthDay,
      this.gender,
      this.address,
      this.id,
      this.phone,
      this.email,
      this.bankName,
      this.bankAccountNumber,
      this.role,
      this.status,
      this.avatarUrl});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthDay = json['birthDay'];
    gender = json['gender'];
    address = json['address'];
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    role = json['role'];
    status = json['status'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['birthDay'] = this.birthDay;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['bankName'] = this.bankName;
    data['bankAccountNumber'] = this.bankAccountNumber;
    data['role'] = this.role;
    data['status'] = this.status;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
