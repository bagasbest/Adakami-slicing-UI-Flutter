import 'package:adakami/screens/dashboard_screen.dart';
import 'package:adakami/screens/history_loan_screen.dart';
import 'package:adakami/screens/login_screen.dart';
import 'package:adakami/screens/profile_screen.dart';
import 'package:adakami/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _bottomNavigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined, color: Colors.grey),
      activeIcon: Icon(Icons.home_filled, color: Colors.green),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet_outlined, color: Colors.grey),
      activeIcon: Icon(Icons.wallet, color: Colors.green),
      label: 'Riwayat Pinjaman',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.face, color: Colors.grey),
      activeIcon: Icon(Icons.face, color: Colors.green),
      label: 'Akun Saya',
    ),
  ];

  final List<Widget> _screens = [
    DashboardScreen(),
    HistoryLoanScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getIsLogin();
  }

  // Getting a boolean value
  getIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool('isLogin') ?? false;
    if(!isLogin) {
      Route route = MaterialPageRoute(
          builder: (context) => LoginScreen());
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(data: Themes(),
        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavigationBarItems,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        )
    );
  }
}
