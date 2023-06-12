import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../layout/admin/admin_layout_screen_moudule.dart';
import '../../../../models/problem_model.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/component/componant.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/component/open_image.dart';

class PindingReportDetailsScreen extends StatefulWidget {
  const PindingReportDetailsScreen({super.key, this.problem, this.user});
  final MAProblemModel? problem;
  final MAUserModel? user;

  @override
  State<PindingReportDetailsScreen> createState() => _PindingReportDetailsScreenState();
}

class _PindingReportDetailsScreenState extends State<PindingReportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
var noticecontroler = TextEditingController();
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
                    text: widget.user!.fullName!,
                    icon: Icons.person_outline,
                    fontWeight: FontWeight.bold),
                ReportCardDetailsWidget(
                    text: widget.user!.phone!, icon: Icons.phone_iphone_outlined),
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
                    text: 'رقم التقرير : ${widget.problem!.reportID!}',
                    icon: Icons.list_alt),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OpenImageScreen(
                          imageUrl: widget.problem,
                        );
                      }));
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: ReportDetailsImageCard(
                        imageUrl: widget.problem!.imageUrl,
                      ),
                    )),
                ReportCardDetailsWidget(
                    text: widget.problem!.title!, icon: Icons.list_alt),
                     ReportCardDetailsWidget(
                    text: widget.problem!.selectedValue!, icon: Icons.list_alt),
                GestureDetector(
                  onTap: () async {
                    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${widget.problem!.latitude!},${widget.problem!.longitude!}';
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
                          text: widget.problem!.locationDisc!, icon: Icons.explore_outlined),
                    ],
                  ),
                ),
                ReportCardDetailsWidget(
                    text: widget.problem!.prTime!, icon: Icons.calendar_month),
                ReportCardDetailsWidget(
                    text: widget.problem!.disc!, icon: Icons.description_outlined),
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: DefaultTextFild(
                          controller: noticecontroler,
                          label: 'ملاحظات المسؤل',
                          type: TextInputType.text,
                          prefixIcon: Icons.task,
                          radius: 10,maxLines: 7,
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return '';
                            // }
                            return null;
                          },
                        ),
                   ),
                      const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DefaultButton(
                    text: 'تسجيل مراجعه التقرير',
                    function: () {
                     setState(() {
    });
                      if (noticecontroler.text.isEmpty) {
  noticecontroler.text ='لا يوجد ملاحظات';
}
                      FirebaseFirestore.instance
                          .collection('problems')
                          .doc(widget.problem!.reportID!)
                          .update({'report_state': 'قيد المراجعه','admin_notice':noticecontroler.text.trim(),})
                          .then((value) => debugPrint('report state updated'))
                          .catchError((error) => debugPrint(
                              'Failed to update report state: $error'));

                               setState(() {
    });


                              Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const AdminLayoutScreenMoudule(),
  ),
);
                      var snackBar = SnackBar(
                        content: Text(
                          'تم تحديث حاله التقرير!',
                          style: GoogleFonts.almarai(),
                        ),
                        backgroundColor: kDprimaryColor,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DefaultButton(
                  function: () async {
                    try {
                      await FirebaseFirestore.instance
                          .collection('problems')
                          .doc(widget.problem!.reportID)
                          .delete();
                      // Document deleted successfully
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('تم حذف التقرير بنجاح'),
                        backgroundColor: Colors.red,
                      ));
                       Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLayoutScreenMoudule(),
                  ),
                );
                    } catch (e) {
                      // Error occurred while deleting document
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to delete document: $e'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  text: 'حذف التقرير',
                  background: Colors.red,
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

// void openMaps({required var longitude,required var latitude}) async {
//   final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//   if (await canLaunch(googleMapsUrl)) {
//     await launch(googleMapsUrl);
//   } else {
//     throw 'Could not open Google Maps';
//   }
  
// }