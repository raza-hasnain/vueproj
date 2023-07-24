import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/closed.leads.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/onpress_bottomsheet.dart';
import '../../controller/lead.notes.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final closedDealStorage = PageStorageBucket();

class ClosedDeals extends StatefulWidget {
  const ClosedDeals({super.key});

  @override
  State<ClosedDeals> createState() => _ClosedDealsState();
}

class _ClosedDealsState extends State<ClosedDeals> {
  @override
  void initState() {
    context.read<ClosedDealsController>().fetchClosedDeals();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final noteLeadController = Provider.of<LeadsNotesController>(context, listen: false);
    // final lead = Provider.of<ClosedDealsController>(context, listen: true);

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
        bucket: closedDealStorage,
        child: Consumer<ClosedDealsController>(builder: (context, closedDeals, _) {
          return SingleChildScrollView(
            key: PageStorageKey("closedDealKey"),
            child: Column(
              children: [
                closedDeals.apiModel?.closedLeads?.data == null
                ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
                : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  key: const PageStorageKey<String>('closed_deal_list'),
                  itemCount: closedDeals.apiModel?.closedLeads?.data!.length ?? 0,
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
                                      color: CustomAppTheme().redBright,
                                      width: 5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 15,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            closedDeals.apiModel!.closedLeads?.data![index].leadName ?? '',
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
                                          Row(
                                            children: [
                                              Text(
                                                closedDeals.apiModel!.closedLeads?.data![index].project == null
                                                    ? 'Project: '
                                                    : closedDeals.apiModel!.closedLeads?.data![index].project == ""
                                                    ? 'Project: '
                                                    : '${closedDeals.apiModel!.closedLeads?.data![index].project} ',
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                      .colorLightGrey
                                                      : CustomAppTheme()
                                                      .blackFade,
                                                ),
                                              ),
                                              Text(
                                                closedDeals.apiModel!.closedLeads?.data![index].leadFor == null
                                                    ? ''
                                                    : closedDeals.apiModel!.closedLeads?.data![index].leadFor == ""
                                                    ? ''
                                                    : '(${closedDeals.apiModel!.closedLeads?.data![index].leadFor})',
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
                                                closedDeals.apiModel!.closedLeads?.data![index].enquiryType == null
                                                    ? 'Enquiry: '
                                                    : closedDeals.apiModel!.closedLeads?.data![index].enquiryType == ""
                                                    ? 'Enquiry: '
                                                    : '${closedDeals.apiModel!.closedLeads?.data![index].enquiryType} ',
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                      .colorLightGrey
                                                      : CustomAppTheme()
                                                      .blackFade,
                                                ),
                                              ),
                                              Text(
                                                closedDeals.apiModel!.closedLeads?.data![index].leadType == null
                                                    ? ''
                                                    : closedDeals.apiModel!.closedLeads?.data![index].leadType == ''
                                                    ? ''
                                                    : '${closedDeals.apiModel!.closedLeads?.data![index].leadType}',
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
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            launchUrl(Uri.parse(
                                                'whatsapp://send?phone=${closedDeals.apiModel!.closedLeads?.data![index].leadContact}'));
                                          },
                                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                                          // icon: const Icon(
                                          //     Icons.mark_chat_unread_outlined),
                                          color: dark ? CustomAppTheme().colorWhite : CustomAppTheme().redBright,
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () async {
                                            launchUrl(Uri.parse(
                                                'tel://${closedDeals.apiModel!.closedLeads?.data![index].leadContact}'));
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
                                            final passingValues = closedDeals.apiModel!.closedLeads!.data![index];
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
                                  color: dark ? CustomAppTheme().backgroundDark : CustomAppTheme().colorBlack,
                                  child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'AED ${closedDeals.apiModel!.closedLeads!.data![index].amount} | ${DateFormat('yyyy-MM-dd').format(closedDeals.apiModel!.closedLeads!.data![index].dealDate!)}',
                                              style: TextStyle(
                                                color: CustomAppTheme().colorWhite,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ]
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ));
  }
}
