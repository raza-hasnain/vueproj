import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/login.controller.dart';
import 'package:test_project/utils/global.util.dart';
import 'package:test_project/view/dashboard/dashboard.dart';
import 'package:test_project/view/sales_agent/sales_dashboard.dart';
import 'package:test_project/view/sales_manager/manager_dashboard.dart';
import '../components/app.pop_ups.dart';
import '../components/snackbar.dart';
import '../controller/internet_connectivity_controller.dart';
import '../controller/leads.controller.dart';
import '../injectors.dart';
import '../utils/enum.dart';
import '../widget/widgets.dart';

class SalesLogin extends StatefulWidget {
  const SalesLogin({super.key});

  @override
  State<SalesLogin> createState() => _SalesLoginState();
}

class _SalesLoginState extends State<SalesLogin> {
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

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: ConnectionStatusValueNotifier(),
          builder: (context, ConnectionStatus status, child) {
            return Stack(
              children: [
                const LoginBackground(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, bottom: 0, right: 30, top: 30),
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
                                height: 150,
                              ),
                              const Center(
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/logo/hikallogo.png"),
                                  height: 90,
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              SizedBox(
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 1000,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        bottom: 20,
                                        right: 20,
                                        top: 10),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller:
                                              loginController.emailController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "* Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                          focusNode: _focus,
                                          controller: loginController
                                              .passwordController,
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
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                  _passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: _focus.hasFocus == true
                                                      ? Color(0xFFD91F26)
                                                      : Colors.white),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
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
                                                    if (status == ConnectionStatus.online) {
                                                      if (loginController.loginKey.currentState!.validate()) {
                                                        await login.login(context);
                                                        if (loginController.loginsuccess == true) {
                                                          if (mounted) {
                                                            //Just Temp Fix - I don't understand the app-flow :P
                                                            await Future.microtask(() => context.read<LeadController>().getData());
                                                            print("Check Response Lead: ${context.read<LeadController>().responseOfLeads?['user'][0]['role']}");
                                                            context.read<LeadController>().responseOfLeads?['user'][0]['role'] == 7
                                                                ? Navigator.of(context).pushReplacement(
                                                              MaterialPageRoute(builder: (context) =>
                                                              const SalesDashboard(),
                                                              ),
                                                            )
                                                                : context.read<LeadController>().responseOfLeads?['user'][0]['role'] == 3
                                                                ?
                                                            Navigator.of(context).pushReplacement(
                                                                MaterialPageRoute(builder:(context) =>
                                                                const ManagerDashboard()
                                                                )
                                                            )
                                                                :
                                                            Navigator.of(context).pushReplacement(
                                                                MaterialPageRoute(builder:(context) =>
                                                                const ManagerDashboard()
                                                                )
                                                            );
                                                            // Navigator.pushReplacement(
                                                            //     context, MaterialPageRoute(
                                                            //         builder: (context) => SalesDashboard()));
                                                          }
                                                        } else if (loginController.loginsuccess == false) {
                                                          if (mounted) {
                                                            snackBar(context, "Invalid password or loginId", Colors.red);
                                                          }
                                                        }
                                                      } else {}
                                                    } else {
                                                      injector<AppPopUps>().showDialogue(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                "No internet Connection",
                                                                style: TextStyle(
                                                                  color: Colors.red ,
                                                                  fontSize: 25,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  navigatorKey.currentState!.pop();
                                                                },
                                                                child: Text("OK"),
                                                              )
                                                          ],
                                                        ),
                                                      ));
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF980f13),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            30),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
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
                                              color: Colors.white70,
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
          }),
    );
  }
}
