import 'dart:async';

import 'package:adakami/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'input_password_screen.dart';

class LoginValidatorScreen extends StatefulWidget {
  final String phone;
  final String otp;

  LoginValidatorScreen({required this.phone, required this.otp});

  @override
  State<LoginValidatorScreen> createState() => _LoginValidatorScreenState();
}

class _LoginValidatorScreenState extends State<LoginValidatorScreen> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  bool isFillAll = false;
  bool isCountdownZero = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Define a variable to hold the remaining time
  late int _seconds;

  // Create a timer controller
  late Timer _timer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
    _seconds = 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          isCountdownZero = true;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed.
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        'assets/back.PNG',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Kode Verifikasi telah\ndikirim ke ${widget.phone}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 6; i++)
                          Container(
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1)),
                            alignment: Alignment.center,
                            child: TextField(
                              maxLength: 1,
                              controller: controllers[i],
                              focusNode: focusNodes[i],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                setState(() {
                                  isFillAll = controllers.every((controller) =>
                                      controller.text.isNotEmpty);
                                });
                                if (text.length == 1) {
                                  if (i < 5) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[i + 1]);
                                  }
                                } else {
                                  if (i > 0) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[i - 1]);
                                  }
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    (!isCountdownZero)
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${_seconds.toString()}s',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tidak dapat menerima kode verifikasi?\nCoba metode penerimaan lainnya ',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12),
                              ),
                              Text(
                                'Dapatkan',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 30,
                    ),

                    /// LOADING INDIKATOR
                    Visibility(
                      visible: _visible,
                      child: const SpinKitRipple(
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        if (isFillAll) {
                          setState(() {
                            _timer.cancel();
                            isCountdownZero = true;
                          });

                          setState(() {
                            _visible = true;
                          });

                          var code = "";
                          controllers.forEach((element) {
                            code += element.text;
                          });

                          try {
                            // Create a PhoneAuthCredential with the code
                            print(widget.otp);
                            print(code);
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: widget.otp,
                              smsCode: code,
                            );

                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);

                            setState(() {
                              _visible = false;
                            });

                            Route route = MaterialPageRoute(
                                builder: (context) =>
                                    InputPasswordScreen(phone: widget.phone));
                            Navigator.push(context, route);
                          } catch (err) {
                            setState(() {
                              _visible = false;
                            });
                            toast('Gagal, sepertinya kode yang dimasukkan salah');

                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            color:
                                (isFillAll) ? Colors.green : Colors.grey[300]),
                        child: Center(
                          child: Text(
                            ' Kirimkan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
