import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MAUserModel {
  final String? id;
  final String? fullName;
  final String? password;
  final String? phone;
  final String? registerDateTime;
  final String? email;
  final String? address;
  final String? nationalID;

  MAUserModel({
    this.id,
    this.fullName,
    this.password,
    this.registerDateTime,
    this.email,
    this.phone,
    this.address,
    this.nationalID,
  });

  factory MAUserModel.fromJSON(Map json) {
    final date = (json["register date time"] as Timestamp).toDate();
    return MAUserModel(
      fullName: json["full name"],
      password: json["password"],
      registerDateTime: DateFormat('yyyy-MM-dd - kk:mm').format(date),
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      nationalID: json["national ID"],
    );
  }

  Map toJSON() {
    return {
      "id": id,
      "full name": fullName,
      "password": password,
      //"register date time": registerDateTime,
      "email": email,
      "phone": phone,
      "address": address,
      "national ID": nationalID,
    };
  }
}
