class LeadModel {
  int? count;
  String? message;
  List<User>? user;
  UserLeads? userLeads;
  LeadStatus? leadStatus;
  int? totalClosed;
  int? target;
  int? targetReached;
  int? targetRemaining;

  LeadModel(
      {this.count,
      this.message,
      this.user,
      this.userLeads,
      this.leadStatus,
      this.totalClosed,
      this.target,
      this.targetReached,
      this.targetRemaining});

  LeadModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    message = json['message'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
    userLeads = json['user_leads'] != null
        ? UserLeads.fromJson(json['user_leads'])
        : null;
    leadStatus = json['lead_status'] != null
        ? LeadStatus.fromJson(json['lead_status'])
        : null;
    totalClosed = json['total_closed'];
    target = json['target'];
    targetReached = json['target_reached'];
    targetRemaining = json['target_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    if (userLeads != null) {
      data['user_leads'] = userLeads!.toJson();
    }
    if (leadStatus != null) {
      data['lead_status'] = leadStatus!.toJson();
    }
    data['total_closed'] = totalClosed;
    data['target'] = target;
    data['target_reached'] = targetReached;
    data['target_remaining'] = targetRemaining;
    return data;
  }
}

class User {
  String? creationDate;
  int? id;
  int? uid;
  String? loginId;
  String? oldPassword;
  int? role;
  int? agency;
  int? plusSales;
  String? userType;
  String? userName;
  String? userContact;
  String? userAltContact;
  String? userEmail;
  String? userAltEmail;
  String? dob;
  String? gender;
  String? nationality;
  String? currentAddress;
  String? displayImg;
  String? position;
  String? joiningDate;
  String? idByCompany;
  String? idNo;
  String? idType;
  String? idExpiryDate;
  int? addedFor;
  int? addedBy;
  int? lastEditedBy;
  String? notes;
  String? lastEdited;
  int? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.creationDate,
      this.id,
      this.uid,
      this.loginId,
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
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    id = json['id'];
    uid = json['uid'];
    loginId = json['loginId'];
    oldPassword = json['old_password'];
    role = json['role'];
    agency = json['agency'];
    plusSales = json['plusSales'];
    userType = json['userType'];
    userName = json['userName'];
    userContact = json['userContact'];
    userAltContact = json['userAltContact'];
    userEmail = json['userEmail'];
    userAltEmail = json['userAltEmail'];
    dob = json['dob'];
    gender = json['gender'];
    nationality = json['nationality'];
    currentAddress = json['currentAddress'];
    displayImg = json['displayImg'];
    position = json['position'];
    joiningDate = json['joiningDate'];
    idByCompany = json['idByCompany'];
    idNo = json['idNo'];
    idType = json['idType'];
    idExpiryDate = json['idExpiryDate'];
    addedFor = json['addedFor'];
    addedBy = json['addedBy'];
    lastEditedBy = json['lastEditedBy'];
    notes = json['notes'];
    lastEdited = json['lastEdited'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creationDate'] = creationDate;
    data['id'] = id;
    data['uid'] = uid;
    data['loginId'] = loginId;
    data['old_password'] = oldPassword;
    data['role'] = role;
    data['agency'] = agency;
    data['plusSales'] = plusSales;
    data['userType'] = userType;
    data['userName'] = userName;
    data['userContact'] = userContact;
    data['userAltContact'] = userAltContact;
    data['userEmail'] = userEmail;
    data['userAltEmail'] = userAltEmail;
    data['dob'] = dob;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['currentAddress'] = currentAddress;
    data['displayImg'] = displayImg;
    data['position'] = position;
    data['joiningDate'] = joiningDate;
    data['idByCompany'] = idByCompany;
    data['idNo'] = idNo;
    data['idType'] = idType;
    data['idExpiryDate'] = idExpiryDate;
    data['addedFor'] = addedFor;
    data['addedBy'] = addedBy;
    data['lastEditedBy'] = lastEditedBy;
    data['notes'] = notes;
    data['lastEdited'] = lastEdited;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserLeads {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  UserLeads(
      {this.currentPage,
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
      this.total});

  UserLeads.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  String? creationDate;
  int? id;
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
  String? country;
  String? feedback;
  String? priority;
  int? assignedToManager;
  int? assignedToSales;
  int? addedBy;
  int? givenBy;
  int? lastEditedBy;
  String? notes;
  String? lastEdited;
  dynamic fileName;
  dynamic ip;
  dynamic device;

  Data(
      {this.creationDate,
      this.id,
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
      this.country,
      this.feedback,
      this.priority,
      this.assignedToManager,
      this.assignedToSales,
      this.addedBy,
      this.givenBy,
      this.lastEditedBy,
      this.notes,
      this.lastEdited,
      this.fileName,
      this.ip,
      this.device
      });

  Data.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    id = json['id'];
    lid = json['lid'];
    leadName = json['leadName'];
    leadContact = json['leadContact'];
    leadEmail = json['leadEmail'];
    enquiryType = json['enquiryType'];
    leadType = json['leadType'];
    project = json['project'];
    leadFor = json['leadFor'];
    language = json['language'];
    leadStatus = json['leadStatus'];
    leadSource = json['leadSource'];
    otp = json['otp'];
    isWhatsapp = json['is_whatsapp'];
    coldcall = json['coldcall'];
    city = json['city'];
    country = json['country'];
    feedback = json['feedback'];
    priority = json['priority'];
    assignedToManager = json['assignedToManager'];
    assignedToSales = json['assignedToSales'];
    addedBy = json['addedBy'];
    givenBy = json['givenBy'];
    lastEditedBy = json['lastEditedBy'];
    notes = json['notes'];
    lastEdited = json['lastEdited'];
    fileName = json['filename'];
    ip = json['ip'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creationDate'] = creationDate;
    data['id'] = id;
    data['lid'] = lid;
    data['leadName'] = leadName;
    data['leadContact'] = leadContact;
    data['leadEmail'] = leadEmail;
    data['enquiryType'] = enquiryType;
    data['leadType'] = leadType;
    data['project'] = project;
    data['leadFor'] = leadFor;
    data['language'] = language;
    data['leadStatus'] = leadStatus;
    data['leadSource'] = leadSource;
    data['otp'] = otp;
    data['is_whatsapp'] = isWhatsapp;
    data['coldcall'] = coldcall;
    data['city'] = city;
    data['country'] = country;
    data['feedback'] = feedback;
    data['priority'] = priority;
    data['assignedToManager'] = assignedToManager;
    data['assignedToSales'] = assignedToSales;
    data['addedBy'] = addedBy;
    data['givenBy'] = givenBy;
    data['lastEditedBy'] = lastEditedBy;
    data['notes'] = notes;
    data['lastEdited'] = lastEdited;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class LeadStatus {
  int? neww;
  int? meeting;
  int? followup;
  int? noanswer;
  int? closed;
  int? unreachable;
  int? low;
  int? notinterested;

  LeadStatus(
      {this.neww,
      this.meeting,
      this.followup,
      this.noanswer,
      this.closed,
      this.unreachable,
      this.low,
      this.notinterested});

  LeadStatus.fromJson(Map<String, dynamic> json) {
    neww = json['new'];
    meeting = json['meeting'];
    followup = json['followup'];
    noanswer = json['noanswer'];
    closed = json['closed'];
    unreachable = json['unreachable'];
    low = json['low'];
    notinterested = json['notinterested'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new'] = neww;
    data['meeting'] = meeting;
    data['followup'] = followup;
    data['noanswer'] = noanswer;
    data['closed'] = closed;
    data['unreachable'] = unreachable;
    data['low'] = low;
    data['notinterested'] = notinterested;
    return data;
  }
}
