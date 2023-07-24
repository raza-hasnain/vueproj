import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/components/snackbar.dart';
import 'package:test_project/controller/leads.controller.dart';
import 'package:test_project/theme/p_theme.dart';

import '../controller/change.password.controller.dart';
import '../widget/widgets.dart' as nav;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    //CONTROLLER
    final changePasswordController =
        Provider.of<ChangePasswordController>(context, listen: false);

    return Scaffold(
      backgroundColor: dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
      appBar: AppBar(
        elevation: 0,
        title: Image(
          image: dark
              ? const AssetImage("assets/images/logo/hikallogo.png")
              : const AssetImage("assets/images/logo/fullLogoRE.png"),
          height: 30,
        ),
        backgroundColor:
        dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
        iconTheme: IconThemeData(
          color: dark
              ? CustomAppTheme().redBright
              : CustomAppTheme().blackFade,
        ),
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none_outlined,
                    color: dark ? CustomAppTheme().redBright : CustomAppTheme().blackFade,),
                  onPressed: null,
                ),
                const SizedBox(
                  width: 0,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const SafeArea(
        child: nav.NavigationDrawer(),
      ),
      body: getBody(dark, changePasswordController),
    );
  }

//BODY
  Widget getBody(bool dark, ChangePasswordController controller) {
    final getUserLoginId = Provider.of<LeadController>(context, listen: false);
    final loginId = getUserLoginId.leadModel.user![0].loginId;
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: dark
                      ? CustomAppTheme().colorBlack
                      : CustomAppTheme().colorWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFieldComponent(
                          validation: (value) {
                            if (value!.isEmpty) {
                              return "Current password required";
                            } else {
                              return null;
                            }
                          },
                          labelText: "Current Password",
                          passwordVisible: _passwordVisible,
                          controller: controller.currentPassword,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFieldComponent(
                          validation: (value) {
                            if (value!.isEmpty) {
                              return "New password required";
                            } else {
                              return null;
                            }
                          },
                          labelText: "New Password",
                          passwordVisible: _passwordVisible,
                          controller: controller.newPassword,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFieldComponent(
                          validation: (value) {
                            if (value!.isEmpty) {
                              return "Confirm password required";
                            } else if (controller.confirmNewPassword.text !=
                                controller.newPassword.text) {
                              return "Password not matched";
                            } else {
                              return null;
                            }
                          },
                          labelText: "Confirm New Password",
                          passwordVisible: _passwordVisible,
                          controller: controller.confirmNewPassword,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Consumer<ChangePasswordController>(
                            builder: (context, changepassword, _) {
                          return Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: dark
                                          ? CustomAppTheme().redBright
                                          : CustomAppTheme().redDark,
                                      padding: const EdgeInsets.all(11.0),
                                      minimumSize: const Size.fromHeight(30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (changepassword.formKey.currentState!
                                              .validate() ==
                                          true) {
                                        await changepassword.changePasswordFunc(
                                            context, loginId!);
                                      } else {
                                        snackBar(
                                            context,
                                            "Fill in all the fields before continue",
                                            Colors.red);
                                      }
                                    },
                                    child: const Text('Change Password'),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    child: IconButton(
                                      icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _focus.hasFocus == true
                                              ? CustomAppTheme().redBright
                                              : CustomAppTheme().colorGrey),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {Key? key,
      required bool passwordVisible,
      required this.controller,
      required this.labelText,
      required this.validation})
      : _passwordVisible = passwordVisible,
        super(key: key);

  final bool _passwordVisible;
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validation;

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return TextFormField(
      validator: validation,
      style: TextStyle(
        color:
            dark ? CustomAppTheme().colorWhite : CustomAppTheme().colorDarkBlue,
      ),
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: dark
              ? CustomAppTheme().colorWhite
              : CustomAppTheme().redDark,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: dark
                ? CustomAppTheme().colorWhite
                : CustomAppTheme().blackFade,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: dark
                ? CustomAppTheme().redBright
                : CustomAppTheme().redDark,
          ),
        ),
      ),
      controller: controller,
    );
  }
}
