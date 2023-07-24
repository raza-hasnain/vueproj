import 'dart:convert';

import 'package:flutter/material.dart';

PersonalLeadsModel apiPersonalLeadsModelFromJson(String str) =>
    PersonalLeadsModel.fromJson(json.decode(str));

String apiPersonalLeadsModelToJson(PersonalLeadsModel data) =>
    json.encode(data.toJson());

class PersonalLeadsModel {
  PersonalLeadsModel({
    required this.count,
    required this.message,
    required this.userId,
    this.personalLeads,
    this.totalClosed,
  });

  dynamic count;
  late String message;
  int userId;
  PersonalLeads? personalLeads;
  String? totalClosed;

  factory PersonalLeadsModel.fromJson(Map<String, dynamic> json) =>
      PersonalLeadsModel(
        count: json["count"] ?? '0',
        message: json["message"] ?? "error",
        userId: json['user_id'],
        personalLeads: PersonalLeads.fromJson(json["personalLeads"]),
        totalClosed: json["total_closed"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "message": message,
        "personalLeads": personalLeads?.toJson(),
      };
}

class PersonalLeads {
  PersonalLeads({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  factory PersonalLeads.fromJson(Map<String, dynamic> json) {
    debugPrint(json["data"].runtimeType.toString());
    bool isFirstPage = json["data"].runtimeType == List<dynamic>;
    List<Datum> data = [];
    if (isFirstPage == false) {
      debugPrint("isFirstPage");
      data = Map.from(json["data"])
          .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v)))
          .values
          .toList();
    } else {
      data = List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
    }
    return PersonalLeads(
      currentPage: json["current_page"],
      data: data,
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        // "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.creationDate,
    required this.id,
    this.lid,
    this.leadName,
    this.leadContact,
    this.leadEmail,
    this.enquiryType,
    this.leadType,
    this.project,
    this.leadFor,
    this.language,
    this.leadStatus,
    this.leadSource,
    this.otp,
    this.isWhatsapp,
    this.coldcall,
    this.city,
    this.feedback,
    this.priority,
    this.assignedToManager,
    this.assignedToSales,
    this.addedBy,
    required this.givenBy,
    this.lastEditedBy,
    required this.notes,
    this.lastEdited,
  });

  late DateTime creationDate;
  late int id;
  int? lid;
  String? leadName;
  String? leadContact;
  String? leadEmail;
  String? enquiryType;
  String? leadType;
  String? project;
  String? leadFor;
  String? language;
  String? leadStatus;
  String? leadSource;
  String? otp;
  int? isWhatsapp;
  int? coldcall;
  String? city;
  String? feedback;
  String? priority;
  int? assignedToManager;
  int? assignedToSales;
  int? addedBy;
  dynamic givenBy;
  dynamic lastEditedBy;
  dynamic notes;
  DateTime? lastEdited;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      creationDate: DateTime.parse(json["creationDate"]),
      id: json["id"],
      lid: json["lid"],
      leadName: json["leadName"],
      leadContact: json["leadContact"],
      leadEmail: json["leadEmail"],
      enquiryType: json["enquiryType"],
      leadType: json["leadType"],
      project: json["project"],
      leadFor: json["leadFor"],
      language: json["language"],
      leadStatus: json["leadSource"],
      leadSource: json["leadSource"],
      otp: json["otp"],
      isWhatsapp: json["is_whatsapp"],
      coldcall: json["coldcall"],
      city: json["city"],
      feedback: json["feedback"],
      priority: json["priority"],
      assignedToManager: json["assignedToManager"],
      assignedToSales: json["assignedToSales"],
      addedBy: json["addedBy"],
      givenBy: json["givenBy"],
      lastEditedBy: json["lastEditedBy"],
      notes: json["notes"],
      lastEdited: DateTime.parse(json["lastEdited"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "creationDate": creationDate.toIso8601String(),
        "id": id,
        "lid": lid,
        "leadName": leadName,
        "leadContact": leadContact,
        "leadEmail": leadEmail,
        "enquiryType": enquiryType,
        "leadType": leadType,
        "project": project,
        "leadFor": leadFor,
        "language": language,
        "leadStatus": leadStatus,
        "leadSource": leadSource,
        "otp": otp,
        "is_whatsapp": isWhatsapp,
        "coldcall": coldcall,
        "city": city,
        "feedback": feedback,
        "priority": priority,
        "assignedToManager": assignedToManager,
        "assignedToSales": assignedToSales,
        "addedBy": addedBy,
        "givenBy": givenBy,
        "lastEditedBy": lastEditedBy,
        "notes": notes,
        "lastEdited": lastEdited?.toIso8601String(),
      };
}

class Link {
  Link({
    required this.url,
    required this.label,
    this.active,
  });

  late String url;
  late String label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}