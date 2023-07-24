// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/leads.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/agents_horizontal_chart_leads.dart';
import '../../widget/widgets.dart' as nav;

// void main() {
//   runApp(const MyApp());
// }

class AgentsProfile extends StatefulWidget {
  const AgentsProfile({super.key});

  @override
  State<AgentsProfile> createState() => _AgentsProfileState();
}

class _AgentsProfileState extends State<AgentsProfile> {
  List noAnswerList = [];
  Map<String, dynamic> details = {};
  Map<String, dynamic> leadStatus = {};
  List leadStatusList = [];

  feedback() {
    final controller = context.read<LeadController>();

    for (var i in controller.leadModel.userLeads!.data!) {
      noAnswerList.add(i.feedback);
    }

    for (var i in noAnswerList) {
      details[i] = (details[i] ?? 0) + 1;
    }

    log(details.toString());

    // log(noAnswerList.toString());
  }

  leadStatusFunc() {
    final controller = context.read<LeadController>();

    for (var i in controller.leadModel.userLeads!.data!) {
      leadStatusList.add(i.leadStatus);
    }

    for (var i in leadStatusList) {
      leadStatus[i] = (leadStatus[i] ?? 0) + 1;
    }

    log(leadStatus.toString());

    // log(noAnswerList.toString());
  }

