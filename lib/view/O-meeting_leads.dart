import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/call_log.controller.dart';
import 'package:test_project/controller/meetings.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/p_theme.dart';
import '../widget/widgets.dart' as nav;

final meetingStorage = PageStorageBucket();

class OMeetingLeads extends StatefulWidget {
  const OMeetingLeads({super.key});

  @override
  State<OMeetingLeads> createState() => _OMeetingLeadsState();
}

class _OMeetingLeadsState extends State<OMeetingLeads> {
  var lead;
  @override
  void initState() {
    context.read<MeetingsController>().fetchMeetingsData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final meetingController =
        Provider.of<MeetingsController>(context, listen: true);

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
                  // const CircleAvatar(
                  //   backgroundImage: AssetImage("assets/images/logo/hikalagency-icon.png"),
                  //   radius: 17.0,
                  // ),
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
          bucket: meetingStorage,
          child: EasyRefresh(
            simultaneously: true,
            controller: meetingController.controller,
            onLoad: meetingController.onLoading,
            header: const ClassicHeader(
                processedDuration: Duration(milliseconds: 100)),
            footer: const ClassicFooter(noMoreText: "No more Users"),
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
                              child: Column(
                                children: [
                                  Card(
                                    color: dark
                                        ? CustomAppTheme().colorDarkGrey
                                        : CustomAppTheme().colorWhite,
                                    elevation: 0,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    color: (meetingController
                                                                .apiModel!
                                                                .lead
                                                                ?.data![index]
                                                                .meetingStatus ==
                                                            1
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .feedbackMeeting),
                                                    width: 5),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 10,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        meetingController
                                                            .apiModel!
                                                            .lead!
                                                            .data![index]
                                                            .leadName,
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorWhite
                                                              : CustomAppTheme()
                                                                  .colorBlack,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Project: ${meetingController.apiModel!.lead?.data![index].project ?? ""} ${meetingController.apiModel!.lead?.data![index].leadFor == "Investment" ? (meetingController.apiModel!.lead?.data![index].leadFor) : ""}',
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorLightGrey
                                                              : CustomAppTheme()
                                                                  .colorGrey,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Enquiry: ${meetingController.apiModel!.lead?.data![index].enquiryType ?? ""} ${meetingController.apiModel!.lead?.data![index].leadType ?? ""}',
                                                        style: TextStyle(
                                                          color: dark
                                                              ? CustomAppTheme()
                                                                  .colorLightGrey
                                                              : CustomAppTheme()
                                                                  .colorGrey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    alignment:
                                                        Alignment.topRight,
                                                    onPressed: () async {
                                                      launchUrl(Uri.parse(
                                                          'tel://${meetingController.apiModel!.lead?.data![index].leadContact}'));
                                                    },
                                                    icon:
                                                        const Icon(Icons.call),
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .colorDarkBlue,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    alignment:
                                                        Alignment.topRight,
                                                    onPressed: () {
                                                      launchUrl(Uri.parse(
                                                          'whatsapp://send?phone=${meetingController.apiModel!.lead?.data![index].leadContact}'));
                                                    },
                                                    icon: Icon(FontAwesomeIcons
                                                        .whatsapp),
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .colorDarkBlue,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    alignment:
                                                        Alignment.topRight,
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.edit_note_sharp),
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .colorDarkBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: CustomAppTheme()
                                                .feedbackClosedDealGreen,
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
