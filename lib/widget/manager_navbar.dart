import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/cold_leads.controller.dart';
import 'package:test_project/controller/leads.controller.dart';
import 'package:test_project/controller/personal_leads.controller.dart';
import 'package:test_project/controller/thirdparty_leads.controller.dart';
import 'package:test_project/view/sales_manager/agents_list.dart';
import 'package:test_project/view/sales_manager/closed_deals.dart';
import 'package:test_project/view/sales_manager/cold_leads.dart';
import 'package:test_project/view/sales_manager/followup_leads.dart';
import 'package:test_project/view/sales_manager/personal_leads.dart';
import 'package:test_project/view/sales_manager/thirdparty_leads.dart';
import 'package:test_project/view/sales_profile.dart';

import '../controller/logout.controller.dart';
import '../theme/p_theme.dart';
import '../view/call.history.view.dart';
import 'package:test_project/view/sales_manager/hot_leads.dart';
import 'package:test_project/view/sales_manager/meeting_leads.dart';
import 'package:test_project/view/sales_manager/new_leads.dart';
import '../view/sales_manager/manager_dashboard.dart';
// import '../view/manager_profile.dart';

class MNavigationDrawer extends StatelessWidget {
  const MNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;

    return Drawer(
      backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme()
          .background,
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
  }

  Widget buildProfileHeader(BuildContext context) {
    final dark = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
    return Container(
      color: CustomAppTheme().redDark,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Consumer<LeadController>(
              builder: (context, userImage, _) {
                try {
                  return userImage.leadModel.user![0].displayImg == null
                      ? const Image(
                    image: AssetImage("assets/images/logo/playstore.png"),
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
                              "assets/images/logo/playstore.png"),
                        );
                      },
                    ),
                  );
                } catch (ex) {
                  return const Image(
                    image: AssetImage("assets/images/logo/playstore.png"),
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
                  'Sales Manager',
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
    );
  }

  Widget buildMenuItems(BuildContext context) {
    final controller = Provider.of<LeadController>(context, listen: true);
    final coldLeadsTotal = context.read<ColdLeadsController>();
    final personalLeads = context.read<PersonalLeadsController>();
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
                      builder: (context) => const ManagerDashboard()),
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
            ),
            //add icon
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
                      builder: (context) => const MNewLeads()));
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
                      MaterialPageRoute(
                          builder: (context) => const MHotLeads()),
                      ((route) => false));
                },
              ),
              ListTile(
                title: const Text("COLD LEADS"),
                trailing: Text(
                  "${coldLeadsTotal.apiModel?.coldLeads?.total ?? 0} ",
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MColdLeads()));
                },
              ),
              ListTile(
                title: const Text("PERSONAL LEADS"),
                trailing: Text(
                  "${personalLeads.apiModel?.personalLeads?.total ?? 0}",
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MPersonalLeads()));
                },
              ),
              ListTile(
                title: const Text("THIRD PARTY"),
                trailing: Text(
                    "${thirdPartyLeads.apiModel?.thirdpartyLeads?.total ?? 0}"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MThirdPartyLeads()));
                },
              ),
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
                  builder: (context) => const MFollowUpLeads()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("MEETINGS"),
            trailing: Consumer<LeadController>(builder: (context, meeting, _) {
              return Text(
                meeting.responseOfLeads == null
                    ? "0"
                    : meeting.responseOfLeads!['lead_status']['meeting']
                    .toString(),
              );
            }),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MMeetingLeads()));
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
                  MaterialPageRoute(
                      builder: (context) => const MClosedDeals()));
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
          ListTile(
            leading: Icon(
              Icons.real_estate_agent_outlined,
              color: CustomAppTheme().redBright,
            ),
            title: const Text("AGENTS"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AgentsList()));
            },
          ),
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

  Widget buildProfileFooter(BuildContext context) {
    final dark = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
    return Container(
      color: dark ? CustomAppTheme().colorBlack : CustomAppTheme().background,
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5 + MediaQuery
            .of(context)
            .padding
            .bottom,
      ),
      child: ListTile(
        title: Image(
          image: dark
              ? AssetImage("assets/images/logo/hikallogo.png")
              : AssetImage("assets/images/logo/fullLogoRE.png"),
          height: 30,
        ),
      ),
    );
  }
}
