import 'dart:convert';

LeadNotesModel apiLeadsNotesFromJson(String str) =>
    LeadNotesModel.fromJson(json.decode(str));

String apiFollowUpLeadsModelToJson(LeadNotesModel data) =>
    json.encode(data.toJson());

class LeadNotesModel {
  LeadNotesModel({
    required this.status,
    this.posts,
    this.message
  });

  late bool status;
  Posts? posts;
  String ? message;

  factory LeadNotesModel.fromJson(Map<String, dynamic> json) => LeadNotesModel(
        status: json["status"],
        message: json["message"],
        posts: Posts.fromJson(json["logs"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message" : message,
        "logs": posts?.toJson(),
      };
}

class Posts {
  Posts({
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
  List<Data>? data;
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

  factory Posts.fromJson(Map<String, dynamic> json) {
    print(json["data"].runtimeType);
    bool isFirstPage = json["data"].runtimeType == List<dynamic>;
    List<Data> data = [];
    if (isFirstPage == false) {
      print("isFirstPage");
      data = Map.from(json["data"])
          .map((k, v) => MapEntry<String, Data>(k, Data.fromJson(v)))
          .values
          .toList();
    } else {
      data = List<Data>.from(json["data"].map((x) => Data.fromJson(x)));
    }
    return Posts(
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

class Data {
  Data(
      {required this.creationDate,
      required this.id,
      this.lnId,
      this.leadId,
      this.leadNote,
      this.addedBy});

  late DateTime creationDate;
  late int id;
  int? lnId;
  int? leadId;
  String? leadNote;
  int? addedBy;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      creationDate: DateTime.parse(json["creationDate"]),
      id: json["id"],
      addedBy: json["addedBy"],
      leadId: json["leadId"],
      lnId: json["lnId"],
      leadNote: json["leadNote"],
    );
  }

  Map<String, dynamic> toJson() => {
        "creationDate": creationDate.toIso8601String(),
        "id": id,
        "addedBy": addedBy,
        "leadId": leadId,
        "lnId": lnId,
        "leadNote": leadNote,
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
