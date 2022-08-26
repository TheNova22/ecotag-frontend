import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/customerScreen/customer_screen_2.dart';
import 'package:sih_frontend/screens/homePage/home_page.dart';

import 'package:sih_frontend/screens/login/login_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// to build web app
// flutter build web --web-renderer canvaskit --no-sound-null-safety --release

// to build flutter apk:
// flutter build apk --split-per-abi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyDfyw5imlf334KAgveGqVM_VkHTRs8yZiA",
      authDomain: "ecotag-211c8.firebaseapp.com",
      projectId: "ecotag-211c8",
      storageBucket: "ecotag-211c8.appspot.com",
      messagingSenderId: "645746490811",
      appId: "1:645746490811:web:4823527c73bf0d8618989e",
      measurementId: "G-KWHSSV8FMV",
    ),
  );
  // }

  if (!kIsWeb) {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final stream = StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // print(FirebaseAuth.instance.currentUser!.uid);
          return const HomePage();
          // return CustomerScreen();
          // return UpdateShipment();

        }
        return const LoginScreen();
      },
    );
    return MaterialApp(
      home: stream,
    );
  }
}
