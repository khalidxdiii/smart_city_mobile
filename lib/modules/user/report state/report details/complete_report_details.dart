import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../models/problem_model.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/component/componant.dart';
import '../../../../shared/component/open_image.dart';
import '../../../../shared/styles/colors.dart';
import '../../ratting screen/rating.dart';

class CompleteReportDetails extends StatelessWidget {
  const CompleteReportDetails({super.key, this.problem, this.user});
  final MAProblemModel? problem;
  final MAUserModel? user;

  @override
  Widget build(BuildContext context) {
    bool isRating = problem?.isUserRating ?? false;
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
                    '    بيانات التقرير',
                    style: GoogleFonts.almarai(
                        color: kDprimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                ReportCardDetailsWidget(
                    text: 'رقم التقرير : ${problem!.reportID!}',
                    icon: Icons.list_alt),
                ReportCardDetailsWidget(
                    text: problem!.title!, icon: Icons.list_alt),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'قبل',
                          style: GoogleFonts.almarai(
                              color: kDprimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'بعد',
                          style: GoogleFonts.almarai(
                              color: kDprimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return OpenImageScreen(
                                imageUrl: problem,
                              );
                            }));
                          },
                          child: ReportDetailsImageCard(
                            imageUrl: problem!.imageUrl,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return OpenImageScreen(
                                imageUrl: problem,
                                isImageAfter: true,
                              );
                            }));
                          },
                          child: ReportDetailsImageCard(
                            imageUrl: problem!.imageAfterUrl,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ReportCardDetailsWidget(
                    text: problem!.selectedValue!, icon: Icons.list_alt),
                GestureDetector(
                  onTap: () async {
                    final String googleMapsUrl =
                        'https://www.google.com/maps/search/?api=1&query=${problem!.latitude!},${problem!.longitude!}';
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
                              color: kDprimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReportCardDetailsWidget(
                          text: problem!.locationDisc!,
                          icon: Icons.explore_outlined),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReportCardDetailsWidget(
                    text: problem!.prTime!, icon: Icons.calendar_month),
                ReportCardDetailsWidget(
                    text: problem!.adminEndReportTime!,
                    icon: Icons.calendar_month),
                ReportCardDetailsWidget(
                    text: problem!.disc!, icon: Icons.description_outlined),
                ReportCardDetailsWidget(
                    text: problem!.adminNotesToUser!, icon: Icons.task),
                Column(
                  children: [
                    Visibility(
                      visible: isRating,
                      replacement: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DefaultButton(
                              function: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RatingDialog(
                                            problem: problem,
                                            user: user,
                                          )),
                                );
                              },
                              text: 'تقييم الخدمه',
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'شكرا لك على تقيمك لخدمتنا !',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.bold,
                                color: kDprimaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: RatingBar.builder(
                              itemSize: 40,
                              initialRating: problem!.rating ?? 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (_) {},
                              ignoreGestures: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
