import 'package:adakami/screens/input_password_screen.dart';
import 'package:adakami/screens/login_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isFocused = false;
  bool _isInput = false;
  var _phone = TextEditingController();
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  Image.asset(
                    'assets/halo.PNG',
                    width: 70,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Selamat datang di\nAdaKami.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _phone,
                    decoration: InputDecoration(
                      hintText: 'Nomor Handphone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: _isFocused ? Colors.green : Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: _isFocused ? Colors.green : Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      hintStyle: TextStyle(
                        color: _isFocused ? Colors.green : Colors.grey,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      if (value.length >= 10 && value.length <= 13) {
                        setState(() {
                          _isInput = true;
                        });
                      } else {
                        setState(() {
                          _isInput = false;
                        });
                      }
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        _isFocused = !_isFocused;
                      });
                    },
                  ),
                  (_isFocused)
                      ? Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      'Nomor Handphone (contoh:081122335566)',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                      : Container(),
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
                      if (_isInput) {
                        setState(() {
                          _visible = true;
                        });

                        /// cek apakah sudah terdaftar no tersebut
                        var isStored = await isPhoneNumberStored(_phone.text);

                        print(isStored);

                        if(isStored) {
                          //FirebaseAuth.instance.signInWithPhoneNumber("adas");
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLogin', true);
                          await prefs.setString('number', _phone.text);

                          setState(() {
                            _visible = false;
                          });

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);

                        } else {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: "+62${_phone.text.substring(1)}",
                            verificationCompleted: (PhoneAuthCredential credential) {
                              setState(() {
                                _visible = false;
                              });
                              toast('Kode Terkirim');
                            },
                            verificationFailed: (FirebaseAuthException credential) {
                              setState(() {
                                _visible = false;
                              });
                              toast('Kode Gagal Terkirim');
                            },
                            codeSent: (String verificationId, int? resendToken) {

                              setState(() {
                                _visible = false;
                              });

                              Route route = MaterialPageRoute(
                                  builder: (context) => LoginValidatorScreen(
                                      phone: _phone.text,
                                      otp: verificationId
                                  ));
                              Navigator.push(context, route);
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              toast('Timeout, coba lagi');

                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: (_isInput) ? Colors.green : Colors.grey[300]),
                      child: Center(
                        child: Text(
                          'Mulai Sekarang',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Saya telah baca dan menyetujui ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Ketentuan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 1,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Metode Login Lainnya',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        height: 1,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.PNG',
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset(
                        'assets/facebook_colored.PNG',
                        width: 35,
                        height: 35,
                      ),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/bottom.PNG',
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> isPhoneNumberStored(String phoneNumber) async {
    // 1. Retrieve all documents from the collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    // 2. Loop through each document
    var i = 0;
    for (var document in documents) {
      // 3. Retrieve the phone number field
      String storedPhoneNumber = document.get("nomor_telepon");

      // 4. Compare the retrieved phone number with the desired phone number
      if (storedPhoneNumber == phoneNumber) {
        // 5. If a match is found, return true
        return true;
      }
    }

    // 6. If no match is found, return false
    return false;
  }


}
