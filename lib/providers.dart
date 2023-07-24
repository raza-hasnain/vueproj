import 'package:provider/provider.dart';
import 'package:test_project/controller/login.controller.dart';
import 'controller/call_log.controller.dart';
import 'controller/change.password.controller.dart';
import 'controller/closed.leads.controller.dart';
import 'controller/cold_leads.controller.dart';
import 'controller/followup.controller.dart';
import 'controller/get_leads.controller.dart';
import 'controller/lead.notes.controller.dart';
import 'controller/leads.controller.dart';
import 'controller/logout.controller.dart';
import 'controller/meetings.controller.dart';
import 'controller/newleads.controller.dart';
import 'controller/personal_leads.controller.dart';
import 'controller/thirdparty_leads.controller.dart';

//INITIALIZE ALL THE PROVIDERS HERE AND GET THEM IN THE MAIN MY DEPENDENCY INJECTION USING GET-IT
class Providers {
  final List<ChangeNotifierProvider> providers = [

    ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider<CallLogController>(
      create: (context) => CallLogController(),
    ),
    ChangeNotifierProvider<LeadController>(
      create: (context) => LeadController(),
    ),
    ChangeNotifierProvider<Logout>(
      create: (context) => Logout(),
    ),
    ChangeNotifierProvider<GetSalesLeadController>(
      create: (context) => GetSalesLeadController(),
    ),
    ChangeNotifierProvider<ColdLeadsController>(
      create: (context) => ColdLeadsController(),
    ),
    ChangeNotifierProvider<PersonalLeadsController>(
      create: (context) => PersonalLeadsController(),
    ),
    ChangeNotifierProvider<ThirdPartyLeadsController>(
      create: (context) => ThirdPartyLeadsController(),
    ),
    ChangeNotifierProvider<NewLeadsController>(
      create: (context) => NewLeadsController(),
    ),
    ChangeNotifierProvider<FolloweUpController>(
      create: (context) => FolloweUpController(),
    ),
    ChangeNotifierProvider<MeetingsController>(
      create: (context) => MeetingsController(),
    ),
    ChangeNotifierProvider<ClosedDealsController>(
      create: (context) => ClosedDealsController(),
    ),
    ChangeNotifierProvider<ChangePasswordController>(
      create: (context) => ChangePasswordController(),
    ),
    ChangeNotifierProvider<LeadsNotesController>(
      create: (context) => LeadsNotesController(),
    ),
  ];
}
