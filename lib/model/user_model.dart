class UserModel {
  String? uid;
  String? email;
  String? Name;
  String? Phone;
  String? About;
  String? FieldDiscription;


  UserModel({
    this.uid,
    this.email,
    this.Name,
    this.Phone,
    this.About,
    this.FieldDiscription,

  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      Name: map['Name'],
      Phone: map['Phone'],
      About: map['About'],
      FieldDiscription:map['FieldDiscription'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Name': Name,
      'Phone': Phone,
      'About': About,
      'FieldDiscription':FieldDiscription,

    };
  }
}
