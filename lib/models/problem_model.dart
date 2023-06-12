import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MAProblemModel {
  final String? id;
  final String? uID;
  final String? disc;
  final String? title;
  final String? prTime;
  final String imageUrl;
  final String? locationDisc;
  final String? reportID;
  final String? reportStateDone;
  final double? latitude;
  final double? longitude;
  final String? selectedValue;
  final String? adminNotice;
  final String? adminEndReportTime;
  final String imageAfterUrl;
  final String? adminNotesToUser;
  final double? rating;
  final String? userFeadback;
  final bool? isUserRating;

  MAProblemModel({
    this.id,
    this.uID,
    this.disc,
    this.prTime,
    this.imageUrl ='',
    this.title,
    this.locationDisc,
    this.reportID,
    this.reportStateDone,
    this.latitude,
    this.longitude,
    this.selectedValue ,
    this.adminNotice = 'لا يوجد ملاحظات',
    this.adminEndReportTime = '' ,
    this.imageAfterUrl ='',
    this.adminNotesToUser = "لا يوجد ملاحظات",
    this.rating,
    this.userFeadback = 'لم يتم التقييم حتى الان',
    this.isUserRating =false,

  });

  factory MAProblemModel.fromJSON(Map json) {
    final date = (json["timestamp"] as Timestamp).toDate();
    //final adminFinshReportTime = (json["admin_end_report_time"] as Timestamp).toDate();
    return MAProblemModel(
      // id: id,
      uID: json["user_id"],
      disc: json["problem_disc"],
      prTime: DateFormat('yyyy-MM-dd - kk:mm').format(date),
      imageUrl: json["image_url"] ??'',
      title: json["title_disc"],
      locationDisc: json["locationDisc"],
      reportID: json["report_id"],
      reportStateDone: json["report_state"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      selectedValue: json["selectedValue"],
      adminNotice: json["admin_notice"],
      adminEndReportTime : json["admin_end_report_time"] == null ? '' : DateFormat('yyyy-MM-dd - kk:mm').format((json["admin_end_report_time"] as Timestamp).toDate()),
      imageAfterUrl: json["image_after_url"] ?? '',
      adminNotesToUser: json["admin_notes_to_user"] ?? json["admin_notes_to_user"],
      rating: json["ما رايك بالخدمه بشكل عام"] ,
      userFeadback :json["user_feadback"] ?? 'لم يتم التقييم حتى الان',
      isUserRating : json['is_User_Rating']?? false,
      
    );
  }

  Map toJSON() {
    return {
      // "id": id,
      "user_id": uID,
      "title_disc": disc,
      "timestamp": prTime,
      "image_url": imageUrl,
      "locationDisc": locationDisc,
      "report_id": reportID,
      "report_state": reportStateDone,
      "latitude": latitude,
      "longitude": longitude,
      "selectedValue": selectedValue,
      "admin_notice" : adminNotice,
      "admin_end_report_time" : adminEndReportTime == '' ? null : Timestamp.fromDate(DateFormat('yyyy-MM-dd - kk:mm').parse(adminEndReportTime!)),
      "image_after_url" : imageAfterUrl,
      "admin_notes_to_user" : adminNotesToUser,
    };
  }
}
