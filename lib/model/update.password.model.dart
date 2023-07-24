class UpdatePassword {
  late String loginId;
  late String currentPassword;
  late String newPassword;
  late String confirmPassword;

  UpdatePassword(
      {required this.loginId,
      required this.currentPassword,
      required this.confirmPassword,
      required this.newPassword});

  // TO FETCH THE DATA TO THE SERVER
  UpdatePassword.fromMap(Map<String, dynamic> json) {
    loginId = json["loginId"];
    newPassword = json["password"];
    confirmPassword = json["c_password"];
    currentPassword = json["old_password"];
  }

  // TO SEND THE DATA TO THE SERVER
  Map<String, dynamic> toJson() {
    return {
      "loginId": loginId,
      "password": newPassword,
      "c_password": confirmPassword,
      "old_password": currentPassword,
    };
  }
}
