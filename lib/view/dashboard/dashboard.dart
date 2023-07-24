import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/leads.controller.dart';
import 'package:test_project/view/O-sales_dashboard.dart';

import '../sales_agent/sales_dashboard.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LeadController>(context, listen: true);
    return controller.responseOfLeads!['user'][0]['role'] == 7
        ? SalesDashboard()
        : OSalesDashboard();
  }
}
