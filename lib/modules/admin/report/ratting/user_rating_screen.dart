import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/problem_model.dart';
import '../../../../models/user_model.dart';
import '../../../../models/user_rating_model.dart';
import '../../../../shared/component/componant.dart';


class UserRatingScrren extends StatefulWidget {
  const UserRatingScrren({super.key, this.problem, this.user});
   final MAProblemModel? problem;
  final MAUserModel? user;

  @override
  // ignore: library_private_types_in_public_api
  _UserRatingScrren createState() => _UserRatingScrren();
}

class _UserRatingScrren extends State<UserRatingScrren> {
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
  // double _rating = 0;
  var feadBackController = TextEditingController();
  //  final RatingController ratingController = RatingController(3.5);

  @override
  void initState() {
    super.initState();
    // Replace 'feedback' with the name of your Firebase collection
  }
  
  @override
  Widget build(BuildContext context) {
    
    var formKey = GlobalKey<FormState>();
    late MAUserRattingModel maUserRatingModel;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text('تقييم الخدمه'),centerTitle: true,),
      body: SingleChildScrollView(
        child: Form(
        key: formKey,
        child: StreamBuilder<DocumentSnapshot>(
          stream:  FirebaseFirestore.instance.collection('feedback').doc(widget.problem!.reportID).snapshots(),
          builder: (context, snapshot) {
              if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //final feedbackDocs = snapshot.data!.docs;
          maUserRatingModel = MAUserRattingModel.fromJSON(snapshot.data!.data() as Map<String, dynamic>);

           
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16,),
                      Text(
                '- ما رايك بالخدمه بشكل عام؟',
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.bold,
                ),
              ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: maUserRatingModel.r1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r6,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r7,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r8,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r9,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
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
                      initialRating: maUserRatingModel.r10,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                                                     ignoreGestures: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                     
                      
                     
                     
              
                     
              
                      
                
                     const SizedBox(height: 10,),
                     ReportCardDetailsWidget(text: widget.problem!.userFeadback! ,icon:Icons.task ),
                  
                      
                      const SizedBox(height: 16,)
                    ],
                    
                  ),
              );
          }
        )
          ),
      )
    );
  }}












  