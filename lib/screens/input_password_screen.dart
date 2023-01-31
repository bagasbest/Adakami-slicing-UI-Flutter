import 'package:adakami/screens/forgot_password_screen.dart';
import 'package:adakami/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPasswordScreen extends StatefulWidget {
  final String phone;

  InputPasswordScreen({
    required this.phone,
  });

  @override
  State<InputPasswordScreen> createState() => _InputPasswordScreenState();
}

class _InputPasswordScreenState extends State<InputPasswordScreen> {
  bool _isFocused = false;
  bool _isInput = false;
  bool _isShowPW = false;
  bool _visibility = false;
  var _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
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
                    'Selamat datang',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Nomor Handphone: ${widget.phone}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _phone,
                    obscureText: _isShowPW,
                    decoration: InputDecoration(
                        hintText: 'Kata Sandi',
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
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isShowPW = !_isShowPW;
                              });
                            },
                            child: (!_isShowPW)
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.remove_red_eye_outlined))),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      if (value.length >= 1) {
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
                  const SizedBox(
                    height: 30,
                  ),

                  /// LOADING INDIKATOR
                  Visibility(
                    visible: _visibility,
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

                        try {
                          setState(() {
                            _visibility = true;
                          });

                          await _registeringUserToDatabase();
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLogin', true);

                          setState(() {
                            _visibility = false;
                          });

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                        } catch(err) {
                          setState(() {
                            _visibility = false;
                          });
                          toast('Silahkan ulangi lagi');
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ubah nomor HP >',
                        style: TextStyle(color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(
                                phone: widget.phone
                              ));
                          Navigator.push(context, route);
                        },
                        child: Text(
                          'Lupa Kata Sandi >',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kode verifikasi login',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16,),
                      Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Demi keamanan akun anda, Jangan pernah memberitahukan kata sandi akun anda kepada orang lain.', style: TextStyle(color: Colors.grey),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  ///FUNCTION TO STORE USER IN FIREBASE FIRESTORE
  _registeringUserToDatabase() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "id_user": uid,
        "nama_lengkap": "",
        "email": "",
        "image": "",
        "password": _phone.text,
        "nomor_telepon": widget.phone,
      });
    } catch (error) {
      toast("Gagal melakukan pendaftaran, silahkan cek koneksi internet anda");
    }
  }
}


/// CUSTOM TOAST
void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
