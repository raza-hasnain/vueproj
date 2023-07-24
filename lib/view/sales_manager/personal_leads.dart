import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/personal_leads.controller.dart';

import '../../controller/get_leads.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/sales_lead_widgets/personal.tab.dart';
import '../../widget/widgets.dart' as nav;

final leadsStorage = PageStorageBucket();

class MPersonalLeads extends StatefulWidget {
  const MPersonalLeads({super.key});

  @override
  State<MPersonalLeads> createState() => _MPersonalLeadsState();
}

class _MPersonalLeadsState extends State<MPersonalLeads> {
  @override
  void initState() {
    super.initState();
    context.read<GetSalesLeadController>().fetchMyUsers();
    context.read<PersonalLeadsController>().fetchPersonalLeads();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final personalLeadsController =
        Provider.of<PersonalLeadsController>(context, listen: true);

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
        bucket: leadsStorage,
        child: Consumer<GetSalesLeadController>(
            builder: (context, getPersonalLeadsController, _) {
          return personalLeadsController.apiModel?.personalLeads?.data == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : PersonalLeadsWidget();
        }),
      ),
    );
  }
}
