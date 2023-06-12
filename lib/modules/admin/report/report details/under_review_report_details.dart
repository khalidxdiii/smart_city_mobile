import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../models/problem_model.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/component/componant.dart';
import '../../../../shared/styles/colors.dart';
import '../../admin upload image/admin_upload_image.dart';
import '../../../../shared/component/open_image.dart';


class UnderReviewReportDetails extends StatelessWidget {
  const UnderReviewReportDetails({super.key, this.problem, this.user});
  final MAProblemModel? problem;
  final MAUserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
        title: Center(
          child: Text(
            'تفاصيل التقرير',
            style: GoogleFonts.almarai(),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '    بيانات المستخدم',
                    style: GoogleFonts.almarai(
                        color: kDprimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                ReportCardDetailsWidget(
                    text: user!.fullName!,
                    icon: Icons.person_outline,
                    fontWeight: FontWeight.bold),
                ReportCardDetailsWidget(
                    text: user!.phone!, icon: Icons.phone_iphone_outlined),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '    بيانات التقرير',
                    style: GoogleFonts.almarai(
                        color: kDprimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                ReportCardDetailsWidget(
                    text: 'رقم التقرير : ${problem!.reportID!}',
                    icon: Icons.list_alt),

                    
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OpenImageScreen(
                          imageUrl: problem,
                        );
                      }));
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: ReportDetailsImageCard(
                        imageUrl: problem!.imageUrl,
                      ),
                    ),),
                ReportCardDetailsWidget(
                    text: problem!.title!, icon: Icons.list_alt),
                     ReportCardDetailsWidget(
                    text: problem!.selectedValue!, icon: Icons.list_alt),
                GestureDetector(
                  onTap: () async {
                    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${problem!.latitude!},${problem!.longitude!}';
                  if (await canLaunch(googleMapsUrl)) {
                    await launch(googleMapsUrl);
                  } else {
                    throw 'Could not open Google Maps';
                  }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: Text(
                                           'اضغط لعرض الموقع',
                                           style: GoogleFonts.almarai(
                          color: kDprimaryColor, fontWeight: FontWeight.bold),
                                         ),
                       ),
                  const SizedBox(height: 10,),
                      ReportCardDetailsWidget(
                          text: problem!.locationDisc!, icon: Icons.explore_outlined),
                    ],
                  ),
                ),
               
  const SizedBox(height: 10,),
                ReportCardDetailsWidget(
                    text: problem!.prTime!, icon: Icons.calendar_month),
                ReportCardDetailsWidget(
                    text: problem!.disc!, icon: Icons.description_outlined),
                   
                   ReportCardDetailsWidget(text: problem!.adminNotice! ,icon:Icons.task ),
                 
                      const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DefaultButton(
                    text: 'تحديث البيانات',
                    function: () {
                     
                      //            FirebaseFirestore.instance
                      //     .collection('problems')
                      //     .doc(problem!.reportID!)
                      //     .update({'report_state': 'قيد المراجعه','admin_notice':noticecontroler.text.trim(),})
                      //     .then((value) => debugPrint('report state updated'))
                      //     .catchError((error) => debugPrint(
                      //         'Failed to update report state: $error'));
                      // var snackBar = SnackBar(
                      //   content: Text(
                      //     'تم تحديث حاله التقرير!',
                      //     style: GoogleFonts.almarai(),
                      //   ),
                      //   backgroundColor: kDprimaryColor,
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  AdminUploadImage(problem:problem ,)
                                    ),
                                  );
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

