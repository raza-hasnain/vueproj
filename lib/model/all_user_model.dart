class AllUserModel {
  int? count;
  String? message;
  int? uid;
  List<AllUser>? alluser;
  int? target;
  int? targetReached;
  int? targetRemaining;
  int? totalClosed;

  AllUserModel(
      {this.count,
      this.message,
      this.uid,
      this.alluser,
      this.target,
      this.targetReached,
      this.targetRemaining,
      this.totalClosed});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    target = json['target'];
    uid = json['uid'];
    targetReached = json['target_reached'];
    targetRemaining = json['target_remaining'];
    totalClosed = json['total_closed'];
    message = json['message'];
    if (json['user'] != null) {
      alluser = <AllUser>[];
      json['user'].forEach((v) {
        alluser!.add(AllUser.fromJson(v));
      });
    }
  }
}

class AllUser {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? uid;
  String? loginId;
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
  String? lastEditeBy;
  String? notes;
  int? status;
  String? createdAt;
  String? updatedAt;

  AllUser(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.uid,
      this.loginId,
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
      this.lastEditeBy,
      this.notes,
      this.status,
      this.createdAt,
      this.updatedAt});

  AllUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    uid = json['uid'];
    loginId = json['loginId'];
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
    lastEditeBy = json['lastEditeBy'];
    notes = json['notes'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['uid'] = uid;
    data['loginId'] = loginId;
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
    data['lastEditeBy'] = lastEditeBy;
    data['notes'] = notes;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}