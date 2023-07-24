import 'dart:developer';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/newleads.controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/p_theme.dart';
import '../widget/widgets.dart' as nav;

final newLeadsPageStorage = PageStorageBucket();

class ONewLeads extends StatefulWidget {
  const ONewLeads({super.key});

  @override
  State<ONewLeads> createState() => _ONewLeadsState();
}

class _ONewLeadsState extends State<ONewLeads> {
  var lead;
  @override
  void initState() {
    lead = context.read<NewLeadsController>().fetchNewLeads();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final leadController =
        Provider.of<NewLeadsController>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            dark ? CustomAppTheme().colorDarkBlue : CustomAppTheme().background,
        appBar: AppBar(
          elevation: 0,
          title: Image(
            image: dark
                ? const AssetImage("assets/images/logo/hikallogo.png")
                : const AssetImage("assets/images/logo/fullLogoRE.png"),
            height: 40,
          ),
          backgroundColor: dark
              ? CustomAppTheme().colorDarkBlue
              : CustomAppTheme().colorWhite,
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: dark
                ? CustomAppTheme().colorLightGrey
                : CustomAppTheme().colorDarkBlue,
          ),
          actions: [
            Center(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined),
                    onPressed: () => null,
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: const SafeArea(
          child: nav.NavigationDrawer(),
        ),
        body: PageStorage(
          bucket: newLeadsPageStorage,
          child: EasyRefresh(
            simultaneously: true,
            controller: leadController.controller,
            onLoad: leadController.onLoading,
            header: const ClassicHeader(
                processedDuration: Duration(milliseconds: 100)),
            footer: const ClassicFooter(noMoreText: "No more Users"),
            child: ListView.builder(
              key: const PageStorageKey<String>('new_leads_list'),
              itemCount: leadController.apiModel?.newLeads?.data?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: dark
                        ? CustomAppTheme().colorDarkGrey
                        : CustomAppTheme().colorWhite,
                    elevation: 0,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: (leadController.apiModel!.newLeads
                                            ?.data![index].coldcall ==
                                        1
                                    ? CustomAppTheme().colorLightGrey
                                    : CustomAppTheme().feedbackNew),
                                width: 5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    leadController.apiModel!.newLeads!
                                            .data![index].leadName ??
                                        '',
                                    style: TextStyle(
                                      color: dark
                                          ? CustomAppTheme().colorWhite
                                          : CustomAppTheme().colorBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    leadController.apiModel!.newLeads
                                                ?.data![index].coldcall ==
                                            1
                                        ? 'COLD | ${leadController.apiModel!.newLeads!.data![index].feedback}'
                                        : '${leadController.apiModel!.newLeads!.data![index].feedback}',
                                    style: TextStyle(
                                      color: dark
                                          ? CustomAppTheme().colorLightGrey
                                          : CustomAppTheme().colorDarkBlue,
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        leadController.apiModel!.newLeads
                                                    ?.data![index].project ==
                                                null
                                            ? 'Project: '
                                            : leadController
                                                        .apiModel!
                                                        .newLeads
                                                        ?.data![index]
                                                        .project ==
                                                    ""
                                                ? 'Project: '
                                                : '${leadController.apiModel!.newLeads?.data![index].project} ',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      Text(
                                        leadController.apiModel!.newLeads
                                                    ?.data![index].leadFor ==
                                                null
                                            ? ''
                                            : leadController
                                                        .apiModel!
                                                        .newLeads
                                                        ?.data![index]
                                                        .leadFor ==
                                                    ""
                                                ? ''
                                                : '(${leadController.apiModel!.newLeads?.data![index].leadFor})',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        leadController
                                                    .apiModel!
                                                    .newLeads
                                                    ?.data![index]
                                                    .enquiryType ==
                                                null
                                            ? 'Enquiry: '
                                            : leadController
                                                        .apiModel!
                                                        .newLeads
                                                        ?.data![index]
                                                        .enquiryType ==
                                                    ""
                                                ? 'Enquiry: '
                                                : '${leadController.apiModel!.newLeads?.data![index].enquiryType} ',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      Text(
                                        leadController.apiModel!.newLeads
                                                    ?.data![index].leadType ==
                                                null
                                            ? ''
                                            : '${leadController.apiModel!.newLeads?.data![index].leadType}',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () async {
                                  launchUrl(Uri.parse(
                                      'tel://${leadController.apiModel!.newLeads!.data![index].leadContact}'));
                                },
                                icon: const Icon(Icons.call),
                                color: dark
                                    ? CustomAppTheme().colorLightGrey
                                    : CustomAppTheme().colorDarkBlue,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'whatsapp://send?phone=${leadController.apiModel!.newLeads!.data![index].leadContact}'));
                                },
                                icon: const Icon(Icons.message_outlined),
                                color: dark
                                    ? CustomAppTheme().colorLightGrey
                                    : CustomAppTheme().colorDarkBlue,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () {
                                  log("hello there!");
                                  // leadNotesSheet(context, dark);
                                },
                                icon: const Icon(Icons.edit_note_sharp),
                                color: dark
                                    ? CustomAppTheme().colorLightGrey
                                    : CustomAppTheme().colorDarkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> leadNotesSheet(BuildContext context, bool dark) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
            // height: MediaQuery.of(context).size.height * 0.9,
            height: 700,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: dark
                  ? CustomAppTheme().colorDarkBlue
                  : CustomAppTheme().background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        Text(
                          'Lead Name',
                          style: TextStyle(
                            color: dark
                                ? CustomAppTheme().colorWhite
                                : CustomAppTheme().colorBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Card(
                          color: CustomAppTheme().feedbackClosedDealGreen,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Feedback',
                              style: TextStyle(
                                color: CustomAppTheme().colorWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      'Project: <PROJECT NAME> <PURPOSE OF ENQUIRY>',
                      style: TextStyle(
                        color: dark
                            ? CustomAppTheme().colorLightGrey
                            : CustomAppTheme().colorDarkGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      'Enquiry: <HOW MANY BEDROOMS> <PROPERTY TYPE>',
                      style: TextStyle(
                        color: dark
                            ? CustomAppTheme().colorLightGrey
                            : CustomAppTheme().colorDarkGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: dark
                            ? CustomAppTheme().colorDarkGrey
                            : CustomAppTheme().colorWhite,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "2022-12-12",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: dark
                                      ? CustomAppTheme().colorLightGrey
                                      : CustomAppTheme().colorDarkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: dark
                                    ? CustomAppTheme().colorGrey
                                    : CustomAppTheme().colorDarkBlue,
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text(
                                  'Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note...',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "Sales name",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Assigned to <SALES AGENT NAME>',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "name of whom assigned",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Assigned to <SALES MANAGER NAME>',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "name of whom assigned",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: dark
                            ? CustomAppTheme().colorDarkGrey
                            : CustomAppTheme().colorWhite,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "2022-12-12",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: dark
                                      ? CustomAppTheme().colorLightGrey
                                      : CustomAppTheme().colorDarkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: dark
                                    ? CustomAppTheme().colorGrey
                                    : CustomAppTheme().colorDarkBlue,
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text(
                                  'Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note...',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "Sales name",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Assigned to <SALES AGENT NAME>',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "name of whom assigned",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Assigned to <SALES MANAGER NAME>',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "name of whom assigned",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: dark
                            ? CustomAppTheme().colorDarkGrey
                            : CustomAppTheme().colorWhite,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "2022-12-12",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: dark
                                      ? CustomAppTheme().colorLightGrey
                                      : CustomAppTheme().colorDarkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: dark
                                    ? CustomAppTheme().colorGrey
                                    : CustomAppTheme().colorDarkBlue,
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text(
                                  'Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note... Note here longest note last note...',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "Sales name",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Assigned to <SALES AGENT NAME>',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "name of whom assigned",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Assigned to <SALES MANAGER NAME>',
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                                subtitle: Text(
                                  "name of whom assigned",
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
        // return Wrap(
        //   children: [
        //     ListTile(
        //       leading: Icon(Icons.share),
        //       title: Text('Share'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.copy),
        //       title: Text('Copy Link'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.edit),
        //       title: Text('Edit'),
        //     ),
        //   ],
        // );
      },
    );
  }
}
