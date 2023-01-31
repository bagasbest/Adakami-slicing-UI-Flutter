import 'package:flutter/material.dart';

import '../widget/themes.dart';

class HistoryLoanScreen extends StatefulWidget {
  const HistoryLoanScreen({Key? key}) : super(key: key);

  @override
  State<HistoryLoanScreen> createState() => _HistoryLoanScreenState();
}

class _HistoryLoanScreenState extends State<HistoryLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Themes(),
      child: Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Pinjaman',
                        style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Image.asset(
                        'assets/headset.PNG',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Container(
                      height: 280,
                      child: Column(
                        children: [
                          Image.asset('assets/loan_hist.PNG'),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            ' Tidak ada catatan pengembalian, silahkan ajukan pinjaman di halaman utama.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
