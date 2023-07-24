import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/model/closed.deals.model.dart';
import 'package:test_project/model/cold.leads.model.dart';
import 'package:test_project/model/followup.model.dart';
import 'package:test_project/model/lead.notes.model.dart';
import 'package:test_project/model/meetings.model.dart';

import '../components/app.pop_ups.dart';
import '../injectors.dart';
import '../model/get_leads.model.dart';
import '../model/newlead.model.dart';
import '../model/personal.leads.model.dart';
import '../model/thirdparty.leads.model.dart';
import '../utils/const.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<ApiModel?> getUsers({
    String query = "?page=pagenumber",
    String? loginToken
  }) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response = await client.get(Uri.parse(Urls.leads + modifiedQuery),
      headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

  //COLD LEADS
  static Future<ColdLeadsModel?> coldLeads({
    String query = "?page=pagenumber",
    String? loginToken
  }) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response = await client.get(Uri.parse(Urls.coldleads + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiColdLeadsModelFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

  //PERSONAL LEADS
  static Future<PersonalLeadsModel?> personalLeads({
    String query = "&page=pagenumber",
    String? loginToken,
  }) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response = await client.get(Uri.parse(Urls.personalleads + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiPersonalLeadsModelFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

  //THIRD PARTY LEADS
  static Future<ThirdPartyLeadsModel?> thirdpartyLeads({
    String query = "&page=pagenumber",
    String? loginToken
  }) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response = await client.get(Uri.parse(Urls.thirdpartyleads + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiThirdPartyLeadsModelFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

  //New LEADS
  static Future<NewLeadModel?> newLeads({
    String query = "?page=pagenumber",
    String? loginToken}) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response = await client.get(Uri.parse(Urls.newLeads + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiNewLeadsModelFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      log("Error in api call $e");
    }
    return null;
  }

  //Follow up LEADS
  static Future<FollowUpModel?> followUpLeads({
    String query = "?page=pagenumber",
    String? loginToken}) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response =
        await client.get(Uri.parse(Urls.followUp + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiFollowUpModelFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

//MEETING DATA
  static Future<MeetingModel?> meetingData({
    String query = "?page=pagenumber",
    String? loginToken}) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response =
        await client.get(Uri.parse(Urls.meetings + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiMeetingModelFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

  //CLOSED DEAL
  static Future<ClosedDealsModel?> closedLeadsFunc({
    String query = "?page=pagenumber", String? loginToken}) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response =
        await client.get(Uri.parse(Urls.closedDeals + modifiedQuery), headers: {
      'Authorization': 'Bearer $loginToken',
    });

    try {
      if (response.body.isNotEmpty) {
        return apiFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }

  // NOTES LEADS
  static Future<LeadNotesModel?> noteLeads({
    String query = "?page=pagenumber",
    String? loginToken,
    required int id
  }) async {
    String modifiedQuery = query.replaceAll("/", "");
    var response = await client.get(
        Uri.parse("https://api.hikalcrm.com/api/leadNotes/$id" + modifiedQuery),
        headers: {
          'Authorization': 'Bearer $loginToken',
        });

    try {
      if (response.body.isNotEmpty) {
        return apiLeadsNotesFromJson(response.body);
      } else {
        return null;
      }
    } on TimeoutException {
      injector<AppPopUps>().someThingWentWrongDialogue();
    } on Error catch (e) {
      injector<AppPopUps>().errorDialogueBox();

      log(e.toString());
    } on SocketException catch (e) {
      injector<AppPopUps>().noInternetConnectionDialogue();

      log("No internet Connection:$e");
    } catch (e) {
      debugPrint("Error in api call $e");
    }
    return null;
  }
}
