import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../../logic/view_models/auth_manager.dart';
import '../../theme/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;

  @override
  void dispose() {
    getIt<AuthManager>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? errorMessage = Provider.of<AuthManager>(context).errorMessage;

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          backgroundColor: Colours.black,
          resizeToAvoidBottomInset: true,
          body: ProgressHUD(child: Builder(builder: (context) {
            final progress = ProgressHUD.of(context);
            return ListView(children: [
              SizedBox(
                height: h1p * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 280, right: 20),
                child: Container(
                    height: h1p * 4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/xuriti1.png"),
                      fit: BoxFit.fill,
                    ))),
              ),
              SizedBox(
                height: h1p * 3,
              ),
              Container(
                width: maxWidth,
                height: maxHeight,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
                child: ListView(children: [
                  Center(
                      child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: h1p * 3.5,
                          ),
                          const Text(
                            "LOGIN",
                            style: TextStyles.textStyle3,
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Container(
                            width: w10p * 9,
                            decoration: const BoxDecoration(
                              color: Colours.paleGrey,
                            ),
                            child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: "Email Id ",
                                  hintStyle: TextStyles.textStyle4,
                                )),
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Container(
                            width: w10p * 9,
                            decoration: const BoxDecoration(
                              color: Colours.paleGrey,
                            ),
                            child: TextFormField(
                                controller: passwordController,
                                obscureText: isVisible,
                                decoration: InputDecoration(
                                  suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: isVisible
                                          ? Icon(
                                              Icons.visibility_outlined,
                                              size: 20,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.visibility_off_outlined,
                                              size: 20,
                                              color: Colors.grey,
                                            )),
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: "Password",
                                  hintStyle: TextStyles.textStyle4,
                                )),
                          ),
                          SizedBox(
                            height: h1p * 4,
                          ),
                          InkWell(
                            onTap: () async {
                              progress?.show();
                              Map<String, dynamic> isLogin =
                                  await getIt<AuthManager>()
                                      .signInwithEmailandPassword(
                                          email: emailController.text,
                                          password: passwordController.text);

                              progress?.dismiss();
                              if (isLogin['status'] == true) {
                                getIt<SharedPreferences>().setString(
                                    'password', passwordController.text.trim());

                                Navigator.pushReplacementNamed(
                                    context, oktWrapper);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          isLogin['message'],
                                          style: TextStyle(color: Colors.red),
                                        )));
                              }
                            },
                            child: Container(
                              width: w10p * 9,
                              height: h1p * 7,
                              child: const Center(
                                  child: Text("LOGIN",
                                      style: TextStyles.textStyle5)),
                              decoration: BoxDecoration(
                                  color: Colours.primary,
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w10p * 2.5, vertical: h10p * .4),
                            child: InkWell(
                              onTap: () async {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          'sign in with google',
                                          style:
                                              TextStyle(color: Colours.primary),
                                        )));
                                AuthManager authManager = getIt<AuthManager>();
                                progress!.show();
                                Map<String, dynamic>? message =
                                    await authManager.googleLogin(
                                        isSignIn: true);
                                progress.dismiss();
                                if (message != null) {
                                  if (message['status'] == false) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              message['message'],
                                              style: TextStyle(
                                                  color: Colours.primary),
                                            )));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              message['message'],
                                              style: TextStyle(
                                                  color: Colours.primary),
                                            )));
                                    Navigator.pushNamed(context, oktWrapper);
                                  }
                                }
                              },
                              child: Container(
                                height: h1p * 6,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/google-icon.png"),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    const Text("Login via Google",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0)),
                                  ],
                                )),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colours.black, width: 1),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New User? ",
                                  style: TextStyles.textStyle6,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, signUp);
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyles.textStyle8,
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: h1p * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, forgetPassword);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyles.textStyle9,
                                ),
                              ),
                            ],
                          )
                        ]),
                  ))
                ]),
              ),
            ]);
          })));
    });
  }
}
