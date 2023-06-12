import 'package:flutter/material.dart';
import '../../modules/user/report state/complete_report.dart';
import '../../modules/user/report state/pending_report.dart';
import '../../modules/user/report state/under_review_report.dart';
import '../../shared/styles/colors.dart';

class UserLayoutReportsStatesScreen extends StatelessWidget {
  const UserLayoutReportsStatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: kDprimaryColor,
              constraints: const BoxConstraints.expand(height: 50),
              child: const TabBar(
                tabs: [
                  Tab(text: 'معلق'),
                  Tab(text: 'قيد المراجعه'),
                  Tab(text: 'مكتمل'),
                ],
              ),
            ),
             const Expanded(
              child: TabBarView(
                children: [
                  PendingReport(),
                  UnderReviewReport(),
                  CompleteReport(),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
}