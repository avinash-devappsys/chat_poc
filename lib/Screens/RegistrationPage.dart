import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_poc/Screens/ConfirmationScreen.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:tinode/tinode.dart';

import 'SigninPage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  final TextEditingController usernamecontroller =
      TextEditingController(); // user name
  final TextEditingController lastnamecontroller =
      TextEditingController(); //last name
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController email = TextEditingController(); // password
  void successDialog() {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: false,
        title: 'Succes',
        desc: 'Registered ',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        }).show();
  }

  connectTinode() async {
    var key = 'AQEAAAABAAD_rAp4DJh05a1HAwFT3A6K';
    var host = 'sandbox.tinode.co';

    var loggerEnabled = true;
    var tinode = Tinode(
        'Moein', ConnectionOptions(host, key, secure: true), loggerEnabled);
    await tinode.connect();

    Map<String, dynamic> json = {
      "meth": "email",
      "val": email.text.toString(),
      "done": null,
    };
    print("email--------------------------------");
    Credential credential = Credential.fromMessage(json);

    List<Credential>? cred = [credential];
    // AccountParams(cred: cred)
    var res = await tinode.createAccountBasic(usernamecontroller.text,
        passwordcontroller.text, true, AccountParams(cred: cred));

    print("result on success" + res.toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          tinode: tinode,
        ),
      ),
    );
    print("registration123 $res");
  }

  void registerUser() {
    Random random = new Random();
    int randomNumber = random.nextInt(1000);
    if (usernamecontroller.text != '' &&
        lastnamecontroller.text != '' &&
        passwordcontroller.text != '' &&
        email.text != '') {
      connectTinode();

      //  successDialog();
      // usernamecontroller.text = '';
      // lastnamecontroller.text = '';
      // usernamecontroller.text = '';
      // email.text = '';
      // passwordcontroller.text = '';
    } else {
      errorDialog();
    }
  }

  void errorDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Error',
        desc: 'Enter all details',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset('assets/images/shape_img.png'),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Welcome Onboard!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Let’s help ypu to meet'
                      ' your Task!',
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: usernamecontroller,
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: lastnamecontroller,
                      decoration: InputDecoration(
                        hintText: "Enter Your Last Name",
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordcontroller,
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
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                    padding: const EdgeInsets.only(top: 40.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        // padding: const EdgeInsets.all(16.0),
                        primary: Color(0xFF50C2C9),
                        fixedSize: const Size(272, 56),
                      ),
                      onPressed: () {
                        registerUser();

                        print("registered");
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 95, top: 10),
                          child: Text("Already have Account ? "),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
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
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: const Text('Sign In'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
