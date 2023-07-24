
import 'package:flutter/material.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;
import 'agents_profile.dart';

final leadsStorage = PageStorageBucket();

class AgentsList extends StatefulWidget {
  const AgentsList({super.key});

  @override
  State<AgentsList> createState() => _AgentsListState();
}

class _AgentsListState extends State<AgentsList> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child:
          // Consumer<GetSalesLeadController>(
          //     builder: (context, getLeadsController, _) {
          //       return getLeadsController.apiModel?.userLeads?.data == null
          //           ? SizedBox(
          //         height: MediaQuery.of(context).size.height,
          //         child: Center(
          //           // child: CircularProgressIndicator.adaptive(),
          //           child: Text(
          //               'NO DATA',
          //               style: TextStyle(
          //                 color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().blackFade,
          //               )
          //           ),
          //         ),
          //       )
          //           : Consumer<GetSalesLeadController>(
          //           builder: (context, getLeadsController, _) {
          //             return EasyRefresh(
          //               simultaneously: true,
          //               controller: getLeadsController.controller,
          //               onLoad: getLeadsController.onLoading,
          //               header: const ClassicHeader(
          //                   processedDuration: Duration(milliseconds: 100)),
          //               footer: const ClassicFooter(noMoreText: "No more Users"),
          //               child: ListView.builder(
          //                 addAutomaticKeepAlives: false,
          //                 key: PageStorageKey<String>('hot_tab'),
          //                 itemCount: getLeadsController.apiModel?.userLeads?.data?.length ?? 0,
          //                 shrinkWrap: true,
          //                 itemBuilder: (context, index) {
          //                   log("new leads total count is ${getLeadsController.apiModel?.userLeads?.data?.length}");
          //
          //                   return SizedBox(
          //                       width: double.infinity,
          //                       child: Card(
          //                         color: dark
          //                             ? CustomAppTheme().colorDarkGrey
          //                             : CustomAppTheme().colorWhite,
          //                         elevation: 0,
          //                         child: ClipPath(
          //                           clipper: ShapeBorderClipper(
          //                             shape: RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.circular(3),
          //                             ),
          //                           ),
          //                           child: Container(
          //                             padding: const EdgeInsets.all(10),
          //                             decoration: BoxDecoration(
          //                               border: Border(
          //                                 left: BorderSide(
          //                                     color: getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![index]
          //                                         .feedback ==
          //                                         "Closed Deal"
          //                                         ? CustomAppTheme()
          //                                         .feedbackClosedDealGreen
          //                                         : getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![index]
          //                                         .feedback ==
          //                                         "New"
          //                                         ? CustomAppTheme().feedbackNew
          //                                         : getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![index]
          //                                         .feedback ==
          //                                         "Meeting"
          //                                         ? CustomAppTheme()
          //                                         .feedbackMeeting
          //                                         : getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![index]
          //                                         .feedback ==
          //                                         "Follow Up"
          //                                         ? CustomAppTheme()
          //                                         .feedbackFollowUp
          //                                         : getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![
          //                                     index]
          //                                         .feedback ==
          //                                         "No Answer"
          //                                         ? CustomAppTheme()
          //                                         .feedbackNoAnswer
          //                                         : getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![
          //                                     index]
          //                                         .feedback ==
          //                                         "Low Budget"
          //                                         ? CustomAppTheme()
          //                                         .feedbackLowBudget
          //                                         : getLeadsController
          //                                         .apiModel!
          //                                         .userLeads!
          //                                         .data![index]
          //                                         .feedback ==
          //                                         "Not Interested"
          //                                         ? CustomAppTheme().feedbackNotInterested
          //                                         : getLeadsController.apiModel!.userLeads!.data![index].feedback == "Unreachable"
          //                                         ? CustomAppTheme().feedbackUnreachable
          //                                         : getLeadsController.apiModel!.userLeads!.data![index].feedback == "Duplicate"
          //                                         ? CustomAppTheme().colorBlack
          //                                         : CustomAppTheme().colorDarkBlue,
          //                                     width: 5),
          //                               ),
          //                             ),
          //                             child: Row(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 15,
          //                                   child: Column(
          //                                     crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                     // mainAxisAlignment: MainAxisAlignment.start,
          //                                     children: [
          //                                       Text(
          //                                         getLeadsController
          //                                             .apiModel!
          //                                             .userLeads!
          //                                             .data![index]
          //                                             .leadName
          //                                             .toString(),
          //                                         style: TextStyle(
          //                                           color: dark
          //                                               ? CustomAppTheme()
          //                                               .colorWhite
          //                                               : CustomAppTheme()
          //                                               .colorBlack,
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 16,
          //                                         ),
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Text(
          //                                         getLeadsController
          //                                             .apiModel!
          //                                             .userLeads!
          //                                             .data![index]
          //                                             .feedback
          //                                             .toString(),
          //                                         style: TextStyle(
          //                                           color: dark
          //                                               ? CustomAppTheme().redBright
          //                                               : CustomAppTheme().redDark,
          //                                           fontWeight: FontWeight.bold,
          //                                           // fontSize: 16,
          //                                         ),
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Row(
          //                                         children: [
          //                                           Text(
          //                                             getLeadsController
          //                                                 .apiModel
          //                                                 ?.userLeads
          //                                                 ?.data?[index]
          //                                                 .project ==
          //                                                 null
          //                                                 ? 'Project: '
          //                                                 : getLeadsController
          //                                                 .apiModel
          //                                                 ?.userLeads
          //                                                 ?.data?[index]
          //                                                 .project ==
          //                                                 ""
          //                                                 ? 'Project: '
          //                                                 : '${getLeadsController.apiModel?.userLeads?.data?[index].project} ',
          //                                             style: TextStyle(
          //                                               color: dark
          //                                                   ? CustomAppTheme()
          //                                                   .colorLightGrey
          //                                                   : CustomAppTheme()
          //                                                   .blackFade,
          //                                             ),
          //                                           ),
          //                                           Text(
          //                                             getLeadsController
          //                                                 .apiModel
          //                                                 ?.userLeads
          //                                                 ?.data?[index]
          //                                                 .leadFor ==
          //                                                 null
          //                                                 ? ''
          //                                                 : getLeadsController
          //                                                 .apiModel
          //                                                 ?.userLeads
          //                                                 ?.data?[index]
          //                                                 .leadFor ==
          //                                                 ""
          //                                                 ? ''
          //                                                 : '(${getLeadsController.apiModel!.userLeads!.data![index].leadFor})',
          //                                             style: TextStyle(
          //                                               color: dark
          //                                                   ? CustomAppTheme()
          //                                                   .colorLightGrey
          //                                                   : CustomAppTheme()
          //                                                   .blackFade,
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Row(
          //                                         children: [
          //                                           Text(
          //                                             getLeadsController
          //                                                 .apiModel!
          //                                                 .userLeads!
          //                                                 .data![index]
          //                                                 .enquiryType ==
          //                                                 null
          //                                                 ? 'Enquiry: '
          //                                                 : getLeadsController
          //                                                 .apiModel!
          //                                                 .userLeads!
          //                                                 .data![index]
          //                                                 .enquiryType ==
          //                                                 ""
          //                                                 ? 'Enquiry: '
          //                                                 : '${getLeadsController.apiModel!.userLeads!.data![index].enquiryType} ',
          //                                             style: TextStyle(
          //                                               color: dark
          //                                                   ? CustomAppTheme()
          //                                                   .colorLightGrey
          //                                                   : CustomAppTheme()
          //                                                   .blackFade,
          //                                             ),
          //                                           ),
          //                                           Text(
          //                                             getLeadsController
          //                                                 .apiModel!
          //                                                 .userLeads!
          //                                                 .data![index]
          //                                                 .leadType ==
          //                                                 null
          //                                                 ? ''
          //                                                 : getLeadsController
          //                                                 .apiModel!
          //                                                 .userLeads!
          //                                                 .data![index]
          //                                                 .leadType ==
          //                                                 ''
          //                                                 ? ''
          //                                                 : '${getLeadsController.apiModel!.userLeads!.data![index].leadType}',
          //                                             style: TextStyle(
          //                                               color: dark
          //                                                   ? CustomAppTheme()
          //                                                   .colorLightGrey
          //                                                   : CustomAppTheme()
          //                                                   .blackFade,
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Expanded(
          //                                   flex: 2,
          //                                   child: IconButton(
          //                                     onPressed: () async {
          //                                       launchUrl(Uri.parse(
          //                                           'tel://${getLeadsController.apiModel!.userLeads!.data![index].leadContact}'));
          //                                     },
          //                                     icon: const Icon(Icons.call),
          //                                     color: dark
          //                                         ? CustomAppTheme().redBright
          //                                         : CustomAppTheme().redBright,
          //                                   ),
          //                                 ),
          //                                 Expanded(
          //                                   flex: 2,
          //                                   child: IconButton(
          //                                     onPressed: () {
          //                                       launchUrl(Uri.parse(
          //                                           'whatsapp://send?phone=${getLeadsController.apiModel!.userLeads!.data![index].leadContact}'));
          //                                     },
          //                                     icon: const Icon(
          //                                         Icons.whatsapp_outlined),
          //                                     color: dark
          //                                         ? CustomAppTheme().colorLightGrey
          //                                         : CustomAppTheme().redBright,
          //                                   ),
          //                                 ),
          //                                 Expanded(
          //                                   flex: 2,
          //                                   child: IconButton(
          //                                     onPressed: () async {
          //                                       final passingValues =
          //                                       getLeadsController.apiModel!
          //                                           .userLeads!.data![index];
          //                                       BottomSheetClass.onpress(
          //                                           context,
          //                                           passingValues.id,
          //                                           passingValues,
          //                                           dark,
          //                                           noteLeadController
          //                                               .bottomSheetController);
          //                                     },
          //                                     icon:
          //                                     const Icon(Icons.edit_note_sharp),
          //                                     color: dark
          //                                         ? CustomAppTheme().redBright
          //                                         : CustomAppTheme().redBright,
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ));
          //                 },
          //               ),
          //             );
          //           });
          //     }),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: dark
                      ? CustomAppTheme().backgroundDark
                      : CustomAppTheme().colorWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(7.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image(
                                image: AssetImage("assets/images/logo/playstore.png"),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        'Sales Agent Name',
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().redBright,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => const AgentsProfile()));
                                      },
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Status: Meeting',
                                      style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Performance: Excellent',
                                      style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '8',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomAppTheme().colorBlack,
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: CustomAppTheme().redDark,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomAppTheme().colorBlack,
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        Icon(
                                          Icons.handshake_outlined,
                                          color: CustomAppTheme().redDark,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
