
import 'dart:convert';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
  ApiModel({
    required this.count,
    required this.message,
    this.user,
    this.userLeads,
    this.leadStatus,
    this.totalClosed,
    this.target,
    this.targetReached,
    this.targetRemaining,
  });

  late int count;
  late String message;
  List<User>? user;
  UserLeads? userLeads;
  LeadStatus? leadStatus;
  int? totalClosed;
  int? target;
  int? targetReached;
  int? targetRemaining;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        count: json["count"],
        message: json["message"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        userLeads: UserLeads.fromJson(json["user_leads"]),
        leadStatus: LeadStatus.fromJson(json["lead_status"]),
        totalClosed: json["total_closed"],
        target: json["target"],
        targetReached: json["target_reached"],
        targetRemaining: json["target_remaining"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "message": message,
        // "user":user ==null? [] :  List<dynamic>.from(user!.map((x) => x.toJson())),
        "user_leads": userLeads?.toJson()
        // "lead_status": leadStatus?.toJson(),
        // "total_closed": totalClosed,
        // "target": target,
        // "target_reached": targetReached,
        // "target_remaining": targetRemaining,
      };
}

class LeadStatus {
  LeadStatus({this.leadStatusNew, this.meeting, this.followup, this.noanswer, this.closed, this.unreachalbe, this.low, this.notinterested});

  int? leadStatusNew;
  int? meeting;
  int? followup;
  int? noanswer;
  int? closed;
  int? unreachalbe;
  int? low;
  int? notinterested;

  factory LeadStatus.fromJson(Map<String, dynamic> json) => LeadStatus(
        leadStatusNew: json["new"],
        meeting: json["meeting"],
        followup: json["followup"],
        noanswer: json["noanswer"],
        closed: json["closed"],
        unreachalbe: json["unreachalbe"],
        low: json["low"],
        notinterested: json["notinterested"],
      );

  Map<String, dynamic> toJson() => {
        "new": leadStatusNew,
        "meeting": meeting,
        "followup": followup,
        "noanswer": noanswer,
        "closed": closed,
        "unreachalbe": unreachalbe,
        "low": low,
        "notinterested": notinterested,
      };
}

class User {
  User({
    required this.creationDate,
    required this.id,
    required this.uid,
    required this.loginId,
    this.oldPassword,
    this.role,
    this.agency,
    this.plusSales,
    this.userType,
    this.userName,
    this.userContact,
    this.userAltContact,
    this.userEmail,
    this.userAltEmail,
    this.dob,
    this.gender,
    this.nationality,
    this.currentAddress,
    this.displayImg,
    this.position,
    this.joiningDate,
    this.idByCompany,
    this.idNo,
    this.idType,
    this.idExpiryDate,
    this.addedFor,
    this.addedBy,
    this.lastEditedBy,
    this.notes,
    this.lastEdited,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  late DateTime creationDate;
  late int id;
  late int uid;
  late String loginId;
  String? oldPassword;
  int? role;
  int? agency;
  int? plusSales;
  String? userType;
  String? userName;
  String? userContact;
  dynamic userAltContact;
  String? userEmail;
  String? userAltEmail;
  dynamic dob;
  String? gender;
  String? nationality;
  dynamic currentAddress;
  String? displayImg;
  String? position;
  DateTime? joiningDate;
  String? idByCompany;
  dynamic idNo;
  dynamic idType;
  dynamic idExpiryDate;
  int? addedFor;
  int? addedBy;
  dynamic lastEditedBy;
  dynamic notes;
  DateTime? lastEdited;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        creationDate: DateTime.parse(json["creationDate"]),
        id: json["id"],
        uid: json["uid"],
        loginId: json["loginId"],
        oldPassword: json["old_password"],
        role: json["role"],
        agency: json["agency"],
        plusSales: json["plusSales"],
        userType: json["userType"],
        userName: json["userName"],
        userContact: json["userContact"],
        userAltContact: json["userAltContact"],
        userEmail: json["userEmail"],
        userAltEmail: json["userAltEmail"],
        dob: json["dob"],
        gender: json["gender"],
        nationality: json["nationality"],
        currentAddress: json["currentAddress"],
        displayImg: json["displayImg"],
        position: json["position"],
        joiningDate: DateTime.parse(json["joiningDate"]),
        idByCompany: json["idByCompany"],
        idNo: json["idNo"],
        idType: json["idType"],
        idExpiryDate: json["idExpiryDate"],
        addedFor: json["addedFor"],
        addedBy: json["addedBy"],
        lastEditedBy: json["lastEditedBy"],
        notes: json["notes"],
        lastEdited: DateTime.parse(json["lastEdited"]),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "creationDate": creationDate.toIso8601String(),
        "id": id,
        "uid": uid,
        "loginId": loginId,
        "old_password": oldPassword,
        "role": role,
        "agency": agency,
        "plusSales": plusSales,
        "userType": userType,
        "userName": userName,
        "userContact": userContact,
        "userAltContact": userAltContact,
        "userEmail": userEmail,
        "userAltEmail": userAltEmail,
        "dob": dob,
        "gender": gender,
        "nationality": nationality,
        "currentAddress": currentAddress,
        "displayImg": displayImg,
        "position": position,
        "joiningDate":
            "${joiningDate?.year.toString().padLeft(4, '0')}-${joiningDate?.month.toString().padLeft(2, '0')}-${joiningDate?.day.toString().padLeft(2, '0')}",
        "idByCompany": idByCompany,
        "idNo": idNo,
        "idType": idType,
        "idExpiryDate": idExpiryDate,
        "addedFor": addedFor,
        "addedBy": addedBy,
        "lastEditedBy": lastEditedBy,
        "notes": notes,
        "lastEdited": lastEdited?.toIso8601String(),
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UserLeads {
  UserLeads({
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
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory UserLeads.fromJson(Map<String, dynamic> json) {
    print(json["data"].runtimeType);
    bool isFirstPage = json["data"].runtimeType == List<dynamic>;
    List<Datum> data = [];
    if (isFirstPage == false) {
      print("isFirstPage");
      data = Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))).values.toList();
    } else {
      data = List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
    }
    return UserLeads(
      currentPage: json["current_page"],
      data: data,
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      // links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
    this.givenBy,
    this.lastEditedBy,
    this.notes,
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
  int? lastEditedBy;
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
