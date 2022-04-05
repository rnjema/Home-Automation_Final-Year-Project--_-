class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? phoneNumber;

  UserModel(
      {this.uid,
      this.firstName,
      this.emailAddress,
      this.lastName,
      this.phoneNumber});

  // Data from Firebase
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        firstName: map['fName'],
        lastName: map['lName'],
        phoneNumber: map['cNumber'],
        emailAddress: map['email']);
  }

  // Data to Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fName': firstName,
      'lName': lastName,
      'email': emailAddress,
      'cNumber': phoneNumber,
    };
  }
}
