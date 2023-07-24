import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/closed.leads.controller.dart';
import 'package:test_project/controller/leads.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/p_theme.dart';
import '../widget/widgets.dart' as nav;

final closedDealStorage = PageStorageBucket();

class ClosedDeals extends StatefulWidget {
  const ClosedDeals({super.key});

  @override
  State<ClosedDeals> createState() => _ClosedDealsState();
}

class _ClosedDealsState extends State<ClosedDeals> {
  var lead;
  @override
  void initState() {
    lead = context.read<ClosedDealsController>().fetchClosedDeals();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final leadController = Provider.of<LeadController>(context, listen: false);

    return SafeArea(
        child: Scaffold(
            backgroundColor: dark
                ? CustomAppTheme().colorDarkBlue
                : CustomAppTheme().background,
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
              bucket: closedDealStorage,
              child: Consumer<ClosedDealsController>(
                  builder: (context, closedDeals, _) {
                return SingleChildScrollView(
                  key: PageStorageKey("closedDealKey"),
                  child: Column(
                    children: [
                      closedDeals.apiModel?.closedLeads?.data == null
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )) : 
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: closedDeals.apiModel?.closedLeads?.data!.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print("here is our length ${closedDeals.apiModel!.count}");
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
                                                color: (closedDeals
                                                            .apiModel!
                                                            .closedLeads
                                                            ?.data![index]
                                                            .leadStatus ==
                                                        "Closed (Success)"
                                                    ? CustomAppTheme().feedbackNew
                                                    : CustomAppTheme().colorLightGrey),
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
                                                children: [
                                                  Text(
                                                    closedDeals.apiModel!.closedLeads
                                                            ?.data![index].leadName ??
                                                        '',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme().colorWhite
                                                          : CustomAppTheme().colorBlack,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${closedDeals.apiModel!.closedLeads?.data![index].leadStatus}",
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
                                                    'Project: ${closedDeals.apiModel!.closedLeads?.data![index].project}',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme().colorGrey,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Enquiry: ${closedDeals.apiModel!.closedLeads?.data![index].enquiryType}',
                                                    style: TextStyle(
                                                      color: dark
                                                          ? CustomAppTheme()
                                                              .colorLightGrey
                                                          : CustomAppTheme().colorGrey,
                                                    ),
                                                  ),
                                                  if (leadController
                                                          .leadModel.user?[0].role ==
                                                      3)
                                                    if (leadController
                                                            .leadModel
                                                            .userLeads
                                                            ?.data![index]
                                                            .assignedToSales ==
                                                        null)
                                                      const Text('')
                                                    else if (leadController
                                                            .leadModel
                                                            .userLeads
                                                            ?.data![index]
                                                            .assignedToSales ==
                                                        0)
                                                      const Text('')
                                                    else if (leadController
                                                            .leadModel
                                                            .userLeads
                                                            ?.data![index]
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
                                                            'Agent: ${leadController.leadModel.userLeads?.data![index].assignedToSales}',
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
                                                  else
                                                    const SizedBox(
                                                      height: 0.0,
                                                    )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: IconButton(
                                                onPressed: () async {
                                                  launchUrl(Uri.parse(
                                                      'tel://${leadController.leadModel.userLeads!.data![index].leadContact}'));
                                                },
                                                icon: const Icon(Icons.call),
                                                color: dark
                                                    ? CustomAppTheme().colorLightGrey
                                                    : CustomAppTheme().colorDarkBlue,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: IconButton(
                                                onPressed: () {
                                                  launchUrl(Uri.parse(
                                                      'sms://${leadController.leadModel.userLeads!.data![index].leadContact}'));
                                                },
                                                icon:
                                                    const Icon(Icons.message_outlined),
                                                color: dark
                                                    ? CustomAppTheme().colorLightGrey
                                                    : CustomAppTheme().colorDarkBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        color: CustomAppTheme().feedbackClosedDealGreen,
                                        child: Text(
                                          'AED ${closedDeals.apiModel!.closedLeads!.data![index].amount} | ${DateFormat('yyyy-MM-dd').format(closedDeals.apiModel!.closedLeads!.data![index].dealDate!)}',
                                          style: TextStyle(
                                            color: CustomAppTheme().colorWhite,
                                            fontWeight: FontWeight.bold,
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
                );
              }),
            )));
  }
}
