import 'dart:async';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_project/utils/assets.dart';
import 'package:test_project/view/O-sales_dashboard.dart';
import 'package:test_project/view/sales_agent/sales_dashboard.dart';
import 'package:test_project/view/sales_login.dart';
import 'package:test_project/view/sales_manager/manager_dashboard.dart';

import '../controller/call_log.controller.dart';
import '../controller/leads.controller.dart';
import '../utils/const.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    //CALL THE PROFILE API TO GET THE DATA
    if (bearerToken == "") {
      log("Still not login session");
    } else {
      Future.microtask(() => context.read<LeadController>().getData());
    }

    if (Platform.isAndroid) {
      permissionHandler();
    } else {
      forIOS();
    }

    super.initState();
  }

  /*FOR IOS, ROUTE TO THE LOGIN OR DASHBOARD*/
  forIOS() {
    if (bearerToken == "") {
      Timer(Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SalesLogin()));
      });
    } else {
      Timer(
          Duration(seconds: 5),
          () => context.read<LeadController>().responseOfLeads!['user'][0]['role'] == 7
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SalesDashboard()))
              : context.read<LeadController>().responseOfLeads!['user'][0]['role'] == 3
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ManagerDashboard()))
              : SalesLogin());
    }
  }

  /*FOR ANDROID , WHEN THE USER COME TO THE SPLASH SCREEN , IT WILL ASK FOR PERMISSION
    AND AFTER GETTING THE PERMISSION IT WILL SUBMIT THE CALL LOGS AND THEN GO THE LOGIN SCREEN
    OR DASHBOARD SCREEN , DEPENDS*/
  Future permissionHandler() async {
    await Permission.phone.request();
    final permission = await Permission.phone.status;

    if (permission.isGranted == false) {
      await Permission.phone.request();
    } else if (permission.isGranted == true) {
      if (bearerToken == "") {
        Timer(Duration(seconds: 5), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SalesLogin()));
        });
      } else {
        context.read<CallLogController>().sendCallLogsInStart(context);

        if (context.read<CallLogController>().isLoading == false) {
          Timer(
              Duration(seconds: 5),
              () => context.read<LeadController>().responseOfLeads!['user'][0]['role'] == 7
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SalesDashboard()))
              : context.read<LeadController>().responseOfLeads!['user'][0]['role'] == 3
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ManagerDashboard()))
              : SalesLogin());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF033566),
        child: Image.asset(introGif),
      ),
    );
  }
}
