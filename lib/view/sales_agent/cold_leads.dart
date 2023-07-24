import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/cold_leads.controller.dart';

import '../../controller/get_leads.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/sales_lead_widgets/cold.tab.dart';
import '../../widget/widgets.dart' as nav;

final leadsStorage = PageStorageBucket();

class ColdLeads extends StatefulWidget {
  const ColdLeads({super.key});

  @override
  State<ColdLeads> createState() => _ColdLeadsState();
}

class _ColdLeadsState extends State<ColdLeads> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    context.read<GetSalesLeadController>().fetchMyUsers();
    context.read<ColdLeadsController>().fetchColdLeads();
   
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final coldLeadsController = Provider.of<ColdLeadsController>(context, listen: true);

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
        bucket: leadsStorage,
        child: Consumer<GetSalesLeadController>(
          builder: (context, getLeadsController, _) {
            return coldLeadsController.apiModel?.coldLeads?.data == null
            ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
            : ColdLeadsWidget();
        }),
      ),
    );
  }
}
