import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/problem_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/component/admin_report_card_widget.dart';
import '../../../shared/component/skeliton.dart';
import '../../../shared/styles/colors.dart';
import 'report details/pinding_report_details_screen.dart';

class PindingReportScreen extends StatelessWidget {
  const PindingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // body: StreamBuilder(
      //   stream: refReport.snapshots(),
      //   builder: (context, snapshot) {

      //     if (snapshot.hasError) {
      //       return Center(child: Text(snapshot.error.toString()));
      //     }
      body: FutureBuilder<QuerySnapshot>(
        // future: refReport.get(),
        future: FirebaseFirestore.instance
            .collection('problems')
            .where('report_state', isEqualTo: 'معلق')
            // .orderBy('timestamp')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'لا يوجد تقارير',
                  style: GoogleFonts.almarai(
                      color: kDprimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('Loading');
            // return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const Skeliton(
                height: 210,
              ),
            );
          }

          if (snapshot.hasData) {
           
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final problemModel = MAProblemModel.fromJSON(
                  snapshot.data!.docs[index].data() as Map,
                );

                return FutureBuilder(
                  future: (FirebaseFirestore.instance
                      .collection('users')
                      .doc(problemModel.uID)
                      .get()),
                  builder: (context, fusnap) {
                    if (fusnap.connectionState == ConnectionState.waiting) {}
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
                              builder: (context) => PindingReportDetailsScreen(
                                user: user,
                                problem: problemModel,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('');
                    }
                  },
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
