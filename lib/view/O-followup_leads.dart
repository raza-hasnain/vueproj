
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/followup.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/p_theme.dart';
import '../widget/widgets.dart' as nav;


final followUpStorage = PageStorageBucket();

class OFollowUpLeads extends StatefulWidget {
  const OFollowUpLeads({super.key});

  @override
  State<OFollowUpLeads> createState() => _OFollowUpLeadsState();
}

class _OFollowUpLeadsState extends State<OFollowUpLeads> {
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
          bucket: followUpStorage,
          child: EasyRefresh(
            simultaneously: true,
            controller: controller.controller,
            onLoad: controller.onLoading,
            header: const ClassicHeader(
                processedDuration: Duration(milliseconds: 100)),
            footer: const ClassicFooter(noMoreText: "No more Users"),
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
                                                  : CustomAppTheme()
                                                      .feedbackFollowUp),
                                              width: 5),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 9,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                          .apiModel!
                                                          .followUpLeads!
                                                          .data![index]
                                                          .leadName ??
                                                      '',
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
                                                      ? 'COLD | ${controller.apiModel!.followUpLeads!.data![index].feedback}'
                                                      : '${controller.apiModel!.followUpLeads!.data![index].feedback}',
                                                  style: TextStyle(
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .colorDarkBlue,
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Project: ${controller.apiModel!.followUpLeads!.data![index].project ?? ""} ${controller.apiModel!.followUpLeads!.data![index].leadFor == "Investment" ? (controller.apiModel!.followUpLeads!.data![index].leadFor) : ""}',
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
                                                  'Enquiry: ${controller.apiModel!.followUpLeads!.data![index].enquiryType ?? ""} ${controller.apiModel!.followUpLeads!.data![index].leadType ?? ""}',
                                                  style: TextStyle(
                                                    color: dark
                                                        ? CustomAppTheme()
                                                            .colorLightGrey
                                                        : CustomAppTheme()
                                                            .colorGrey,
                                                  ),
                                                ),
                                                if (controller
                                                        .apiModel!
                                                        .followUpLeads!
                                                        .data![index]
                                                        .assignedToSales ==
                                                    null)
                                                  const Text('')
                                                else if (controller
                                                        .apiModel!
                                                        .followUpLeads!
                                                        .data![index]
                                                        .assignedToSales ==
                                                    0)
                                                  const Text('')
                                                else if (controller
                                                        .apiModel!
                                                        .followUpLeads!
                                                        .data![index]
                                                        .assignedToSales
                                                        .toString() ==
                                                    "")
                                                  const Text('')
                                                else
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        'Agent: ${controller.apiModel!.followUpLeads!.data![index].assignedToSales}',
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
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    launchUrl(Uri.parse(
                                                        'tel://${controller.apiModel!.followUpLeads!.data![index].leadContact}'));
                                                  },
                                                  icon: const Icon(Icons.call),
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorLightGrey
                                                      : CustomAppTheme()
                                                          .colorDarkBlue,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(
                                                        'sms://${controller.apiModel!.followUpLeads!.data![index].leadContact}'));
                                                  },
                                                  icon: const Icon(
                                                      Icons.message_outlined),
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .colorLightGrey
                                                      : CustomAppTheme()
                                                          .colorDarkBlue,
                                                ),
                                              ],
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
      ),
    );
  }
}
