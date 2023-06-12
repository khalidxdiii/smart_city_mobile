import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/problem_model.dart';
import '../../../models/user_model.dart';
import '../report/report details/complete_report_details.dart';
import '../report/report details/pinding_report_details_screen.dart';
import '../report/report details/under_review_report_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<String?> _getReportUID(String reportID) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('problems')
        .where('report_id', isEqualTo: reportID)
        .get();

    if (snapshot.size > 0) {
      return snapshot.docs.first.id;
    }

    return null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToReportDetails(MAProblemModel problem, MAUserModel user) {
    switch (problem.reportStateDone) {
      case 'معلق':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PindingReportDetailsScreen(problem: problem, user: user),
          ),
        );

        break;
      case 'قيد المراجعه':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UnderReviewReportDetails(problem: problem, user: user),
          ),
        );
        break;
      case 'اكتمال':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CompleteReportDetails(problem: problem, user: user),
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (reportNumber) {
            setState(() {}); // Trigger a rebuild to update the search results
          },
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: 'البحث باستخدام رقم التقرير',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          cursorColor: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final reportNumber = _searchController.text.trim();
              final reportUID = await _getReportUID(reportNumber);
              if (reportUID != null) {
                // Fetch the MAProblemModel
                final DocumentSnapshot snapshot = await FirebaseFirestore
                    .instance
                    .collection('problems')
                    .doc(reportUID)
                    .get();
                final MAProblemModel problem = MAProblemModel.fromJSON(
                    snapshot.data() as Map<String, dynamic>);

                // Fetch the MAUserModel
                final DocumentSnapshot userSnapshot = await FirebaseFirestore
                    .instance
                    .collection('users')
                    .doc(problem.uID)
                    .get();
                final MAUserModel user = MAUserModel.fromJSON(
                    userSnapshot.data() as Map<String, dynamic>);

                _navigateToReportDetails(problem, user);
              } else {
                // Report not found
              }
            },
          ),
        ],
      ),
      body: _searchController.text.trim().isEmpty
          ? Center(
              child: Text(
                'أدخل رقم التقرير للبحث',
                style: GoogleFonts.almarai(),
              ),
            )
          : FutureBuilder<String?>(
              future: _getReportUID(_searchController.text.trim()),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  final String? reportUID = snapshot.data;
                  if (reportUID != null) {
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('problems')
                          .doc(reportUID)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final MAProblemModel problem = MAProblemModel.fromJSON(
                            snapshot.data!.data() as Map<String, dynamic>);

                        return ListView.separated(
                          itemCount: 1,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 15),
                                      blurRadius: 25,
                                      color: Colors.black12),
                                ],
                              ),
                              child: Card(
                                margin: const EdgeInsets.all(16.0),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  title: Text(
                                    problem.title ?? '',
                                    style: GoogleFonts.almarai(),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        problem.disc ?? '',
                                        style: GoogleFonts.almarai(),
                                      ),
                                      Text(
                                        'حاله التقرير : ${problem.reportStateDone}',
                                        style: GoogleFonts.almarai(),
                                      )
                                    ],
                                  ),
                                  onTap: () async {
                                    // Fetch the MAUserModel
                                    final DocumentSnapshot userSnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(problem.uID)
                                            .get();
                                    final MAUserModel user =
                                        MAUserModel.fromJSON(userSnapshot.data()
                                            as Map<String, dynamic>);

                                    _navigateToReportDetails(problem, user);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'لا يوجد نتائج بحث',
                        style: GoogleFonts.almarai(),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      'لا يوجد نتائج بحث',
                      style: GoogleFonts.almarai(),
                    ),
                  );
                }
              },
            ),
    );
  }
}
