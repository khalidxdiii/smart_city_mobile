import 'package:flutter/material.dart';
import '../../modules/admin/report/complete_report.dart';
import '../../modules/admin/report/pinding_report_screen.dart';

import '../../modules/admin/report/under_review_report.dart';
import '../../shared/styles/colors.dart';

class AdminLayoutReportsStatesScreen extends StatelessWidget {
  const AdminLayoutReportsStatesScreen({super.key});

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
                  PindingReportScreen(),
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
