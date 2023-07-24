import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/call_log.controller.dart';
import 'package:test_project/controller/meetings.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/onpress_bottomsheet.dart';
import '../../controller/lead.notes.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final meetingStorage = PageStorageBucket();

class MeetingLeads extends StatefulWidget {
  const MeetingLeads({super.key});

  @override
  State<MeetingLeads> createState() => _MeetingLeadsState();
}

class _MeetingLeadsState extends State<MeetingLeads> {
  @override
  void initState() {
    super.initState();
    context.read<MeetingsController>().fetchMeetingsData();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final noteLeadController = Provider.of<LeadsNotesController>(context, listen: false);
    final meetingController = Provider.of<MeetingsController>(context, listen: true);

    return Scaffold(
      backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
      appBar: AppBar(
        elevation: 0,
        title: Image(
          image: dark
              ? const AssetImage("assets/images/logo/hikallogo.png")
              : const AssetImage("assets/images/logo/fullLogoRE.png"),
          height: 30,
        ),
        backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
        iconTheme: IconThemeData(
          color:
              dark ? CustomAppTheme().redBright : CustomAppTheme().blackFade,
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
      drawer: nav.NavigationDrawer(),
      body: PageStorage(
        bucket: meetingStorage,
        child: EasyRefresh(
          simultaneously: true,
          controller: meetingController.controller,
          onLoad: meetingController.onLoading,
          header: const ClassicHeader(
              processedDuration: Duration(milliseconds: 100)),
          footer: const ClassicFooter(noMoreText: "No more leads"),
          child: SingleChildScrollView(
            key: PageStorageKey<String>('meetings'),
            physics: ScrollPhysics(),
            child: Column(
              children: [
                meetingController.apiModel?.lead?.data == null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: meetingController.apiModel?.count ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: double.infinity,
                              child: Card(
                                color: dark ? CustomAppTheme().cardGrey : CustomAppTheme().colorWhite,
                                elevation: 0,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color: (meetingController.apiModel!.lead?.data![index].meetingStatus == "Pending"
                                              ? CustomAppTheme().feedbackFollowUp
                                              : meetingController.apiModel!.lead?.data![index].meetingStatus == "Postponed"
                                              ? CustomAppTheme().feedbackFollowUp
                                              : meetingController.apiModel!.lead?.data![index].meetingStatus == "Attended"
                                              ? CustomAppTheme().feedbackClosedDealGreen
                                              : meetingController.apiModel!.lead?.data![index].meetingStatus == "Cancelled"
                                              ? CustomAppTheme().feedbackNotInterested
                                              : CustomAppTheme().redDark),
                                              width: 5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 15,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${meetingController.apiModel!.lead?.data![index].leadName}',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorWhite
                                                          : CustomAppTheme()
                                                              .colorBlack,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${meetingController.apiModel!.lead?.data![index].meetingStatus}',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .redBright
                                                          : CustomAppTheme()
                                                              .redDark,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        meetingController
                                                                    .apiModel!
                                                                    .lead
                                                                    ?.data![
                                                                        index]
                                                                    .project ==
                                                                null
                                                            ? 'Project: '
                                                            : meetingController
                                                                        .apiModel!
                                                                        .lead
                                                                        ?.data![
                                                                            index]
                                                                        .project ==
                                                                    ""
                                                                ? 'Project: '
                                                                : '${meetingController.apiModel!.lead?.data![index].project} ',
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorLightGrey
                                                              : CustomAppTheme()
                                                                  .blackFade,
                                                        ),
                                                      ),
                                                      Text(
                                                        meetingController
                                                                    .apiModel!
                                                                    .lead
                                                                    ?.data![
                                                                        index]
                                                                    .leadFor ==
                                                                null
                                                            ? ''
                                                            : meetingController
                                                                        .apiModel!
                                                                        .lead
                                                                        ?.data![
                                                                            index]
                                                                        .leadFor ==
                                                                    ""
                                                                ? ''
                                                                : '(${meetingController.apiModel!.lead?.data![index].leadFor})',
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorLightGrey
                                                              : CustomAppTheme()
                                                                  .blackFade,
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
                                                        meetingController
                                                                    .apiModel!
                                                                    .lead
                                                                    ?.data![
                                                                        index]
                                                                    .enquiryType ==
                                                                null
                                                            ? 'Enquiry: '
                                                            : meetingController
                                                                        .apiModel!
                                                                        .lead
                                                                        ?.data![
                                                                            index]
                                                                        .enquiryType ==
                                                                    ""
                                                                ? 'Enquiry: '
                                                                : '${meetingController.apiModel!.lead?.data![index].enquiryType} ',
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorLightGrey
                                                              : CustomAppTheme()
                                                                  .blackFade,
                                                        ),
                                                      ),
                                                      Text(
                                                        meetingController
                                                                    .apiModel!
                                                                    .lead
                                                                    ?.data![
                                                                        index]
                                                                    .leadType ==
                                                                null
                                                            ? ''
                                                            : meetingController
                                                                        .apiModel!
                                                                        .lead
                                                                        ?.data![
                                                                            index]
                                                                        .leadType ==
                                                                    ''
                                                                ? ''
                                                                : '${meetingController.apiModel!.lead?.data![index].leadType}',
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorLightGrey
                                                              : CustomAppTheme()
                                                                  .blackFade,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // meetingController.apiModel!.lead?.data![index].isWhatsapp == 1
                                            //     ?
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(
                                                        'whatsapp://send?phone=${meetingController.apiModel!.lead?.data![index].leadContact}'));
                                                  },
                                                  icon: FaIcon(FontAwesomeIcons.whatsapp),
                                                  // icon: const Icon(
                                                  //     Icons.mark_chat_unread_outlined),
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().redBright,
                                                ),
                                              ),
                                            ),
                                            //     : SizedBox(
                                            //   width: 0.0,
                                            // ),

                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () async {
                                                    launchUrl(Uri.parse(
                                                        'tel://${meetingController.apiModel!.lead?.data![index]}'));
                                                  },
                                                  icon: const Icon(Icons.call_outlined),
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().redBright,
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () async {
                                                    final passingValues = meetingController.apiModel!.lead!.data![index];
                                                    BottomSheetClass.onpress(
                                                        context,
                                                        passingValues.lid,
                                                        passingValues,
                                                        dark,
                                                        noteLeadController.bottomSheetController
                                                    );
                                                  },
                                                  icon: const Icon(Icons.info_outlined),
                                                  color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().redBright,
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        color: dark
                                            ? CustomAppTheme().backgroundDark
                                            : CustomAppTheme().colorBlack,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                context
                                                    .read<CallLogController>()
                                                    .dateTimeObject(
                                                      meetingController
                                                          .apiModel!
                                                          .lead!
                                                          .data![index]
                                                          .meetingDate
                                                          .toString(),
                                                    ),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: CustomAppTheme()
                                                      .colorWhite,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                // context.read<CallLogController>().dateTimeObject(
                                                '${meetingController.apiModel!.lead!.data![index].meetingTime}',
                                                // ),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: CustomAppTheme()
                                                      .colorWhite,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
