import 'package:adakami/main.dart';
import 'package:flutter/material.dart';

import '../widget/themes.dart';

class DashboardScreen extends StatefulWidget {

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Themes(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'AdaKami',
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffe7f7ff),
                                  borderRadius: BorderRadius.circular(3)),
                              padding: EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 5,
                              ),
                              child: Text(
                                'TKB:90:99.86%',
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Icon(
                              Icons.chat_outlined,
                              color: Colors.green,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.80,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff00903b),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Limit pinjaman tertinggi(Rp)',
                                        style: TextStyle(
                                          color: Color(0xff93d7ae),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '80.000.000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.calendar_today_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff55ba40),
                                                      borderRadius:
                                                          BorderRadius.circular(999)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Tenor 3 - 12 Bulan',
                                                  style: TextStyle(
                                                    color: Color(0xff93d7ae),
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.credit_card,
                                                    color: Colors.white,
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff55ba40),
                                                      borderRadius:
                                                          BorderRadius.circular(999)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Syarat KTP',
                                                  style: TextStyle(
                                                    color: Color(0xff93d7ae),
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.monetization_on_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff55ba40),
                                                      borderRadius:
                                                          BorderRadius.circular(999)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Bunga Max 19%',
                                                  style: TextStyle(
                                                    color: Color(0xff93d7ae),
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Lihat contoh biaya pinjaman',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.arrow_circle_right,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.only(top: 16),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(99)),
                                        child: Center(
                                          child: Text(
                                            'Segera Pinjam',
                                            style: TextStyle(
                                              color: Colors.green[900],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_circle_right,
                                              color: Color(0xffd6f478),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Dana cair dalam waktu ',
                                              style: TextStyle(
                                                color: Color(0xffd6f478),
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '24 jam',
                                              style: TextStyle(
                                                  color: Color(0xffd6f478),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/pusat_tugas.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Pusat Tugas',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/redeem.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Redeem',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/inv_bg.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Undang Teman',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/ig.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Akademi\nInstagram',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/banner.png',
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Supervision Department',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Image.asset(
                              'assets/watermark.PNG',
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xfff7f7f7),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'AdaKami pendanaan, dapatkan bunga\ntahunan menarik',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            ),
        ),
        ),
    );
  }
}
