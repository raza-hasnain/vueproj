import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/personal_leads.controller.dart';
import 'package:test_project/utils/assets.dart';
import '../../theme/p_theme.dart';
import '../../widget/sales_lead_widgets/personal.tab.dart';
import '../../widget/widgets.dart' as nav;

final personalLeadsStorage = PageStorageBucket();

class PersonalLeads extends StatefulWidget {
  const PersonalLeads({super.key});

  @override
  State<PersonalLeads> createState() => _PersonalLeadsState();
}

class _PersonalLeadsState extends State<PersonalLeads> {

  @override
  void initState() {

    super.initState();
    context.read<PersonalLeadsController>().fetchPersonalLeads();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final personalLeadsController = Provider.of<PersonalLeadsController>(context, listen: true);


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
        bucket: personalLeadsStorage,
        child: Consumer<PersonalLeadsController>(
          builder: (context, getPersonalLeadsController, _) {
            return personalLeadsController.isLoading == true
              ? Center(
                  child: SizedBox(
                    height: 60,
                    child: Center(child: Lottie.asset(lottieLoading)),
                  ),
                )
              : personalLeadsController.apiModel == null
              ? Center(
                  child: Text("No data found!"),
                )
              : PersonalLeadsWidget();
        }),
      ),
    );
  }
}
