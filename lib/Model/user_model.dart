class UserModel {
  String? uid;
  String? email;
  String? name;
  String? address;
  String? phoneNo;
  bool? accept = false;
  bool? isAdmin;
  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.address,
      this.phoneNo,
      this.accept,
      this.isAdmin});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      address: map['address'],
      phoneNo: map['phoneNo'],
      accept: map["accept"],
      isAdmin: map["isAdmin"],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'phoneNo': phoneNo,
      'accept': accept,
      'isAdmin': isAdmin,
    };
  }
}
