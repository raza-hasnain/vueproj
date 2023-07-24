// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/logout.controller.dart';
import 'package:test_project/view/privacy_policy.dart';

import '../controller/leads.controller.dart';
import '../theme/p_theme.dart';
import '../widget/Profile/horizontal_chart_leads.dart';
import '../widget/widgets.dart' as nav;
import 'change_password.dart';

class SalesProfile extends StatefulWidget {
  const SalesProfile({super.key});

  @override
  State<SalesProfile> createState() => _SalesProfileState();
}

class _SalesProfileState extends State<SalesProfile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Provider.of<LeadController>(context, listen: true);

    final totalLeads = controller.leadModel.leadStatus!.closed!
        + controller.leadModel.leadStatus!.meeting!
        + controller.leadModel.leadStatus!.followup!
        + controller.leadModel.leadStatus!.neww!
        + controller.leadModel.leadStatus!.low!
        + controller.leadModel.leadStatus!.noanswer!
        + controller.leadModel.leadStatus!.unreachable!
        + controller.leadModel.leadStatus!.notinterested!;

    return Scaffold(
      backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
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
      drawer: SafeArea(
        child: Consumer<LeadController>(builder: (context, role, _) {
          return role.leadModel.user![0].role == 7
          ? nav.NavigationDrawer()
          : role.leadModel.user![0].role == 3
          ? nav.MNavigationDrawer()
          : nav.NavigationDrawer();
        }),
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Card(
                  color: CustomAppTheme().redBright,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11.0),
                            child: Consumer<LeadController>(
                              builder: (context, userImage, _) {
                                // return userImage.responseOfLeads == null
                                return userImage.leadModel.user!.isEmpty
                                    ? const Image(
                                        image: AssetImage(
                                            "assets/images/logo/hikalagency-icon.png"),
                                      )
                                    : userImage.leadModel.user![0].displayImg ==
                                            null
                                        ? const Image(
                                            image: AssetImage(
                                                "assets/images/logo/hikalagency-icon.png"),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl: userImage
                                                      .leadModel.user!.isEmpty
                                                  ? 'assets/images/logo/playstore.png'
                                                  : userImage.leadModel.user![0]
                                                      .displayImg
                                                      .toString(),
                                            ),
                                          );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<LeadController>(
                                builder: (context, name, _) {
                              return name.responseOfLeads == null
                                  ? Text(
                                      "...",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: CustomAppTheme().colorWhite,
                                      ),
                                    )
                                  : Text(
                                      name.leadModel.user!.isEmpty
                                          ? ''
                                          : name.leadModel.user![0].userName.toString(),
                                      softWrap: false,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: CustomAppTheme().colorWhite,
                                      ),
                                    );
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<LeadController>(builder: (context, position, _) {
                              return position.responseOfLeads == null
                              ? Text(
                                "",
                                style: TextStyle(
                                  color: CustomAppTheme().lightBg,
                                ),
                              )
                              : Text(
                                position.leadModel.user!.isEmpty
                                ? ''
                                : position.leadModel.user![0].position
                                .toString(),
                                style: TextStyle(
                                  color: CustomAppTheme().lightBg,
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 10.0,
                            ),
                            context.read<LeadController>().responseOfLeads!['user'][0]['role'] == 7
                            ? Consumer<LeadController>(builder: (context, manager, _) {
                              return manager.responseOfLeads == null
                              ? Text(
                                "",
                                style: TextStyle(
                                  color: CustomAppTheme().lightBg,
                                ),
                              )
                              : Text(
                                manager.leadModel.user!.isEmpty
                                    ? ''
                                    : 'Manager: ${manager.leadModel.user![0].addedFor}', // TODO DISPLAY MANAGER NAME FROM ID VIA COLUMN 'addedFor' WITH RESPECT TO users.id
                                style: TextStyle(
                                  color: CustomAppTheme().lightBg,
                                ),
                              );
                            })
                            : Text(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: Card(
                  // color: dark ? CustomAppTheme().cardGrey : CustomAppTheme().colorWhite,
                  color: dark ? Colors.transparent : CustomAppTheme().colorWhite,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: HorizontalChartLeads(),
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
                  labelColor: CustomAppTheme().redBright,
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
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height / 1.9,
                  child:
                  TabBarView(
                    children: <Widget>[
                      // PERSONAL DETAILS
                      SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Card(
                            elevation: 0,
                            color: dark ? CustomAppTheme().cardGrey : CustomAppTheme().colorWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cake_outlined,
                                          color: CustomAppTheme().redBright,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Flexible(
                                          child: Text(
                                            controller.leadModel.user!.isEmpty
                                            ? ''
                                            : controller.leadModel.user![0].dob == "1969-12-30"
                                            ? "-------"
                                            : controller.leadModel.user![0].dob == "1970-01-01"
                                            ? "-------"
                                            : controller.leadModel.user![0].dob == "0000-00-00"
                                            ? "-------"
                                            : controller.leadModel.user![0].dob == null
                                            ? "-------"
                                            : controller.leadModel.user![0].dob.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().blackFade,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.transgender_outlined,
                                          color: CustomAppTheme().redBright,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Flexible(
                                          child: Text(
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
                                                      .blackFade,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.pin_drop_outlined,
                                          color: CustomAppTheme().redBright,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Flexible(
                                          child: Text(
                                            controller.leadModel.user![0].nationality ?? "-------",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: dark
                                                  ? CustomAppTheme()
                                                  .colorWhite
                                                  : CustomAppTheme()
                                                  .blackFade,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Divider(
                                      height: 5.0,
                                      color: CustomAppTheme().redBright,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          color: CustomAppTheme().redBright,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Flexible (
                                          child: Text(
                                            controller.leadModel.user!.isEmpty
                                                ? ''
                                                : controller.leadModel.user![0]
                                                        .userContact ??
                                                    "-------",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: dark
                                                  ? CustomAppTheme().colorWhite
                                                  : CustomAppTheme().blackFade,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25.0,
                                        ),
                                        Flexible(
                                          child: Text(
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail_outline_outlined,
                                          color: CustomAppTheme().redBright,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Flexible(
                                          child: Text(
                                            controller.leadModel.user!.isEmpty
                                                ? ''
                                                : controller.leadModel.user![0]
                                                        .userEmail ??
                                                    "-------",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: dark
                                                  ? CustomAppTheme().colorWhite
                                                  : CustomAppTheme().blackFade,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  controller.leadModel.user![0].userAltEmail != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail_outline_outlined,
                                          color: CustomAppTheme().redBright,
                                        ),
                                        const SizedBox(
                                          width: 11.0,
                                        ),
                                        Flexible(
                                          child: Text(
                                            controller.leadModel
                                                .user![0].userAltEmail
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: dark
                                                  ? CustomAppTheme()
                                                      .colorWhite
                                                  : CustomAppTheme()
                                                      .blackFade,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : const Text(""),

                                  // TODO FOR ROLE 3 MANAGER
                                  controller.leadModel.user![0].role == 3
                                  ? Column(
                                    children: [
                                      Divider(
                                        height: 5.0,
                                        color: CustomAppTheme().redBright,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.people_alt_outlined,
                                              color: CustomAppTheme().redBright,
                                            ),
                                            const SizedBox(
                                              width: 11.0,
                                            ),
                                            Flexible(
                                              child: Text(
                                                'Sales Agents: 5', // TODO SALES AGENT COUNT
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().blackFade,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                  : const Text(""),
                                ],
                              ),
                            ),
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Card(
                                        color: CustomAppTheme().redBright,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3.0),
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
                                                          .colorWhite
                                                      : CustomAppTheme()
                                                          .lightBg,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.leadStatus!.closed == null
                                                ? "0"
                                                : controller.leadModel.leadStatus!.closed.toString(),
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
                                                .cardGrey
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
                                                          .colorWhite
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
                                                .cardGrey
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
                                                          .colorWhite
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
                                                          .colorWhite
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
                                                .cardGrey
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
                                                          .colorWhite
                                                      : CustomAppTheme()
                                                          .blackFade,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.leadStatus!.neww == null
                                                ? "0"
                                                : controller.leadModel.leadStatus!.neww.toString(),
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorWhite
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
                                        color: CustomAppTheme().redBright,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'TOTAL',
                                                style: TextStyle(
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().lightBg,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.count == null
                                                ? "0"
                                                : '${totalLeads}',
                                                style: TextStyle(
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().colorWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        color: dark ? CustomAppTheme().cardGrey : CustomAppTheme().colorWhite,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'LOW BUDGET',
                                                style: TextStyle(
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().blackFade,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.leadStatus!.low == null
                                                    ? "0"
                                                    : controller.leadModel.leadStatus!.low.toString(),
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                      .colorWhite
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
                                                .cardGrey
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
                                                          .colorWhite
                                                      : CustomAppTheme()
                                                          .blackFade,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.leadStatus!.noanswer == null
                                                    ? "0"
                                                    : controller.leadModel.leadStatus!.noanswer.toString(),
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorWhite
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
                                                .cardGrey
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
                                                          .colorWhite
                                                      : CustomAppTheme()
                                                          .blackFade,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.leadStatus!.unreachable == 0
                                                    ? "0"
                                                    : controller.leadModel.leadStatus!.unreachable.toString(),
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorWhite
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
                                                .cardGrey
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
                                                          .colorWhite
                                                      : CustomAppTheme()
                                                          .blackFade,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.leadModel.leadStatus!.notinterested == null
                                                    ? "0"
                                                    : controller.leadModel.leadStatus!.notinterested.toString(),
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorWhite
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
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                child: Card(
                                  color: CustomAppTheme().redBright,
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'UPDATE PROFILE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CustomAppTheme().colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              GestureDetector(
                                child: Card(
                                  color: CustomAppTheme().redBright,
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'CHANGE PASSWORD',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: dark
                                            ? CustomAppTheme().colorWhite
                                            : CustomAppTheme().colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ChangePassword()));
                                },
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              GestureDetector(
                                child: Card(
                                  color: CustomAppTheme().redBright,
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'LOG OUT',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: dark
                                            ? CustomAppTheme().colorWhite
                                            : CustomAppTheme().colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  context.read<Logout>().logoutFunc(context);
                                },
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              GestureDetector(
                                child: Card(
                                  color: CustomAppTheme().redBright,
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'PRIVACY POLICY',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: dark
                                            ? CustomAppTheme().colorWhite
                                            : CustomAppTheme().colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                      const PrivacyPolicy()));
                                },
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
