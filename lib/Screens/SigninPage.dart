

import 'package:chat_poc/Screens/RecentChatScreen.dart';
import 'package:chat_poc/Screens/RegistrationPage.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tinode/tinode.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController firstname = TextEditingController(); //last name
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void errorDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Error',
        desc: 'Invalid user name or password',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
        .show();
  }

  int flag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/shape_img.png'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 20),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/sign_in.png')),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    controller: firstname,
                    decoration: InputDecoration(
                      hintText: "Enter Your First Name",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color(0xFF50C2C9),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      // padding: const EdgeInsets.all(16.0),
                      primary: Color(0xFF50C2C9),
                      fixedSize: const Size(272, 56),
                    ),
                    onPressed: () {
                      login();
                      flag = 1;
                      if (flag == 0) {
                        errorDialog();
                      }
                      // firstname.text = "";
                      // password.text = "";
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 95, top: 10),
                        child: Text("Don't have an Account ? "),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(1.0),
                            primary: Color(0xFF50C2C9),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          child: const Text('Sign up'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    var key = 'AQEAAAABAAD_rAp4DJh05a1HAwFT3A6K';
    var host = 'sandbox.tinode.co';

    var loggerEnabled = true;
    var tinode = Tinode(
        'Moein', ConnectionOptions(host, key, secure: true), loggerEnabled);
    await tinode.connect();
    try {
      var result = await tinode.loginBasic(firstname.text, password.text, null);
      if (result.code != 200) {
        Fluttertoast.showToast(msg: "${result.text}");
      } else {
        print('User Id: ${result.params['user']}');
        print('User text: ${result.text}');

        if (tinode.isAuthenticated) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RecentChatScreen(
                    tinode: tinode,
                  ),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: "${result.text}");
        }
      }
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
