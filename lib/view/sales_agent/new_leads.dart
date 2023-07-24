import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/newleads.controller.dart';
import 'package:test_project/widget/sales_navbar.dart' as nav;

import '../../theme/p_theme.dart';
import '../../widget/new.leads.widget/actual.new.leads.widget.dart';
import '../../widget/new.leads.widget/search.new.leads.widget.dart';

final newLeadsPageStorage = PageStorageBucket();

class NewLeads extends StatefulWidget {
  const NewLeads({super.key});

  @override
  State<NewLeads> createState() => _NewLeadsState();
}

class _NewLeadsState extends State<NewLeads> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<NewLeadsController>().fetchNewLeads();
  }

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final leadController =
        Provider.of<NewLeadsController>(context, listen: true);

    return Scaffold(
      key: _drawerKey,
      backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
      appBar: leadController.isSearching == true
      ? AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            leadController.searchStatus();
            leadController.searchController.clear();
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
        iconTheme: IconThemeData(
          color: dark ? CustomAppTheme().redBright : CustomAppTheme().blackFade,
        ),
        elevation: 0,
        title: TextFormField(
          controller: leadController.searchController,
          onChanged: leadController.searchNewLeads,
          cursorColor: CustomAppTheme().redBright,
          decoration: InputDecoration(
            border: InputBorder.none,
              hintText: "Search leads"
          ),
        ),
      )
      : AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Image(
          image: dark ? const AssetImage("assets/images/logo/hikallogo.png")
              : const AssetImage("assets/images/logo/fullLogoRE.png"),
          height: 30,
        ),
        backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
        iconTheme: IconThemeData(
          color: dark
            ? CustomAppTheme().redBright
            : CustomAppTheme().blackFade,
        ),
        leading: IconButton(
          onPressed: () {
            _drawerKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
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
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: dark
                        ? CustomAppTheme().redBright
                        : CustomAppTheme().blackFade,
                  ),
                  onPressed: () {
                    leadController.searchStatus();
                    leadController.searchController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: leadController.isSearching == true
      ? IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
      : nav.NavigationDrawer(),
      body: PageStorage(
        bucket: newLeadsPageStorage,
        child: leadController.searchController.text.isNotEmpty
            ? SearchNewLeads()
            : ActualNewLeads()),
    );
  }
}
