import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/problem_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/component/skeliton.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/component/admin_report_card_widget.dart';
import 'report details/under_review_report_details.dart';

class UnderReviewReport extends StatelessWidget {
  const UnderReviewReport({super.key});

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: FutureBuilder<List<MAProblemModel>>(
        future: (FirebaseFirestore.instance
        
                .collection('problems')
                
                .where('report_state', isEqualTo: 'قيد المراجعه')
                .get())
            .then((value) => value.docs.map((doc) {
                  return MAProblemModel.fromJSON(doc.data());
                }).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('Loading');
            // return const Center(child: CircularProgressIndicator());
            return ListView.builder(itemCount: 10,itemBuilder: (context, index) => const Skeliton(height: 210,),);
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'لا يوجد تقارير',
                style: GoogleFonts.almarai(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                'لا يوجد تقارير',
                style: GoogleFonts.almarai(
                    color: kDprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),),
            );
          } else {
            if (snapshot.hasData) {
              // final problemModel2 = MAProblemModel.fromJSON(
              //     snapshot.data!.docs as Map, snapshot.data!.dat as String);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // final problemModel = MAProblemModel.fromJSON(
                  //     snapshot.data!.data()[index] as Map,
                  //    );
                  final problemModel = snapshot.data![index];

                  return FutureBuilder(
                    future: (FirebaseFirestore.instance
                        .collection('users')
                        .doc(problemModel.uID)
                        .get()),
                    builder: (context, fusnap) {
                      if (fusnap.connectionState == ConnectionState.waiting) {
                        //return const Center(child: CircularProgressIndicator());
                      }
                     
                     
                      if (fusnap.hasData) {
                        final user =
                            MAUserModel.fromJSON(fusnap.data?.data() as Map);
                        return AdminReportCardWidget(
                          index: index,
                          problemModel: problemModel,
                          userModel: user,
                          
                          
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UnderReviewReportDetails(
                                  user: user,
                                  problem: problemModel,
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            '',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
