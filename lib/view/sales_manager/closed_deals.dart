import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/closed.leads.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/p_theme.dart';
import '../../widget/widgets.dart' as nav;

final closedDealStorage = PageStorageBucket();

class MClosedDeals extends StatefulWidget {
  const MClosedDeals({super.key});

  @override
  State<MClosedDeals> createState() => _MClosedDealsState();
}

class _MClosedDealsState extends State<MClosedDeals> {
  var lead;
  @override
  void initState() {
    lead = context.read<ClosedDealsController>().fetchClosedDeals();

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
      body: PageStorage(
        bucket: closedDealStorage,
        child: Consumer<ClosedDealsController>(builder: (context, closedDeals, _) {
          return SingleChildScrollView(
            key: PageStorageKey("closedDealKey"),
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
                closedDeals.apiModel?.closedLeads?.data == null
                ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
                : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  key: const PageStorageKey<String>('new_leads_list'),
                  itemCount: closedDeals.apiModel?.closedLeads?.data!.length ?? 0,
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
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: dark ? CustomAppTheme().redDark : CustomAppTheme().redBright,
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
                                            closedDeals.apiModel!.closedLeads?.data![index].leadName ?? '',
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
                                      child: IconButton(
                                        onPressed: () async {
                                          launchUrl(Uri.parse(
                                            'tel://${closedDeals.apiModel!.closedLeads?.data![index].leadContact}'));
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
                                            'whatsapp://send?phone=${closedDeals.apiModel!.closedLeads?.data![index].leadContact}'));
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
                                          // final passingValues =
                                          // leadController.apiModel!
                                          //     .newLeads!.data![index];
                                          //
                                          // BottomSheetClass.onpress(
                                          //     context,
                                          //     passingValues.id,
                                          //     passingValues,
                                          //     dark,
                                          //     noteLeadController
                                          //         .bottomSheetController);
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
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: dark ? CustomAppTheme().redDark : CustomAppTheme().blackFade,
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