  @override
  void initState() {
    feedback();
    leadStatusFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Provider.of<LeadController>(context, listen: true);

    return Scaffold(
      backgroundColor:
          dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
        iconTheme: IconThemeData(
          color: dark ? CustomAppTheme().redBright : CustomAppTheme().blackFade,
        ),
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: dark
                        ? CustomAppTheme().redBright
                        : CustomAppTheme().blackFade,
                  ),
                  onPressed: null,
                ),
                const SizedBox(
                  width: 0,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: nav.MNavigationDrawer(),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Card(
                  color: CustomAppTheme().redDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11.0),
                            child: const Image(
                              image: AssetImage(
                                "assets/images/logo/playstore.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sales Agent Name',
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomAppTheme().colorWhite,
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Text(
                              'Position',
                              style: TextStyle(
                                color: CustomAppTheme().lightBg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Card(
                  color: dark
                      ? CustomAppTheme().backgroundDark
                      : CustomAppTheme().colorWhite,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: AgentsHorizontalChartLeads(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TabBar(
                  indicatorColor: dark
                      ? CustomAppTheme().colorWhite
                      : CustomAppTheme().blackFade,
                  labelColor: dark
                      ? CustomAppTheme().redBright
                      : CustomAppTheme().redDark,
                  unselectedLabelColor: dark
                      ? CustomAppTheme().colorGrey
                      : CustomAppTheme().colorDarkGrey,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.person_outline),
                    ),
                    Tab(
                      icon: Icon(Icons.work_outline),
                    ),
                    Tab(
                      icon: Icon(Icons.call),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height - 375, //height of TabBarView
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: dark
                            ? CustomAppTheme().colorDarkGrey
                            : CustomAppTheme().colorLightGrey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TabBarView(
                    children: <Widget>[
                      // PERSONAL DETAILS
                      SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Card(
                                      color: dark
                                          ? CustomAppTheme().backgroundDark
                                          : CustomAppTheme().blackFade,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.cake_outlined,
                                              color: dark
                                                  ? CustomAppTheme().lightBg
                                                  : CustomAppTheme().colorWhite,
                                            ),
                                            const SizedBox(
                                              width: 11.0,
                                            ),
                                            Text(
                                              controller.leadModel.user!.isEmpty
                                                  ? ''
                                                  : controller.leadModel
                                                              .user![0].dob ==
                                                          "1969-12-30"
                                                      ? "-------"
                                                      : controller
                                                                  .leadModel
                                                                  .user![0]
                                                                  .dob ==
                                                              "0000-00-00"
                                                          ? "-------"
                                                          : controller
                                                                      .leadModel
                                                                      .user![0]
                                                                      .dob ==
                                                                  null
                                                              ? "-------"
                                                              : controller
                                                                  .leadModel
                                                                  .user![0]
                                                                  .dob
                                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                        .colorWhite
                                                    : CustomAppTheme()
                                                        .colorWhite,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Card(
                                      color: dark
                                          ? CustomAppTheme().backgroundDark
                                          : CustomAppTheme().blackFade,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.transgender_outlined,
                                              color: dark
                                                  ? CustomAppTheme().lightBg
                                                  : CustomAppTheme().colorWhite,
                                            ),
                                            const SizedBox(
                                              width: 11.0,
                                            ),
                                            Text(
                                              controller.leadModel.user!.isEmpty
                                                  ? ''
                                                  : controller
                                                              .leadModel
                                                              .user![0]
                                                              .gender ==
                                                          "Male"
                                                      ? "Male"
                                                      : controller
                                                                  .leadModel
                                                                  .user![0]
                                                                  .gender ==
                                                              "Female"
                                                          ? "Female"
                                                          : "-------",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                        .colorWhite
                                                    : CustomAppTheme()
                                                        .colorWhite,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  color: CustomAppTheme().redDark,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorWhite,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Text(
                                          controller.leadModel.user!.isEmpty
                                              ? ''
                                              : controller.leadModel.user![0]
                                                      .userContact ??
                                                  "-------",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: dark
                                                ? CustomAppTheme().colorWhite
                                                : CustomAppTheme().colorWhite,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25.0,
                                        ),
                                        Text(
                                          controller.leadModel.user!.isEmpty
                                              ? ''
                                              : controller.leadModel.user?[0]
                                                      .userAltContact ??
                                                  "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: dark
                                                ? CustomAppTheme().colorWhite
                                                : CustomAppTheme().blackFade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  color: dark
                                      ? CustomAppTheme().colorBlack
                                      : CustomAppTheme().redDark,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail_outline_outlined,
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorWhite,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Text(
                                          controller.leadModel.user!.isEmpty
                                              ? ''
                                              : controller.leadModel.user![0]
                                                      .userEmail ??
                                                  "-------",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: dark
                                                ? CustomAppTheme().colorWhite
                                                : CustomAppTheme().colorWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              controller.leadModel.user!.isEmpty
                                  ? Text('')
                                  : controller.leadModel.user![0]
                                              .userAltEmail !=
                                          null
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                            color: dark
                                                ? CustomAppTheme().colorBlack
                                                : CustomAppTheme().redDark,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.mail_outline_outlined,
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .colorWhite,
                                                  ),
                                                  const SizedBox(
                                                    width: 11.0,
                                                  ),
                                                  Text(
                                                    controller.leadModel
                                                        .user![0].userAltEmail
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorWhite
                                                          : CustomAppTheme()
                                                              .colorWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Text(""),
                            ],
                          ),
                        ),
                      ),
                      // WORK DETAILS

                      SingleChildScrollView(
                        child: controller.responseOfLeads == null
                            ? const CircularProgressIndicator.adaptive()
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Card(
                                            color: dark
                                                ? CustomAppTheme().redDark
                                                : CustomAppTheme().redDark,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'CLOSED DEALS',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .lightBg,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    controller
                                                                .leadModel
                                                                .leadStatus!
                                                                .closed ==
                                                            null
                                                        ? "0"
                                                        : controller.leadModel
                                                            .leadStatus!.closed
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .colorWhite,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .backgroundDark
                                                : CustomAppTheme().colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'MEETINGS',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    controller
                                                                .leadModel
                                                                .leadStatus!
                                                                .meeting ==
                                                            null
                                                        ? "0"
                                                        : controller.leadModel
                                                            .leadStatus!.meeting
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .backgroundDark
                                                : CustomAppTheme().colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'FOLLOW UP',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    controller
                                                                .leadModel
                                                                .leadStatus!
                                                                .followup ==
                                                            null
                                                        ? "0"
                                                        : controller
                                                            .leadModel
                                                            .leadStatus!
                                                            .followup
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .backgroundDark
                                                : CustomAppTheme().colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'NEW',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    leadStatus['New']
                                                                .toString() ==
                                                            "null"
                                                        ? "0"
                                                        : leadStatus['New']
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme().colorBlack
                                                : CustomAppTheme().blackFade,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'TOTAL',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .lightBg,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    controller.leadModel
                                                                .count ==
                                                            null
                                                        ? "0"
                                                        : controller.leadModel
                                                            .userLeads!.total
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .colorWhite,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .backgroundDark
                                                : CustomAppTheme().colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'NO ANSWER',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    details['No Answer']
                                                                .toString() ==
                                                            "null"
                                                        ? "0"
                                                        : details['No Answer']
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .backgroundDark
                                                : CustomAppTheme().colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'UNREACHABLE',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    controller
                                                                .leadModel
                                                                .leadStatus!
                                                                .unreachable ==
                                                            0
                                                        ? "0"
                                                        : controller
                                                            .leadModel
                                                            .leadStatus!
                                                            .unreachable
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .backgroundDark
                                                : CustomAppTheme().colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'NOT INTERESTED',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    details['Not Interested']
                                                                .toString() ==
                                                            "null"
                                                        ? "0"
                                                        : details[
                                                                'Not Interested']
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      // SETTINGS
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 10.0, 10.0, 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Card(
                                      color: dark
                                          ? CustomAppTheme().redDark
                                          : CustomAppTheme().redDark,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'OUTGOING CALLS',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .lightBg,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '300',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .colorWhite,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: dark
                                          ? CustomAppTheme()
                                          .backgroundDark
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ANSWERED',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '100',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: dark
                                          ? CustomAppTheme()
                                          .backgroundDark
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'NOT ANSWERED',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '200',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: dark
                                          ? CustomAppTheme().colorBlack
                                          : CustomAppTheme().blackFade,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'INCOMING CALLS',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .lightBg,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '100',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .colorWhite,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: dark
                                          ? CustomAppTheme()
                                          .backgroundDark
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'RECEIVED',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '95',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: dark
                                          ? CustomAppTheme()
                                          .backgroundDark
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'MISSED',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '5',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                    .colorLightGrey
                                                    : CustomAppTheme()
                                                    .blackFade,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final dataMapTarget = <String, double>{
  "Reached": 50000000,
  "Remaining": 20000000,
};

final dataMapLeads = <String, double>{
  "Closed Deal": 57,
  "New Lead": 20,
  "Meeting": 72,
  "Follow Up": 309,
  "No Answer": 49,
  "Low Budget": 19,
  "Not Interested": 71,
  "Unreachable": 20,
};

final colorListTarget = <Color>[
  const Color(0xFF133465),
  const Color(0xFF8C8C8C),
];

final colorListLeads = <Color>[
  const Color(0xFF133465),
  Colors.lightBlueAccent,
  const Color(0xFF68B532),
  Colors.yellow.shade600,
  const Color(0xFFD3D3D3),
  Colors.orange,
  Colors.red.shade600,
  const Color(0xFF949494)
];
