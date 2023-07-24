import 'dart:convert';

ClosedDealsModel apiFromJson(String str) =>
    ClosedDealsModel.fromJson(json.decode(str));

String apiToJson(ClosedDealsModel data) => json.encode(data.toJson());

class ClosedDealsModel {
  ClosedDealsModel({
    required this.count,
    required this.message,
    required this.userId,
    this.closedLeads,
  });

  dynamic count;
  late String message;
  int userId;
  Leads? closedLeads;

  factory ClosedDealsModel.fromJson(Map<String, dynamic> json) =>
      ClosedDealsModel(
        count: json["count"],
        message: json["message"],
        userId: json['user_id'],
        closedLeads: Leads.fromJson(json["leads"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "message": message,
        "leads": closedLeads?.toJson(),
      };
}

class Leads {
  Leads({
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

  factory Leads.fromJson(Map<String, dynamic> json) {
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
    return Leads(
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
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
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
    required this.lid,
    this.amount,
    this.dealDate,
    this.leadName,
    this.leadContact,
    this.project,
    this.enquiryType,
    this.leadType,
    this.leadFor,
    this.leadStatus,
  });

  int lid;
  String? leadName;
  String? leadContact;
  String? enquiryType;
  String? leadType;
  String? project;
  String? leadFor;
  DateTime? dealDate;
  int ? amount;
  String? leadStatus;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      lid: json["lid"],
      leadName: json["leadName"],
      leadContact: json["leadContact"],
      enquiryType: json["enquiryType"],
      leadType: json["leadType"],
      project: json["project"],
      leadFor: json["leadFor"],
      amount: json['amount'],
      dealDate: DateTime.parse(json["dealDate"]),
      leadStatus: json['leadStatus'],
    );
  }

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "leadName": leadName,
        "leadContact": leadContact,
        "enquiryType": enquiryType,
        "leadType": leadType,
        "project": project,
        "leadFor": leadFor,
        'amount': amount,
        "dealDate": dealDate?.toIso8601String(),
        'leadStatus': leadStatus,
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
