// import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/followup.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/onpress_bottomsheet.dart';
import '../../controller/lead.notes.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final followUpStorage = PageStorageBucket();

class MFollowUpLeads extends StatefulWidget {
  const MFollowUpLeads({super.key});

  @override
  State<MFollowUpLeads> createState() => _MFollowUpLeadsState();
}

class _MFollowUpLeadsState extends State<MFollowUpLeads> {
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
        bucket: followUpStorage,
        child:
        // EasyRefresh(
        //   simultaneously: true,
        //   controller: controller.controller,
        //   onLoad: controller.onLoading,
        //   header: const ClassicHeader(
        //       processedDuration: Duration(milliseconds: 100)),
        //   footer: const ClassicFooter(noMoreText: "No more Users"),
        //   child:
          SingleChildScrollView(
            key: PageStorageKey<String>("followupkey"),
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: 120,
                          child: Card(
                              color: CustomAppTheme().redDark,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage("assets/images/logo/playstore.png"),
                                      width: 60,
                                    ),
                                    SizedBox(height: 5.0),
                                    Flexible(
                                      child: Text(
                                        'Sales Agent Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CustomAppTheme().lightBg,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: SizedBox(
                          width: 120,
                          child: Card(
                              color: CustomAppTheme().redDark,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage("assets/images/logo/playstore.png"),
                                      width: 60,
                                    ),
                                    SizedBox(height: 5.0),
                                    Flexible(
                                      child: Text(
                                        'Sales Agent Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CustomAppTheme().lightBg,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: SizedBox(
                          width: 120,
                          child: Card(
                              color: CustomAppTheme().redDark,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage("assets/images/logo/playstore.png"),
                                      width: 60,
                                    ),
                                    SizedBox(height: 5.0),
                                    Flexible(
                                      child: Text(
                                        'Sales Agent Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CustomAppTheme().lightBg,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: SizedBox(
                          width: 120,
                          child: Card(
                              color: CustomAppTheme().redDark,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage("assets/images/logo/playstore.png"),
                                      width: 60,
                                    ),
                                    SizedBox(height: 5.0),
                                    Flexible(
                                      child: Text(
                                        'Sales Agent Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CustomAppTheme().lightBg,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                controller.apiModel?.followUpLeads?.data == null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ))
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
                                            color: (controller
                                                        .apiModel!
                                                        .followUpLeads
                                                        ?.data![index]
                                                        .coldcall ==
                                                    1
                                                ? CustomAppTheme()
                                                    .colorLightGrey
                                                : CustomAppTheme().redDark),
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
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                controller
                                                            .apiModel!
                                                            .followUpLeads
                                                            ?.data![index]
                                                            .coldcall ==
                                                        1
                                                    ? 'Cold | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                                    : controller
                                                                .apiModel!
                                                                .followUpLeads
                                                                ?.data![index]
                                                                .coldcall ==
                                                            2
                                                        ? 'Personal | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                                        : controller
                                                                    .apiModel!
                                                                    .followUpLeads
                                                                    ?.data![
                                                                        index]
                                                                    .coldcall ==
                                                                3
                                                            ? '3rd Party | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                                            : 'Hot | ${controller.apiModel!.followUpLeads!.data![index].feedback}',
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .redBright
                                                      : CustomAppTheme()
                                                          .redDark,
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
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            onPressed: () async {
                                              launchUrl(Uri.parse(
                                                  'tel://${controller.apiModel!.followUpLeads?.data![index].leadContact}'));
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
                                                  'whatsapp://send?phone=${controller.apiModel!.followUpLeads?.data![index].leadContact}'));
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
                                            onPressed: () {
                                              final passingValues = controller
                                                  .apiModel!
                                                  .followUpLeads!
                                                  .data![index];

                                              BottomSheetClass.onpress(
                                                  context,
                                                  passingValues.id,
                                                  passingValues,
                                                  dark,
                                                  noteLeadController
                                                      .bottomSheetController);
                                            },
                                            icon: const Icon(
                                                Icons.edit_note_sharp),
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
              ],
            ),
          ),
        // ),
      ),
    );
  }
}
