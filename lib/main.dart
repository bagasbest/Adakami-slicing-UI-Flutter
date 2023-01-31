import 'package:adakami/screens/home_screen.dart';
import 'package:adakami/screens/login_screen.dart';
import 'package:adakami/widget/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyBehavior(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSplash = true;
  bool isSplashScreen = true;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        isSplash = false;
        initializationSplashScreen();
      });
    });
  }

  void initializationSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        isSplashScreen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// cek apakah pengguna sudah login sebelumnya atau belum, jika sudah langsung masuk ke homepage, jika belum masuk ke login
    User? user = FirebaseAuth.instance.currentUser;
    if (isSplash) {
      return Container(
        color: Colors.black54,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(888),
            child: Image.asset(
              'assets/logo.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (isSplashScreen) {
      return Container(
        color: Colors.black54,
        child: Center(
          child: Image.asset(
            'assets/splash_screen.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      if (user != null) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes(),
          home: HomeScreen(),
        );
      } else {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes(),
          home: HomeScreen(),
        );
      }
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
