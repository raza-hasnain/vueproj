import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/login.controller.dart';
import 'package:test_project/theme/p_theme.dart';

import '../components/snackbar.dart';
import '../widget/login_background_2.dart';
import 'sales_agent/sales_dashboard.dart';


class SalesLogin2 extends StatefulWidget {
  const SalesLogin2({super.key});

  @override
  State<SalesLogin2> createState() => _SalesLogin2State();
}

class _SalesLogin2State extends State<SalesLogin2> {
  final FocusNode _focus = FocusNode();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      debugPrint("Focus: ${_focus.hasFocus}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginController =
    Provider.of<LoginController>(context, listen: false);
    return Stack(
      children: [
        const LoginBackground2(),
        Padding(
          padding:
          const EdgeInsets.only(left: 30, bottom: 0, right: 30, top: 30),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: loginController.loginKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 400,
                      ),
                      SizedBox(
                        child: Card(
                          color: Colors.black.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          elevation: 1000,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 20, right: 20, top: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: loginController.emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(

                                    // border: InputBorder.none,
                                    labelText: 'Login ID',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  focusNode: _focus,
                                  controller: loginController.passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* Required";
                                      } else {
                                        return null;
                                      }
                                    },
                                  obscureText: !_passwordVisible,
                                  // controller: passwordController,
                                  decoration: InputDecoration(
                                    // border: InputBorder.none,
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: _focus.hasFocus == true ? CustomAppTheme().colorOrange : Colors.grey
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Consumer<LoginController>(
                                    builder: (context, login, _) {
                                      return login.isLoading == true
                                          ? const CircularProgressIndicator
                                          .adaptive()
                                          : ElevatedButton(
                                        onPressed: () async {
                                          if (loginController
                                              .loginKey.currentState!
                                              .validate()) {
                                            await login.login(context);
                                            if (loginController
                                                .loginsuccess ==
                                                true) {
                                              if (mounted) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const SalesDashboard(),
                                                  ),
                                                );
                                              }
                                            } else if (loginController
                                                .loginsuccess ==
                                                false) {
                                              if (mounted) {
                                                snackBar(
                                                    context,
                                                    "Invalid password or loginId",
                                                    Colors.red);
                                              }
                                            }
                                          } else {}
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color(0xFFFF6700),
                                          padding: const EdgeInsets.all(10.0),
                                          minimumSize:
                                          const Size.fromHeight(30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: const Text("LOGIN"),
                                      );
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  child: const Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
