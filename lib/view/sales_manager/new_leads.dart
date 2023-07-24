import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/lead.notes.controller.dart';
import 'package:test_project/controller/newleads.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/onpress_bottomsheet.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final newLeadsPageStorage = PageStorageBucket();

class MNewLeads extends StatefulWidget {
  const MNewLeads({super.key});

  @override
  State<MNewLeads> createState() => _MNewLeadsState();
}

class _MNewLeadsState extends State<MNewLeads> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<NewLeadsController>().fetchNewLeads();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final leadController =
        Provider.of<NewLeadsController>(context, listen: true);
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
        bucket: newLeadsPageStorage,
        child: EasyRefresh(
          simultaneously: true,
          controller: leadController.controller,
          onLoad: leadController.onLoading,
          header: const ClassicHeader(
              processedDuration: Duration(milliseconds: 100)),
          footer: const ClassicFooter(noMoreText: "No more Users"),
          child: SingleChildScrollView(
            child: Column(
              children: [
                leadController.apiModel?.newLeads?.data == null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        key: const PageStorageKey<String>('new_leads_list'),
                        itemCount:
                            leadController.apiModel?.newLeads?.data?.length ??
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
                                            color: (leadController.apiModel!.newLeads?.data![index].coldcall == 1
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                leadController
                                                    .apiModel!
                                                    .newLeads!
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
                                                leadController
                                                            .apiModel!
                                                            .newLeads
                                                            ?.data![index]
                                                            .coldcall ==
                                                        1
                                                    ? 'Cold | ${leadController.apiModel!.newLeads!.data![index].feedback}'
                                                    : leadController
                                                                .apiModel!
                                                                .newLeads
                                                                ?.data![index]
                                                                .coldcall ==
                                                            2
                                                        ? 'Personal | ${leadController.apiModel!.newLeads!.data![index].feedback}'
                                                        : leadController
                                                                    .apiModel!
                                                                    .newLeads
                                                                    ?.data![
                                                                        index]
                                                                    .coldcall ==
                                                                3
                                                            ? '3rd Party | ${leadController.apiModel!.newLeads!.data![index].feedback}'
                                                            : 'Hot | ${leadController.apiModel!.newLeads!.data![index].feedback}',
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
                                                    leadController
                                                                .apiModel!
                                                                .newLeads!
                                                                .data![index]
                                                                .project ==
                                                            null
                                                        ? 'Project: '
                                                        : leadController
                                                                    .apiModel!
                                                                    .newLeads!
                                                                    .data![
                                                                        index]
                                                                    .project ==
                                                                ""
                                                            ? 'Project: '
                                                            : '${leadController.apiModel!.newLeads!.data![index].project} ',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                    ),
                                                  ),
                                                  Text(
                                                    leadController
                                                                .apiModel!
                                                                .newLeads!
                                                                .data![index]
                                                                .leadFor ==
                                                            null
                                                        ? ''
                                                        : leadController
                                                                    .apiModel!
                                                                    .newLeads!
                                                                    .data![
                                                                        index]
                                                                    .leadFor ==
                                                                ""
                                                            ? ''
                                                            : '(${leadController.apiModel!.newLeads!.data![index].leadFor})',
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
                                                    leadController
                                                                .apiModel!
                                                                .newLeads!
                                                                .data![index]
                                                                .enquiryType ==
                                                            null
                                                        ? 'Enquiry: '
                                                        : leadController
                                                                    .apiModel!
                                                                    .newLeads!
                                                                    .data![
                                                                        index]
                                                                    .enquiryType ==
                                                                ""
                                                            ? 'Enquiry: '
                                                            : '${leadController.apiModel!.newLeads!.data![index].enquiryType} ',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme()
                                                              .blackFade,
                                                    ),
                                                  ),
                                                  Text(
                                                    leadController
                                                                .apiModel!
                                                                .newLeads!
                                                                .data![index]
                                                                .leadType ==
                                                            null
                                                        ? ''
                                                        : leadController
                                                                    .apiModel!
                                                                    .newLeads!
                                                                    .data![
                                                                        index]
                                                                    .leadType ==
                                                                ''
                                                            ? ''
                                                            : '${leadController.apiModel!.newLeads!.data![index].leadType}',
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
                                                  'tel://${leadController.apiModel!.newLeads!.data![index].leadContact}'));
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
                                                  'whatsapp://send?phone=${leadController.apiModel!.newLeads!.data![index].leadContact}'));
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
                                                  leadController.apiModel!
                                                      .newLeads!.data![index];

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
        ),
      ),
    );
  }
}
