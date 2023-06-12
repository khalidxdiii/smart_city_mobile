import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../../main.dart';
import '../../modules/admin/search/search_screen.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class AdminLayoutScreenMoudule extends StatelessWidget {
  const AdminLayoutScreenMoudule({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> exportData() async {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        debugPrint('Permission denied. Cannot save file.');
        return;
      }

      // Fetch data from Firestore
      final firestore = FirebaseFirestore.instance;
      final feedbackSnapshot = await firestore.collection('feedback').get();

      // Create a new Excel file
      final excel = Excel.createExcel();

      // Add a sheet and set headers
      final sheet = excel['feedback'];
      sheet.insertRowIterables([
        'reportID',
        'ما رايك بالخدمه بشكل عام',
        'ما مدى رضاك عن حل المشكله',
        'سرعه الاستجابه فى حل المشكله',
        'ما رايك فى التعامل مع المسؤلين مع المشكله',
        'ما رايك فى تعامل المسؤلين معك بشكل خاص',
        'تقييم المسؤلين بشكل عام',
        'هل تنصح اصدقائك باستخدام التطبيق',
        'تعامل ممثل خدمة العملاء مع مكالمتي بسرعة',
        'كان ممثل خدمة العملاء مهذبًا للغاية',
        'كان ممثل خدمة العملاء على دراية كبيرة بالمشكله',
        'user_feadback',
      ], 0);

      // Insert data
      int rowIndex = 1;
      for (var doc in feedbackSnapshot.docs) {
        final data = doc.data();
        sheet.insertRowIterables([
          doc.id,
          data['reportID'],
          data['ما رايك بالخدمه بشكل عام'],
          data['ما مدى رضاك عن حل المشكله'],
          data['سرعه الاستجابه فى حل المشكله'],
          data['ما رايك فى التعامل مع المسؤلين مع المشكله'],
          data['ما رايك فى تعامل المسؤلين معك بشكل خاص'],
          data['تقييم المسؤلين بشكل عام'],
          data['هل تنصح اصدقائك باستخدام التطبيق'],
          data['تعامل ممثل خدمة العملاء مع مكالمتي بسرعة'],
          data['كان ممثل خدمة العملاء مهذبًا للغاية'],
          data['كان ممثل خدمة العملاء على دراية كبيرة بالمشكله'],
          data['user_feadback'],
          // data['user_rating_time'].toDate().toString(),
        ], rowIndex++);
      }

      // Save the file to the device storage
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/feedback.xlsx';
      final excelData = excel.encode();
      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(excelData!);
      debugPrint('#################');
      debugPrint('File saved at $filePath');
    }


    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                cubit.adminTitles[cubit.currentIndex],
                style: GoogleFonts.almarai(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              
              actions: [
                
               
              //   DropdownButton<Language>(
              //     // underline: const SizedBox(),
              //     icon: const Icon(
              //   Icons.language,
              //   color: Colors.white,
              // ),
              //     items: Language.languageList()
              //     .map<DropdownMenuItem<Language>>(
              //       (e) => DropdownMenuItem<Language>(
              //         value: e,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: <Widget>[
              //             Text(
              //               e.flag,
              //               style: const TextStyle(fontSize: 30),
              //             ),
              //             Text(e.name)
              //           ],
              //         ),
              //       ),
              //     )
              //     .toList(),
              //     onChanged: (Language? language) async {
              //   if (language != null) {
              //     // Locale _locale = await setLocale(language.languageCode);
              //     // MyApp.setLocale(context, _locale);
              //     MyApp.setLocale(context, Locale(language.languageCode,''));
              //   }
              // },
              // ),

               IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                ),
              ],
              leading: PopupMenuButton(
                onSelected: (value) {
                  if (value == 0) {
                    ////
                    exportData();
                  }
                  if (value == 1) {
                    FirebaseAuth.instance.signOut().then((value) {
                      // Sign-out successful.
                    }).catchError((error) {
                      debugPrint(error.ToString());
                    });

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'تم تسجيل الخروج بنجاح !',
                        style: GoogleFonts.almarai(color: kDsecondaryColor),
                      ),
                      backgroundColor: kDprimaryColor,
                    ));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Text('تصدير ملف feedback'),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text('تسجيل خروج'),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: cubit.adminTitles[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.toc,
                  ),
                  label: cubit.adminTitles[1],
                ),
              ],
            ),
            body: cubit.adminScreens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
