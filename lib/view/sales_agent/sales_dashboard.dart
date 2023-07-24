
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/src/presentation/sales_agent/widget/charts/leads_bar_chart.dart';
import 'package:test_project/src/presentation/sales_agent/widget/charts/target_bar_chart.dart';
import '../../src/presentation/sales_agent/controllers/cold_leads.controller.dart';
import '../../src/presentation/sales_agent/controllers/leads.controller.dart';
import '../../src/presentation/sales_agent/controllers/meetings.controller.dart';
import '../../src/presentation/sales_agent/controllers/personal_leads.controller.dart';
import '../../src/presentation/sales_agent/controllers/thirdparty_leads.controller.dart';
import '../../src/presentation/sales_agent/view/followup_leads.dart';
import '../../src/presentation/sales_agent/view/hot_leads.dart';
import '../../src/presentation/sales_agent/view/meeting_leads.dart';
import '../../src/presentation/sales_agent/widget/sales_navbar.dart';
import '../../src/presentation/view/closed_deals.dart';
import '../../src/config/theme/p_theme.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({super.key});

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  late List<ChartData> data;

  @override
  void initState() {
    context.read<LeadController>().getData();
    context.read<ColdLeadsController>().fetchColdLeads();
    context.read<PersonalLeadsController>().fetchPersonalLeads();
    context.read<ThirdPartyLeadsController>().fetchThirdPartyLeads();
    context.read<MeetingsController>().fetchMeetingsData();

    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Provider.of<LeadController>(context, listen: true);

    String percent = (controller.leadModel.targetReached! / 3000000 * 100).toStringAsFixed(2);
    int? reached = controller.leadModel.targetReached?.toInt();

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
        drawer: NavigationDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor:
                  dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
              elevation: 3,
              leading: IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.menu,
                  color: dark
                      ? CustomAppTheme().lightBg
                      : CustomAppTheme().txtFadeBlack,
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: controller.responseOfLeads == null
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Column(
                            children: [
                              Consumer<LeadController>(
                                builder: (context, userImage, _) {
                                  try {
                                    return userImage.leadModel.user![0]
                                                .displayImg ==
                                            null
                                        ? const Image(
                                            image: AssetImage(
                                                "assets/images/logo/playstore.png"),
                                            height: 60,
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl: userImage
                                                  .responseOfLeads!['user'][0]
                                                      ['displayImg']
                                                  .toString(),
                                              height: 60,
                                              width: 60,
                                              errorWidget: (buildContext,
                                                  string, dynamic) {
                                                return const Image(
                                                  image: AssetImage(
                                                      "assets/images/logo/playstore.png"),
                                                  height: 60,
                                                );
                                              },
                                            ),
                                          );
                                  } catch (ex) {
                                    return const Image(
                                      image: AssetImage(
                                          "assets/images/logo/playstore.png"),
                                      height: 60,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Consumer<LeadController>(builder: (context, name, _) {
                            return name.responseOfLeads == null
                                ? Text(
                                    "Loading ....",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: CustomAppTheme().redBright,
                                    ),
                                  )
                                : Text(
                                    name.leadModel.user!.isEmpty
                                        ? ''
                                        : name.leadModel.user![0].userName
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: CustomAppTheme().redBright,
                                    ),
                                  );
                          }),
                          SizedBox(
                            height: 5.0,
                          ),
                          Consumer<LeadController>(builder: (context, position, _) {
                            return position.responseOfLeads == null
                                ? Text(
                              "...",
                              style: TextStyle(
                                color: dark
                                    ? CustomAppTheme().lightBg
                                    : CustomAppTheme().txtFadeBlack,
                                fontSize: 11,
                              ),
                            )
                                : Text(
                              position.leadModel.user!.isEmpty
                                  ? ''
                                  : position.leadModel.user![0].position
                                  .toString(),
                              style: TextStyle(
                                color: dark
                                    ? CustomAppTheme().lightBg
                                    : CustomAppTheme().txtFadeBlack,
                                fontSize: 11,
                              ),
                            );
                          }),
                        ],
                      ),
                background: Image(
                  image: dark ? AssetImage('assets/images/background/sliverBgDark.png') : AssetImage('assets/images/background/sliverBg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              centerTitle: true,
              collapsedHeight: MediaQuery.of(context).size.height * 0.2,
              actions: [
                IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: dark
                        ? CustomAppTheme().lightBg
                        : CustomAppTheme().txtFadeBlack,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return controller.responseOfLeads == null
                  ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                  : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 1.0, 10.0, 5.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              color: dark ? CustomAppTheme().cardGrey : CustomAppTheme().redBright,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(11.0)),
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
                                        color: CustomAppTheme().lightBg,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'AED ${controller.leadModel.targetReached ?? '0'}',
                                      //'AED ${controller.leadModel.count}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: dark ? CustomAppTheme().redBright : CustomAppTheme().colorWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Total Revenue: AED ${controller.leadModel.totalClosed ?? '0'}',
                                      style: TextStyle(
                                        color: CustomAppTheme().lightBg,
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 1.0, 10.0, 1.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width *
                                          0.4,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ClosedDeals())),
                                    child: Card(
                                      color: dark
                                          ? CustomAppTheme()
                                              .cardGrey
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  11.0)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Consumer<LeadController>(
                                                builder: (context,
                                                    closedDeals, _) {
                                              return Text(
                                                closedDeals
                                                        .responseOfLeads?[
                                                            'lead_status']
                                                            ['closed']
                                                        .toString() ??
                                                    "0",
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .lightBg
                                                      : CustomAppTheme()
                                                          .redBright,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              );
                                            }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'CLOSED DEALS',
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width *
                                          0.4,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                HotLeads())),
                                    child: Card(
                                      color: dark
                                          ? CustomAppTheme()
                                              .cardGrey
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  11.0)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.leadModel
                                                      .userLeads?.total
                                                      .toString() ??
                                                  '0',
                                              style: TextStyle(
                                                color: dark
                                                    ? CustomAppTheme()
                                                        .lightBg
                                                    : CustomAppTheme()
                                                        .redBright,
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'LEADS',
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 1.0, 10.0, 1.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MeetingLeads())),
                                  child: SizedBox(
                                    width: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.4,
                                    child: Card(
                                      color: dark
                                          ? CustomAppTheme()
                                              .cardGrey
                                          : CustomAppTheme().colorWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  11.0)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Consumer<MeetingsController>(
                                                builder: (context,
                                                    meeting, _) {
                                              return Text(
                                                meeting.apiModel?.count
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                  color: dark
                                                      ? CustomAppTheme()
                                                          .lightBg
                                                      : CustomAppTheme()
                                                          .redBright,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontSize: 25,
                                                ),
                                              );
                                            }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'MEETINGS',
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              controller.responseOfLeads == null
                                  ? const CircularProgressIndicator
                                      .adaptive()
                                  : Expanded(
                                      flex: 6,
                                      child: InkWell(
                                        onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    FollowUpLeads())),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Card(
                                            color: dark
                                                ? CustomAppTheme()
                                                    .cardGrey
                                                : CustomAppTheme()
                                                    .colorWhite,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        11.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Consumer<
                                                          LeadController>(
                                                      builder: (context,
                                                          followUp, _) {
                                                    return Text(
                                                      followUp.responseOfLeads?[
                                                                  'lead_status']
                                                                  [
                                                                  'followup']
                                                              .toString() ??
                                                          "0",
                                                      style: TextStyle(
                                                        color: dark
                                                            ? CustomAppTheme()
                                                                .lightBg
                                                            : CustomAppTheme()
                                                                .redBright,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        fontSize: 25,
                                                      ),
                                                    );
                                                  }),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'FOLLOW UP',
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
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        controller.responseOfLeads == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 1.0, 10.0, 1.0),
                            child: SizedBox(
                              width:
                                  MediaQuery.of(context).size.width,
                              child: Card(
                                color: dark
                                    ? CustomAppTheme().cardGrey
                                    : CustomAppTheme().redBright,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(11.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'CLOSED DEALS',
                                        style: TextStyle(
                                          color: CustomAppTheme()
                                              .lightBg,
                                        ),
                                      ),
                                      Spacer(),
                                      Consumer<LeadController>(
                                          builder: (context,
                                              closedDeals, _) {
                                        return Text(
                                          closedDeals
                                              .responseOfLeads![
                                                  'lead_status']
                                                  ['closed']
                                              .toString(),
                                          style: TextStyle(
                                            color: CustomAppTheme()
                                                .colorWhite,
                                            fontWeight:
                                                FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Target',
                                  style: TextStyle(
                                    color: dark ? CustomAppTheme().lightBg : CustomAppTheme().blackFade,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              TargetBarChart(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Leads',
                                  style: TextStyle(
                                    color: dark ? CustomAppTheme().lightBg : CustomAppTheme().blackFade,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              LeadsBarChart(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        )
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
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
  CustomAppTheme().redDark,
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
