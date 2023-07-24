import 'package:flutter/material.dart';
import 'package:test_project/view/sales_agent/sales_dashboard.dart';
import 'package:test_project/view/sales_login.dart';
import '../view/O-sales_dashboard.dart';
import '../view/splash.view.dart';

const String splash = 'splash';
const String dashboard = "dashboard";
const String salesManagerDashboard = "salesManagerDashBoard";
const String login = 'login';

Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(builder: (context) => Splash());
    case dashboard:
      return MaterialPageRoute(builder: (context) => SalesDashboard());

      case salesManagerDashboard:
      return MaterialPageRoute(builder: (context)=> OSalesDashboard());
    case login:
      return MaterialPageRoute(builder: (context) => SalesLogin());

    default:
      throw ('This route does not exist');
  }
}
