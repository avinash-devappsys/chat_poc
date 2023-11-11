import 'package:chat_poc/Screens/RegistrationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinode/tinode.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key, required this.tinode});

  final Tinode? tinode;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final TextEditingController otpTexfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 10),
              child: Text(
                "Enter confirmation code",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: otpTexfield,
                decoration: InputDecoration(
                  hintText: "Numbers only",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: Text("CANCEL")),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      var token =
                      widget.tinode?.getAuthenticationToken();

                      Map<String, dynamic> cred = {
                        "code": otpTexfield.text,
                      };

                      var res = widget.tinode?.loginToken(token.toString(), cred);
                      print("logiiin success$res");
                      res?.whenComplete(() =>
                          (action) {
                        print("logiiin success");
                        Fluttertoast.showToast(msg: "login successfull");
                      });
                    },
                    child: Text("CONFIRM"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
