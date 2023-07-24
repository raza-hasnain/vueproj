import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/cold_leads.controller.dart';
import 'package:test_project/controller/leads.controller.dart';
import 'package:test_project/controller/meetings.controller.dart';
import 'package:test_project/controller/personal_leads.controller.dart';
import 'package:test_project/controller/thirdparty_leads.controller.dart';
import 'package:test_project/view/sales_agent/closed_deals.dart';
import 'package:test_project/view/sales_agent/cold_leads.dart';
import 'package:test_project/view/sales_agent/followup_leads.dart';
import 'package:test_project/view/sales_agent/personal_leads.dart';

import '../controller/call_log.controller.dart';
import '../controller/logout.controller.dart';
import '../theme/p_theme.dart';
import '../view/call.history.view.dart';
import '../view/sales_agent/hot_leads.dart';
import '../view/sales_agent/meeting_leads.dart';
import '../view/sales_agent/new_leads.dart';
import '../view/sales_agent/sales_dashboard.dart';
import '../view/sales_profile.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: buildProfileHeader(context),
            ),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: buildMenuItems(context),
              ),
            ),
            Expanded(
              flex: 1,
              child: buildProfileFooter(context),
            ),
          ],
        ),
      );

  Widget buildProfileHeader(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          top: 1,
          bottom: 1,
          left: 1,
          right: 1,
        ),
        child: Card(
          color: CustomAppTheme().redDark,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Consumer<LeadController>(
                    builder: (context, userImage, _) {
                      try {
                        return userImage.leadModel.user![0].displayImg == null
                            ? const Image(
                                image: AssetImage(
                                    "assets/images/logo/hikalagency-icon.png"),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: userImage.responseOfLeads!['user']
                                          [0]['displayImg']
                                      .toString(),
                                  errorWidget: (buildContext, string, dynamic) {
                                    return const Image(
                                      image: AssetImage(
                                          "assets/images/logo/hikalagency-icon.png"),
                                    );
                                  },
                                ),
                              );
                      } catch (ex) {
                        return const Image(
                          image: AssetImage(
                              "assets/images/logo/hikalagency-icon.png"),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: const Text(''),
                ),
                Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Consumer<LeadController>(builder: (context, name, _) {
                        return name.responseOfLeads == null
                            ? Text(
                                "Loading ....",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: CustomAppTheme().colorWhite,
                                ),
                              )
                            : Text(
                                name.leadModel.user!.isEmpty
                                    ? ''
                                    : name.leadModel.user![0].userName
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: CustomAppTheme().colorWhite,
                                ),
                              );
                      }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Sales Agent',
                        style: TextStyle(
                          color: CustomAppTheme().lightBg,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: const Text(''),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) {
    final controller = Provider.of<LeadController>(context, listen: true);
    final coldLeadsTotal = context.read<ColdLeadsController>();
    final peronalLeads = context.read<PersonalLeadsController>();
    final thirdPartyLeads = context.read<ThirdPartyLeadsController>();

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        runSpacing: -10.0,
        children: [
          ListTile(
            leading: Icon(
              Icons.dashboard,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("DASHBOARD"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const SalesDashboard()),
                  ((route) => false));
            },
          ),

          ExpansionTile(
            title: Text("LEADS"),
            iconColor: CustomAppTheme().redBright,
            textColor: CustomAppTheme().redBright,
            // collapsedTextColor: CustomAppTheme().redBright,
            leading: Icon(
              Icons.supervised_user_circle_outlined,
              color: CustomAppTheme().redBright,
            ), //add icon
            childrenPadding: EdgeInsets.only(left: 50),
            children: [
              ListTile(
                title: const Text("NEW LEADS"),
                trailing: Consumer<LeadController>(builder: (context, neww, _) {
                  return Text(
                    neww.responseOfLeads == null
                        ? "0"
                        : neww.responseOfLeads!['lead_status']['new']
                            .toString(),
                  );
                }),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NewLeads()));

                  context
                      .read<CallLogController>()
                      .sendCallLogsInStart(context);
                },
              ),
              ListTile(
                title: const Text("HOT LEADS"),
                trailing: Text(controller.responseOfLeads == null
                    ? '0'
                    : controller.responseOfLeads!['user_leads']['total'] == null
                        ? '0'
                        : controller.responseOfLeads!['user_leads']['total']
                            .toString()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HotLeads()),
                      ((route) => false));

                  context
                      .read<CallLogController>()
                      .sendCallLogsInStart(context);
                },
              ),
              ListTile(
                title: const Text("COLD LEADS"),
                trailing:
                    Text("${coldLeadsTotal.apiModel?.coldLeads?.total ?? 0} "),
                // Text(
                //   controller.responseOfLeads == null
                //     ? '0'
                //     : controller.responseOfLeads!['user_leads']['total'] == null
                //         ? '0'
                //         : controller.responseOfLeads!['user_leads']['total']
                //             .toString()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ColdLeads()));

                  context
                      .read<CallLogController>()
                      .sendCallLogsInStart(context);
                },
              ),
              ListTile(
                title: const Text("PERSONAL LEADS"),
                trailing:
                    Text("${peronalLeads.apiModel?.personalLeads?.total ?? 0}"),

                // Text(controller.responseOfLeads == null
                //     ? '0'
                //     : controller.responseOfLeads!['user_leads']['total'] == null
                //         ? '0'
                //         : controller.responseOfLeads!['user_leads']['total']
                //             .toString()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PersonalLeads()));

                  context
                      .read<CallLogController>()
                      .sendCallLogsInStart(context);
                },
              ),
              ListTile(
                title: const Text("THIRD PARTY"),
                trailing: Text(
                    "${thirdPartyLeads.apiModel?.thirdpartyLeads?.total ?? 0}"),
                // Text(controller.responseOfLeads == null
                //     ? '0'
                //     : controller.responseOfLeads!['user_leads']['total'] == null
                //         ? '0'
                //         : controller.responseOfLeads!['user_leads']['total']
                //             .toString()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HotLeads()));

                  context
                      .read<CallLogController>()
                      .sendCallLogsInStart(context);
                },
              ),
              // ListTile(
              //   title: const Text("TRANSFERRED"),
              //   trailing: Text(controller.responseOfLeads == null
              //       ? '0'
              //       : controller.responseOfLeads!['user_leads']['total'] == null
              //       ? '0'
              //       : controller.responseOfLeads!['user_leads']['total']
              //       .toString()),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => const HotLeads()));
              //   },
              // ),
            ],
          ),
          // Divider(
          //   color: CustomAppTheme().redBright,
          //   height: 20,
          // ),
          ListTile(
            leading: Icon(
              Icons.add_ic_call_outlined,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("FOLLOW UP"),
            trailing: Consumer<LeadController>(builder: (context, followUp, _) {
              return Text(
                followUp.responseOfLeads == null
                    ? "0"
                    : followUp.responseOfLeads!['lead_status']['followup']
                        .toString(),
              );
            }),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FollowUpLeads()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("MEETINGS"),
            trailing:
                Consumer<MeetingsController>(builder: (context, meeting, _) {
              return Text(
                meeting.apiModel!.count == null
                    ? "0"
                    : meeting.apiModel!.count.toString(),
              );
            }),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MeetingLeads()));
            },
          ),
          // Divider(
          //   color: CustomAppTheme().redBright,
          //   height: 20,
          // ),
          ListTile(
            leading: Icon(
              Icons.handshake_outlined,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("CLOSED DEALS"),
            trailing: Consumer<LeadController>(builder: (context, closed, _) {
              return Text(
                closed.responseOfLeads == null
                    ? "0"
                    : closed.responseOfLeads!['lead_status']['closed']
                        .toString(),
              );
            }),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ClosedDeals()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.call_end_outlined,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("CALL HISTORY"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CallHistory()));
            },
          ),
          // Divider(
          //   color: CustomAppTheme().redBright,
          //   height: 20,
          // ),
          Consumer<LeadController>(builder: (context, profile, _) {
            return profile.responseOfLeads == null
                ? const SizedBox.shrink()
                : ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      color: CustomAppTheme().redBright,
                    ),
                    title: const Text("PROFILE"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SalesProfile()));
                    },
                  );
          }),

          ListTile(
            leading: Icon(
              Icons.logout,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("LOG OUT"),
            onTap: () {
              context.read<Logout>().logoutFunc(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfileFooter(BuildContext context) => Container(
        color: CustomAppTheme().colorBlack,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: 5 + MediaQuery.of(context).padding.top,
          bottom: 5,
        ),
        child: ListTile(
          title: Image(
            image: AssetImage("assets/images/logo/hikallogo.png"),
            height: 30,
          ),
        ),
      );
}
