import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:test_project/utils/assets.dart';
import 'package:test_project/utils/local.storage.dart';
import '../components/app.pop_ups.dart';
import '../injectors.dart';
import '../model/login.model.dart';
import '../utils/const.dart';

class LoginController extends ChangeNotifier {
  LoginController();

  //TextEditing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  late Map<String, dynamic> responseOfLogin;
  bool loginsuccess = false;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final LocalStorage _localStorage = LocalStorage();

  Future<LoginModel> login(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.post(Uri.parse(Urls.loginUri), body: {
        'loginId': emailController.text.trim(),
        'password': passwordController.text.trim()
      });
      log(response.body.toString());
      responseOfLogin = json.decode(response.body);

      if (response.statusCode == 200 || responseOfLogin['success'] == true) {
        loginsuccess = true;
        notifyListeners();

        final token = await responseOfLogin['data']['token'];

        log("login token is :$token");

        await _localStorage.saveLoginToken(token);

        emailController.clear();
        passwordController.clear();
      }
      else if (responseOfLogin['success'] == false) {
        loginsuccess = false;
        notifyListeners();
      }
    } catch (error) {
      log("Network $error");
      injector<AppPopUps>().showDialogue(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: LottieBuilder.asset(noInternet)),
          ],
        ),
      ));
      // snackBar(context, "Failed to login", Colors.red);
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return LoginModel.fromJson(responseOfLogin);
  }
}
