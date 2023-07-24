import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/cold_leads.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/onpress_bottomsheet.dart';
import '../../controller/get_leads.controller.dart';
import '../../controller/lead.notes.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final leadsStorage = PageStorageBucket();

class MHotLeads extends StatefulWidget {
  const MHotLeads({super.key});

  @override
  State<MHotLeads> createState() => _MHotLeadsState();
}

class _MHotLeadsState extends State<MHotLeads> with TickerProviderStateMixin {
  late AnimationController bottomSheetController;

  @override
  void initState() {
    super.initState();
    context.read<GetSalesLeadController>().fetchMyUsers();
    context.read<ColdLeadsController>().fetchColdLeads();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final noteLeadController =
        Provider.of<LeadsNotesController>(context, listen: false);

    return Scaffold(
      backgroundColor:
          dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
      appBar: AppBar(
        elevation: 0,
        title: Image(
          image: dark
              ? const AssetImage("assets/images/logo/hikallogo.png")
              : const AssetImage("assets/images/logo/fullLogoRE.png"),
          height: 30,
        ),
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
      body: PageStorage(
        bucket: leadsStorage,
        child: Consumer<GetSalesLeadController>(
            builder: (context, getLeadsController, _) {
          return getLeadsController.apiModel?.userLeads?.data == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : Consumer<GetSalesLeadController>(
                  builder: (context, getLeadsController, _) {
                  return EasyRefresh(
                    simultaneously: true,
                    controller: getLeadsController.controller,
                    onLoad: getLeadsController.onLoading,
                    header: const ClassicHeader(
                        processedDuration: Duration(milliseconds: 100)),
                    footer: const ClassicFooter(noMoreText: "No more Users"),
                    child: ListView.builder(
                      addAutomaticKeepAlives: false,
                      key: PageStorageKey<String>('hot_tab'),
                      itemCount: getLeadsController
                              .apiModel?.userLeads?.data?.length ??
                          0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        log("new leads total count is ${getLeadsController.apiModel?.userLeads?.data?.length}");

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
                                          color: getLeadsController
                                                      .apiModel!
                                                      .userLeads!
                                                      .data![index]
                                                      .feedback ==
                                                  "Closed Deal"
                                              ? CustomAppTheme()
                                                  .feedbackClosedDealGreen
                                              : getLeadsController
                                                          .apiModel!
                                                          .userLeads!
                                                          .data![index]
                                                          .feedback ==
                                                      "New"
                                                  ? CustomAppTheme().feedbackNew
                                                  : getLeadsController
                                                              .apiModel!
                                                              .userLeads!
                                                              .data![index]
                                                              .feedback ==
                                                          "Meeting"
                                                      ? CustomAppTheme()
                                                          .feedbackMeeting
                                                      : getLeadsController
                                                                  .apiModel!
                                                                  .userLeads!
                                                                  .data![index]
                                                                  .feedback ==
                                                              "Follow Up"
                                                          ? CustomAppTheme()
                                                              .feedbackFollowUp
                                                          : getLeadsController
                                                                      .apiModel!
                                                                      .userLeads!
                                                                      .data![
                                                                          index]
                                                                      .feedback ==
                                                                  "No Answer"
                                                              ? CustomAppTheme()
                                                                  .feedbackNoAnswer
                                                              : getLeadsController
                                                                          .apiModel!
                                                                          .userLeads!
                                                                          .data![
                                                                              index]
                                                                          .feedback ==
                                                                      "Low Budget"
                                                                  ? CustomAppTheme()
                                                                      .feedbackLowBudget
                                                                  : getLeadsController
                                                                              .apiModel!
                                                                              .userLeads!
                                                                              .data![index]
                                                                              .feedback ==
                                                                          "Not Interested"
                                                                      ? CustomAppTheme().feedbackNotInterested
                                                                      : getLeadsController.apiModel!.userLeads!.data![index].feedback == "Unreachable"
                                                                          ? CustomAppTheme().feedbackUnreachable
                                                                          : getLeadsController.apiModel!.userLeads!.data![index].feedback == "Duplicate"
                                                                              ? CustomAppTheme().colorBlack
                                                                              : CustomAppTheme().colorDarkBlue,
                                          width: 5),
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
                                              getLeadsController
                                                  .apiModel!
                                                  .userLeads!
                                                  .data![index]
                                                  .leadName
                                                  .toString(),
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                        .colorWhite
                                                    : CustomAppTheme()
                                                        .colorBlack,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              getLeadsController
                                                  .apiModel!
                                                  .userLeads!
                                                  .data![index]
                                                  .feedback
                                                  .toString(),
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme().redBright
                                                    : CustomAppTheme().redDark,
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
                                                  getLeadsController
                                                              .apiModel
                                                              ?.userLeads
                                                              ?.data?[index]
                                                              .project ==
                                                          null
                                                      ? 'Project: '
                                                      : getLeadsController
                                                                  .apiModel
                                                                  ?.userLeads
                                                                  ?.data?[index]
                                                                  .project ==
                                                              ""
                                                          ? 'Project: '
                                                          : '${getLeadsController.apiModel?.userLeads?.data?[index].project} ',
                                                  style: TextStyle(
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .blackFade,
                                                  ),
                                                ),
                                                Text(
                                                  getLeadsController
                                                              .apiModel
                                                              ?.userLeads
                                                              ?.data?[index]
                                                              .leadFor ==
                                                          null
                                                      ? ''
                                                      : getLeadsController
                                                                  .apiModel
                                                                  ?.userLeads
                                                                  ?.data?[index]
                                                                  .leadFor ==
                                                              ""
                                                          ? ''
                                                          : '(${getLeadsController.apiModel!.userLeads!.data![index].leadFor})',
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
                                                  getLeadsController
                                                              .apiModel!
                                                              .userLeads!
                                                              .data![index]
                                                              .enquiryType ==
                                                          null
                                                      ? 'Enquiry: '
                                                      : getLeadsController
                                                                  .apiModel!
                                                                  .userLeads!
                                                                  .data![index]
                                                                  .enquiryType ==
                                                              ""
                                                          ? 'Enquiry: '
                                                          : '${getLeadsController.apiModel!.userLeads!.data![index].enquiryType} ',
                                                  style: TextStyle(
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .blackFade,
                                                  ),
                                                ),
                                                Text(
                                                  getLeadsController
                                                              .apiModel!
                                                              .userLeads!
                                                              .data![index]
                                                              .leadType ==
                                                          null
                                                      ? ''
                                                      : getLeadsController
                                                                  .apiModel!
                                                                  .userLeads!
                                                                  .data![index]
                                                                  .leadType ==
                                                              ''
                                                          ? ''
                                                          : '${getLeadsController.apiModel!.userLeads!.data![index].leadType}',
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
                                      Expanded(
                                        flex: 2,
                                        child: IconButton(
                                          onPressed: () async {
                                            launchUrl(Uri.parse(
                                                'tel://${getLeadsController.apiModel!.userLeads!.data![index].leadContact}'));
                                          },
                                          icon: const Icon(Icons.call),
                                          color: dark
                                              ? CustomAppTheme().redBright
                                              : CustomAppTheme().redBright,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: IconButton(
                                          onPressed: () {
                                            launchUrl(Uri.parse(
                                                'whatsapp://send?phone=${getLeadsController.apiModel!.userLeads!.data![index].leadContact}'));
                                          },
                                          icon: const Icon(
                                              Icons.message_outlined),
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().redBright,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: IconButton(
                                          onPressed: () async {
                                            final passingValues =
                                                getLeadsController.apiModel!
                                                    .userLeads!.data![index];
                                            BottomSheetClass.onpress(
                                                context,
                                                passingValues.id,
                                                passingValues,
                                                dark,
                                                noteLeadController
                                                    .bottomSheetController);
                                          },
                                          icon:
                                              const Icon(Icons.edit_note_sharp),
                                          color: dark
                                              ? CustomAppTheme().redBright
                                              : CustomAppTheme().redBright,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                });
        }),
      ),
    );
  }
}
