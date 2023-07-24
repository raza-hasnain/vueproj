import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/leads.controller.dart';
import 'package:test_project/theme/p_theme.dart';
import 'package:test_project/view/O-closed_deals.dart';
import 'package:test_project/view/O-meeting_leads.dart';
import 'package:test_project/view/O-sales_leads.dart';

import '../widget/widgets.dart' as nav;
import 'package:test_project/view/O-followup_leads.dart';

class OSalesDashboard extends StatefulWidget {
  const OSalesDashboard({super.key});

  @override
  State<OSalesDashboard> createState() => _OSalesDashboardState();
}

class _OSalesDashboardState extends State<OSalesDashboard> {
  @override
  void initState() {
    context.read<LeadController>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Provider.of<LeadController>(context, listen: true);
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
                children: const [
                  IconButton(
                    icon: Icon(Icons.notifications_none_outlined),
                    onPressed: null,
                  ),
                  SizedBox(
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
        body: controller.responseOfLeads == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: dark
                              ? CustomAppTheme().backgroundDark
                              : CustomAppTheme().colorWhite,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Revenue This Month',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorLightGrey
                                        : CustomAppTheme().colorGrey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'AED ${controller.leadModel.targetReached!.toString()}',
                                  //'AED ${controller.leadModel.count}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: dark
                                        ? CustomAppTheme().colorWhite
                                        : CustomAppTheme().colorDarkBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                controller.responseOfLeads == null
                                    ? const SizedBox.shrink()
                                    : Text(
                                        'Last Month: ${controller.leadModel.totalClosed}',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    controller.responseOfLeads == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OClosedDeals())),
                                      child: Card(
                                        color: dark
                                            ? CustomAppTheme().colorDarkGrey
                                            : CustomAppTheme().colorDarkBlue,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 20.0, 10.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Consumer<LeadController>(builder:
                                                  (context, closedDeals, _) {
                                                return Text(
                                                  closedDeals.responseOfLeads![
                                                          'lead_status']
                                                          ['closed']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30,
                                                  ),
                                                );
                                              }),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Text(
                                                'CLOSED DEALS',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OSalesLeads())),
                                      child: Card(
                                        color: dark
                                            ? CustomAppTheme().colorDarkGrey
                                            : CustomAppTheme().colorDarkBlue,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 20.0, 10.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              controller.responseOfLeads == null
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      controller.leadModel
                                                          .userLeads!.total
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Text(
                                                'LEADS',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    controller.responseOfLeads == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OMeetingLeads())),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Card(
                                        color: dark
                                            ? CustomAppTheme().colorDarkGrey
                                            : CustomAppTheme().colorDarkBlue,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 20.0, 10.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Consumer<LeadController>(builder:
                                                  (context, meetings, _) {
                                                return Text(
                                                  meetings.responseOfLeads![
                                                          'lead_status']
                                                          ['meeting']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                  ),
                                                );
                                              }),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Text(
                                                'MEETINGS',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                controller.responseOfLeads == null
                                    ? const CircularProgressIndicator.adaptive()
                                    : Expanded(
                                        flex: 6,
                                        child: InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      OFollowUpLeads())),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Card(
                                              color: dark
                                                  ? CustomAppTheme()
                                                      .colorDarkGrey
                                                  : CustomAppTheme()
                                                      .colorDarkBlue,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10.0, 20.0, 10.0, 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Consumer<LeadController>(
                                                        builder: (context,
                                                            followUp, _) {
                                                      return Text(
                                                        followUp
                                                            .responseOfLeads![
                                                                'lead_status']
                                                                ['followup']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: 30,
                                                        ),
                                                      );
                                                    }),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Text(
                                                      'FOLLOW UP',
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: 470,
                              child: Card(
                                color: dark
                                    ? CustomAppTheme().backgroundDark
                                    : CustomAppTheme().colorWhite,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Target',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Consumer<LeadController>(
                                          builder: (context, target, _) {
                                        return PieChart(
                                          dataMap: {
                                            'Reached': target
                                                .leadModel.targetReached!
                                                .toDouble(),
                                            'Remaining': target
                                                .leadModel.targetRemaining!
                                                .toDouble(),
                                          },
                                          animationDuration:
                                              const Duration(milliseconds: 800),
                                          chartLegendSpacing: 32,
                                          chartRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          colorList: colorListTarget,
                                          initialAngleInDegree: 0,
                                          chartType: ChartType.ring,
                                          ringStrokeWidth: 35,
                                          legendOptions: const LegendOptions(
                                            legendPosition:
                                                LegendPosition.bottom,
                                            showLegendsInRow: true,
                                            showLegends: true,
                                            legendShape: BoxShape.rectangle,
                                          ),
                                          chartValuesOptions:
                                              const ChartValuesOptions(
                                            showChartValueBackground: true,
                                            showChartValues: true,
                                            showChartValuesInPercentage: true,
                                            showChartValuesOutside: false,
                                          ),
                                        );
                                      }),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Goal:',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'AED ${controller.leadModel.target!.toString()}',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Sales Reached',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'AED ${controller.leadModel.targetReached!.toString()}',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Sales Required:',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'AED ${controller.leadModel.targetRemaining!.toString()}',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: 470,
                              child: Card(
                                color: dark
                                    ? CustomAppTheme().backgroundDark
                                    : CustomAppTheme().colorWhite,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Leads',
                                        style: TextStyle(
                                          color: dark
                                              ? CustomAppTheme().colorLightGrey
                                              : CustomAppTheme().colorGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Consumer<LeadController>(
                                          builder: (context, leadPieChart, _) {
                                        return PieChart(
                                          dataMap: {
                                            "Closed Deal": leadPieChart
                                                .leadModel.leadStatus!.closed!
                                                .toDouble(),
                                            "New Lead": leadPieChart
                                                .leadModel.leadStatus!.neww!
                                                .toDouble(),
                                            "Meeting": leadPieChart
                                                .leadModel.leadStatus!.meeting!
                                                .toDouble(),
                                            "Follow Up": leadPieChart
                                                .leadModel.leadStatus!.followup!
                                                .toDouble(),
                                            "No Answer": leadPieChart
                                                .leadModel.leadStatus!.noanswer!
                                                .toDouble(),
                                            "Low Budget": leadPieChart
                                                .leadModel.leadStatus!.low!
                                                .toDouble(),
                                            "Not Interested": leadPieChart
                                                .leadModel
                                                .leadStatus!
                                                .notinterested!
                                                .toDouble(),
                                            "unreachable": leadPieChart
                                                .leadModel
                                                .leadStatus!
                                                .unreachable!
                                                .toDouble(),
                                          },
                                          animationDuration:
                                              const Duration(milliseconds: 800),
                                          chartLegendSpacing: 32,
                                          chartRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          colorList: colorListLeads,
                                          initialAngleInDegree: 0,
                                          chartType: ChartType.disc,
                                          // ringStrokeWidth: 45,
                                          legendOptions: const LegendOptions(
                                            legendPosition:
                                                LegendPosition.bottom,
                                            showLegendsInRow: true,
                                            showLegends: true,
                                            legendShape: BoxShape.rectangle,
                                          ),
                                          chartValuesOptions:
                                              const ChartValuesOptions(
                                            showChartValueBackground: true,
                                            showChartValues: true,
                                            showChartValuesInPercentage: true,
                                            showChartValuesOutside: true,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

final dataMapTarget = <String, double>{
  "Reached": 50000000,
  "Remaining": 20000000,
};

final dataMapLeads = <String, double>{
  "Closed Deal": 57,
  "New Lead": 20,
  "Meeting": 72,
  "Follow Up": 309,
  "No Answer": 49,
  "Low Budget": 19,
  "Not Interested": 71,
  "Unreachable": 20,
};

final colorListTarget = <Color>[
  const Color(0xFF133465),
  const Color(0xFF8C8C8C),
];

final colorListLeads = <Color>[
  CustomAppTheme().feedbackClosedDealBlue,
  CustomAppTheme().feedbackNew,
  CustomAppTheme().feedbackMeeting,
  CustomAppTheme().feedbackFollowUp,
  CustomAppTheme().feedbackNoAnswer,
  CustomAppTheme().feedbackLowBudget,
  CustomAppTheme().feedbackNotInterested,
  CustomAppTheme().feedbackUnreachable
];
