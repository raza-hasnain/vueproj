import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/components/snackbar.dart';
import 'package:test_project/utils/const.dart';

import '../model/update.password.model.dart';

class ChangePasswordController extends ChangeNotifier {
  ///TEXT EDITING CONTROLLERS
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();

  //ALL BOOLS VALUES
  bool isPasswordChange = false;
  bool internet = true;

  //KEY VALUE FOR THE FORM
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  changePasswordFunc(BuildContext context, String loginId) async {
    var connectivity = await (Connectivity().checkConnectivity());
    if (connectivity == ConnectivityResult.none) {
      internet = false;
    } else {
      internet = true;
    }
    final header = {
      'Authorization': 'Bearer $bearerToken',
      'Accept': 'application/json',
    };

    UpdatePassword updatePassword = UpdatePassword(
      loginId: loginId,
      currentPassword: currentPassword.text.trim(),
      confirmPassword: confirmNewPassword.text.trim(),
      newPassword: newPassword.text.trim(),
    );

    try {
      isPasswordChange = true;
      notifyListeners();

      if (isPasswordChange == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => Center(
                  child: CircularProgressIndicator.adaptive(),
                ));
      }
      final response = await http.post(
        Uri.parse(Urls.updatePassword),
        headers: header,
        body: updatePassword.toJson(),
      );

      final data = json.decode(response.body);

      if (data["success"] == true || data["data"]["code"] == 200) {
        snackBar(context, "Password changed successfully", Colors.green);

        Navigator.pop(context);
        Navigator.pop(context, true);

        currentPassword.clear();
        newPassword.clear();
        confirmNewPassword.clear();
      } else if (data["success"] == false ||
          data["message"] == "Validation Error") {
        Navigator.pop(context);
        snackBar(context, "current password not correct", Colors.red);
      }
    } catch (e) {
      log("This is our error $e");
      if (e is SocketException) {
        Navigator.pop(context);
        internet = false;
        snackBar(context, "No internet connection!", Colors.redAccent);
      } else {
        Navigator.pop(context);
        snackBar(context, "Something went wrong", Colors.red);
      }
    } finally {
      isPasswordChange = false;
      notifyListeners();
    }
  }
}
