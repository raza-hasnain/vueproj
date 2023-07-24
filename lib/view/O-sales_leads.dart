import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/cold_leads.controller.dart';
import 'package:test_project/widget/sales_lead_widgets/cold.tab.dart';
import 'package:test_project/widget/sales_lead_widgets/direct.tab.dart';

import '../controller/get_leads.controller.dart';
import '../theme/p_theme.dart';
import '../widget/widgets.dart' as nav;

final leadsStorage = PageStorageBucket();

class OSalesLeads extends StatefulWidget {
  const OSalesLeads({super.key});

  @override
  State<OSalesLeads> createState() => _OSalesLeadsState();
}

class _OSalesLeadsState extends State<OSalesLeads> {
  @override
  void initState() {
    context.read<GetSalesLeadController>().fetchMyUsers();
    context.read<ColdLeadsController>().fetchColdLeads();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final coldLeadsController =
        Provider.of<ColdLeadsController>(context, listen: true);

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: dark
              ? CustomAppTheme().colorDarkBlue
              : CustomAppTheme().background,
          appBar: getAppbar(dark),
          drawer: const SafeArea(
            child: nav.NavigationDrawer(),
          ),
          body: PageStorage(
            bucket: leadsStorage,
            child: Consumer<GetSalesLeadController>(
                builder: (context, getLeadsController, _) {
              return TabBarView(
                children: [
                  getLeadsController.apiModel?.userLeads?.data == null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ))
                      : const DirectLeads(),
                  coldLeadsController.apiModel?.coldLeads?.data == null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ))
                      : const ColdLeadsWidget(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

//APPBAR
  PreferredSizeWidget getAppbar(bool dark) {
    return AppBar(
      elevation: 0,
      title: Image(
        image: dark
            ? const AssetImage("assets/images/logo/hikallogo.png")
            : const AssetImage("assets/images/logo/fullLogoRE.png"),
        height: 40,
      ),
      backgroundColor:
          dark ? CustomAppTheme().colorDarkBlue : CustomAppTheme().colorWhite,
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
      bottom: TabBar(
        indicatorColor:
            dark ? CustomAppTheme().colorWhite : CustomAppTheme().colorDarkBlue,
        labelColor:
            dark ? CustomAppTheme().colorWhite : CustomAppTheme().colorDarkBlue,
        unselectedLabelColor:
            dark ? CustomAppTheme().colorGrey : CustomAppTheme().colorDarkGrey,
        tabs: [
          Tab(
            child: Text(
              'HOT LEADS',
              style: TextStyle(
                color: dark
                    ? CustomAppTheme().colorWhite
                    : CustomAppTheme().colorDarkBlue,
              ),
            ),
          ),
          Tab(
            child: Text(
              'COLD LEADS',
              style: TextStyle(
                color: dark
                    ? CustomAppTheme().colorWhite
                    : CustomAppTheme().colorDarkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
