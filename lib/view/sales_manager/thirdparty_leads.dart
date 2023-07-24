
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/thirdparty_leads.controller.dart';

import '../../controller/get_leads.controller.dart';
import '../../theme/p_theme.dart';
import '../../widget/sales_lead_widgets/thirdparty.tab.dart';
import '../../widget/widgets.dart' as nav;

final leadsStorage = PageStorageBucket();

class MThirdPartyLeads extends StatefulWidget {
  const MThirdPartyLeads({super.key});

  @override
  State<MThirdPartyLeads> createState() => _MThirdPartyLeadsState();
}

class _MThirdPartyLeadsState extends State<MThirdPartyLeads> {
  @override
  void initState() {
    context.read<GetSalesLeadController>().fetchMyUsers();
    context.read<ThirdPartyLeadsController>().fetchThirdPartyLeads();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final thirdpartyLeadsController = Provider.of<ThirdPartyLeadsController>(context, listen: true);

    return Scaffold(
      backgroundColor: dark
          ? CustomAppTheme().darkBg
          : CustomAppTheme().creamLight,
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
          color: dark
              ? CustomAppTheme().redBright
              : CustomAppTheme().blackFade,
        ),
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none_outlined,
                    color: dark ? CustomAppTheme().redBright : CustomAppTheme().blackFade,
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
              return thirdpartyLeadsController.apiModel?.thirdpartyLeads?.data == null
                  ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
                  : const ThirdPartyLeadsWidget();
            }
        ),
      ),
    );
  }
}
