import 'dart:convert';

MeetingModel apiMeetingModelFromJson(String str) =>
    MeetingModel.fromJson(json.decode(str));

String apiMeetingModelModelToJson(MeetingModel data) =>
    json.encode(data.toJson());

class MeetingModel {
  MeetingModel({
    required this.count,
    required this.message,
    required this.userId,
    this.lead,
  });

  dynamic count;
  late String message;
  int userId;
  Lead? lead;

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        count: json["count"],
        message: json["message"],
        userId: json['user_id'],
        lead: Lead.fromJson(json["leads"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "message": message,
        "leads": lead?.toJson(),
      };
}

class Lead {
  Lead({
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

  factory Lead.fromJson(Map<String, dynamic> json) {
    print(json["data"].runtimeType);
    bool isFirstPage = json["data"].runtimeType == List<dynamic>;
    List<Datum> data = [];
    if (isFirstPage == false) {
      print("isFirstPage");
      data = Map.from(json["data"])
          .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v)))
          .values
          .toList();
    } else {
      data = List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
    }
    return Lead(
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
  Datum(
      {required this.lid,
      this.feedback,
      required this.meetingDate,
      this.meetingTime,
      required this.leadName,
      this.leadContact,
      this.project,
      this.enquiryType,
      this.leadStatus,
      this.leadType,
      this.leadFor,
      required this.meetingStatus});
  late int lid;
  String ? feedback;
  late DateTime meetingDate;
  String? meetingTime;
  late String meetingStatus;
  late String leadName;
  String? leadContact;
  String? project;
  String? enquiryType;
  String? leadStatus;
  String? leadType;
  String? leadFor;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      lid: json['userId'],
      feedback : "",
      meetingDate: DateTime.parse(
        json['meetingDate'],
      ),
      meetingTime: json['meetingTime'],
      meetingStatus: json['meetingStatus'],
      leadName: json['leadName'],
      leadContact: json['leadContact'],
      project: json['project'],
      enquiryType: json['enquiryType'],
      leadStatus: json['leadStatus'],
      leadType: json['leadType'],
      leadFor: json['leadFor'],
    );
  }

  Map<String, dynamic> toJson() => {
        // "meeting": meeting.toJson(),
        "meetingDate": meetingDate.toIso8601String(),
        "userId": lid,
        "meetingTime": meetingTime,
        "meetingStatus": meetingStatus,
        "leadContact": leadContact,
        "leadName": leadName,
        "enquiryType": enquiryType,
        "leadType": leadType,
        "project": project,
        "leadFor": leadFor,
        "leadStatus": leadStatus,
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
