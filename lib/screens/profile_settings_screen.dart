import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pengaturan',
            style: TextStyle(
                color: Colors.black54, fontWeight: FontWeight.normal)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.black54,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            height: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Informasi Identitas',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal)),
                    Row(
                      children: [
                        Text('Unggah',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: Colors.black26,
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Keamanan Akun',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal)),
                    Row(
                      children: [
                        Text('',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: Colors.black26,
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tentang Kami',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal)),
                    Row(
                      children: [
                        Text('',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: Colors.black26,
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pusat Bantuan',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal)),
                    Row(
                      children: [
                        Text('',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: Colors.black26,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      content: Text("Apakah anda yakin ingin logout?"),
                      actions: <Widget>[
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Ya"),
                          ),
                          onTap: () async {
                            // Perform logout action
                            await FirebaseAuth.instance.signOut();
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLogin', false);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false);
                          },
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Tidak"),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 60,left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.green, width: 2)),
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'V4.8.0',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
