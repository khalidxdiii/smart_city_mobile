import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:location/location.dart';

// Generate a random string of a specified length, including letters and digits
// String randomStringWithNum(int length) {
//   var rand = Random();
//   var codeUnits = List.generate(length, (index) {
//     int charCode;
//     if (rand.nextBool()) {
//       charCode = rand.nextInt(26) + 97; // lowercase letter
//     } else {
//       charCode = rand.nextInt(10) + 48; // digit
//     }
//     return charCode;
//   });

//   return String.fromCharCodes(codeUnits);
// }

// Generate a random string of a specified length, consisting of digits only
String randomStringNumOnly(int length) {
  var rand = Random();
  var codeUnits = List.generate(length, (index) {
    return rand.nextInt(10) + 48; // digit
  });

  return String.fromCharCodes(codeUnits);
}

// Generate a random string of a specified length
// String randomStringOnly(int length) {
//   var rand = Random();
//   var codeUnits = List.generate(length, (index) {
//     return rand.nextInt(26) + 97;
//   });

//   return String.fromCharCodes(codeUnits);
// }

class ImageUploader {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference = _storage.ref().child(fileName);
    final UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.then((p0) {
      debugPrint('finish upload image');
    });
    final String url = await storageReference.getDownloadURL();
    return url;
  }

  Future<bool> storeProblem({
    String? url,
    required String titleDisc,
    required String problemDisc,
    required String locationDisc,
    
    required String dropdownSelectedValue,
  }) async {
    try {
      Location location = Location();
      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return false;
        }
      }

      // Check if location permission is granted
      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return false;
        }
      }

      // Retrieve current location
      LocationData currentLocation = await location.getLocation();
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('problems').get();
      int size = querySnapshot.size;
      // String id = randomStringNumOnly(5); // generate a random ID of length 5
      await FirebaseFirestore.instance
          .collection('problems')
          .doc('${size + 1}')
          .set({
        'image_url': url,
        'title_disc': titleDisc,
        'problem_disc': problemDisc,
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': Timestamp.now(),
        'locationDisc': locationDisc,
        'report_id': '${size + 1}',
        'report_state': 'معلق',
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
       
        'selectedValue':dropdownSelectedValue,
      });
      debugPrint('finish upload problem');
      return true;
    } catch (e) {
      return false;
    }
  }

    Future<bool> adminFinshReport({
    String? imageAfterUrl,
    required String adminNotesToUser,
     required String reportID,
    
    
  }) async {
    try {
      await FirebaseFirestore.instance.collection('problems').doc(reportID).update({
        'image_after_url': imageAfterUrl,
        'admin_notes_to_user': adminNotesToUser,
        'admin_end_report_time': Timestamp.now(),
        'report_state': 'اكتمال',
        'is_User_Rating' : false
        
      });
      debugPrint('finish update report');
      return true;
    } catch (e) {
      return false;
    }
  }
}
