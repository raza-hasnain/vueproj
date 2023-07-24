import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/followup.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/onpress_bottomsheet.dart';
import '../../controller/lead.notes.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final followUpStorage = PageStorageBucket();

class FollowUpLeads extends StatefulWidget {
  const FollowUpLeads({super.key});

  @override
  State<FollowUpLeads> createState() => _FollowUpLeadsState();
}

class _FollowUpLeadsState extends State<FollowUpLeads> {
  var lead;
  @override
  void initState() {
    context.read<FolloweUpController>().fetchFollowUpLeads();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Provider.of<FolloweUpController>(context, listen: true);
    final noteLeadController = Provider.of<LeadsNotesController>(context, listen: false);

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
      drawer: nav.NavigationDrawer(),
      body: PageStorage(
        bucket: followUpStorage,
        child: EasyRefresh(
          simultaneously: true,
          controller: controller.controller,
          onLoad: controller.onLoading,
          header: const ClassicHeader(
              processedDuration: Duration(milliseconds: 100)),
          footer: const ClassicFooter(noMoreText: "No more leads"),
          child: SingleChildScrollView(
            key: PageStorageKey<String>("followupkey"),
            physics: ScrollPhysics(),
            child: Column(
              children: [
                controller.apiModel?.followUpLeads?.data == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.apiModel?.followUpLeads?.data?.length ??
                            0,
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
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: (controller.apiModel!.followUpLeads?.data![index].coldcall == 0
                                            ? CustomAppTheme().feedbackFollowUp : CustomAppTheme().colorLightGrey
                                      ),
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
                                            '${controller.apiModel!.followUpLeads?.data![index].leadName}',
                                            style: TextStyle(
                                              color: dark
                                                  ? CustomAppTheme()
                                                      .colorWhite
                                                  : CustomAppTheme()
                                                      .colorBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            controller.apiModel!.followUpLeads?.data![index].coldcall == 1
                                            ? 'Cold | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                            : controller.apiModel!.followUpLeads?.data![index].coldcall == 2
                                            ? 'Personal | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                            : controller.apiModel!.followUpLeads?.data![index].coldcall == 3
                                            ? '3rd Party | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                            : 'Hot | ${controller.apiModel!.followUpLeads!.data![index].feedback}',
                                            style: TextStyle(
                                              color: CustomAppTheme().redBright,
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
                                                controller
                                                            .apiModel!
                                                            .followUpLeads
                                                            ?.data![index]
                                                            .project ==
                                                        null
                                                    ? 'Project: '
                                                    : controller
                                                                .apiModel!
                                                                .followUpLeads
                                                                ?.data![
                                                                    index]
                                                                .project ==
                                                            ""
                                                        ? 'Project: '
                                                        : '${controller.apiModel!.followUpLeads?.data![index].project} ',
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorLightGrey
                                                      : CustomAppTheme()
                                                          .blackFade,
                                                ),
                                              ),
                                              Text(
                                                controller
                                                            .apiModel!
                                                            .followUpLeads
                                                            ?.data![index]
                                                            .leadFor ==
                                                        null
                                                    ? ''
                                                    : controller
                                                                .apiModel!
                                                                .followUpLeads
                                                                ?.data![
                                                                    index]
                                                                .leadFor ==
                                                            ""
                                                        ? ''
                                                        : '(${controller.apiModel!.followUpLeads?.data![index].leadFor})',
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
                                                controller
                                                            .apiModel!
                                                            .followUpLeads
                                                            ?.data![index]
                                                            .enquiryType ==
                                                        null
                                                    ? 'Enquiry: '
                                                    : controller
                                                                .apiModel!
                                                                .followUpLeads
                                                                ?.data![
                                                                    index]
                                                                .enquiryType ==
                                                            ""
                                                        ? 'Enquiry: '
                                                        : '${controller.apiModel!.followUpLeads?.data![index].enquiryType} ',
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorLightGrey
                                                      : CustomAppTheme()
                                                          .blackFade,
                                                ),
                                              ),
                                              Text(
                                                controller
                                                            .apiModel!
                                                            .followUpLeads
                                                            ?.data![index]
                                                            .leadType ==
                                                        null
                                                    ? ''
                                                    : controller
                                                                .apiModel!
                                                                .followUpLeads
                                                                ?.data![
                                                                    index]
                                                                .leadType ==
                                                            ''
                                                        ? ''
                                                        : '${controller.apiModel!.followUpLeads?.data![index].leadType}',
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

                                    controller.apiModel!.followUpLeads?.data![index].isWhatsapp == 1
                                        ? Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            launchUrl(Uri.parse(
                                                'whatsapp://send?phone=${controller.apiModel!.followUpLeads?.data![index].leadContact}'));
                                          },
                                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                                          // icon: const Icon(
                                          //     Icons.mark_chat_unread_outlined),
                                          color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().redBright,
                                        ),
                                      ),
                                    )
                                        : SizedBox(
                                      width: 0.0,
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () async {
                                            launchUrl(Uri.parse(
                                                'tel://${controller.apiModel!.followUpLeads?.data![index]}'));
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
                                            final passingValues = controller.apiModel!.followUpLeads!.data![index];
                                            BottomSheetClass.onpress(
                                                context,
                                                passingValues.id,
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
