import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String phone;
  ForgotPasswordScreen({
    required this.phone,
});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isInput = false;
  bool _isShowPW = false;
  var kode = TextEditingController();
  var pw1 = TextEditingController();
  var pw2 = TextEditingController();

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
                    'Atur Ulang Sandi',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child:  TextFormField(
                          controller: kode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: 'Kode verifikasi',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: _isFocused3 ? Colors.green : Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: _isFocused3 ? Colors.green : Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            hintStyle: TextStyle(
                              color: _isFocused3 ? Colors.green : Colors.grey,
                            ),
                          ),
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
                              _isFocused3 = !_isFocused3;
                              _isFocused2 = false;
                              _isFocused1 = false;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange
                        ),
                        child: Center(
                          child: Text(
                            'Dapatkan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: pw1,
                    obscureText: _isShowPW,
                    decoration: InputDecoration(
                        hintText: 'Kata Sandi Baru',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: _isFocused1 ? Colors.green : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: _isFocused1 ? Colors.green : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        hintStyle: TextStyle(
                          color: _isFocused1 ? Colors.green : Colors.grey,
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
                        _isFocused1 = !_isFocused1;
                        _isFocused2 = false;
                        _isFocused3 = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: pw2,
                    obscureText: _isShowPW,
                    decoration: InputDecoration(
                        hintText: 'Kata Sandi Baru',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: _isFocused2 ? Colors.green : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: _isFocused2 ? Colors.green : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        hintStyle: TextStyle(
                          color: _isFocused2 ? Colors.green : Colors.grey,
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
                        _isFocused2 = !_isFocused2;
                        _isFocused1 = false;
                        _isFocused3 = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_isInput) {
                        Navigator.of(context).pop();
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
                          'Selanjutnya',
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
