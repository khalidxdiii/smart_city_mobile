import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../layout/user/user_layout_screen.dart';
import '../../../models/problem_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/styles/colors.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key, this.problem, this.user});
  final MAProblemModel? problem;
  final MAUserModel? user;

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double r1 = 0;
  double r2 = 0;
  double r3 = 0;
  double r4 = 0;
  double r5 = 0;
  double r6 = 0;
  double r7 = 0;
  double r8 = 0;
  double r9 = 0;
  double r10 = 0;

  bool isLoading = false;

  var feadBackController = TextEditingController();
  //  final RatingController ratingController = RatingController(3.5);

  @override
  Widget build(BuildContext context) {
    var reportID = widget.problem?.reportID;
    var formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('تقييم الخدمه'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '- ما رايك بالخدمه بشكل عام؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r1 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- ما مدى رضاك عن حل المشكله؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r2 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- سرعه الاستجابه فى حل المشكله؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r3 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- ما رايك فى التعامل مع المسؤلين مع المشكله؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r4 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- ما رايك فى تعامل المسؤلين معك بشكل خاص؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r5 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- تقييم المسؤلين بشكل عام؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r6,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r6 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- هل تنصح اصدقائك باستخدام التطبيق؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r7,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r7 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- تعامل ممثل خدمة العملاء مع مكالمتي بسرعة؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r8,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r8 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- كان ممثل خدمة العملاء مهذبًا للغاية؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r9,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r9 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- كان ممثل خدمة العملاء على دراية كبيرة بالمشكله؟',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: r10,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            r10 = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      maxLines: null,
                      controller: feadBackController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'برجاء كتابه تقييم';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'رايك يهمنا !',
                        labelText: 'ملاحظاتك',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('feedback')
                                  .doc(reportID)
                                  .set({
                                'user_feadback': feadBackController.text.trim(),
                                // 'is_User_Rating': true,
                                'ما رايك بالخدمه بشكل عام': r1,
                                'ما مدى رضاك عن حل المشكله': r2,
                                'سرعه الاستجابه فى حل المشكله': r3,
                                'ما رايك فى التعامل مع المسؤلين مع المشكله': r4,
                                'ما رايك فى تعامل المسؤلين معك بشكل خاص': r5,
                                'تقييم المسؤلين بشكل عام': r6,
                                'هل تنصح اصدقائك باستخدام التطبيق': r7,
                                'تعامل ممثل خدمة العملاء مع مكالمتي بسرعة': r8,
                                'كان ممثل خدمة العملاء مهذبًا للغاية': r9,
                                'كان ممثل خدمة العملاء على دراية كبيرة بالمشكله':
                                    r10,
                                'reportID': reportID,
                                'user_rating_time': Timestamp.now(),
                              });
                              await FirebaseFirestore.instance
                                  .collection('problems')
                                  .doc(reportID)
                                  .update({
                                'is_User_Rating': true,
                                'ما رايك بالخدمه بشكل عام': r1,
                                'user_feadback': feadBackController.text.trim(),
                                'user_rating_time': Timestamp.now(),
                              });
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserLayoutScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'شكرا لك على تقيمك',
                                  style: GoogleFonts.almarai(),
                                ),
                                backgroundColor: kDprimaryColor,
                              ));
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                e.toString(),
                                style: GoogleFonts.almarai(),
                              ),
                              backgroundColor: kDprimaryColor,
                            ));
                          }
                        },
                        child: const Text('حفظ'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )),
        ));
  }
}
