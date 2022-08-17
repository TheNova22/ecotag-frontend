import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/api_test.dart';
import 'package:sih_frontend/screens/login_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:sih_frontend/utils/api_functions.dart';

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
          apiKey: "AIzaSyAKT1K87BKF-N_EfqRT9QtnasHQk-p9CVI",
          authDomain: "officialconnect-58897.firebaseapp.com",
          databaseURL:
              "https://officialconnect-58897-default-rtdb.firebaseio.com",
          projectId: "officialconnect-58897",
          storageBucket: "officialconnect-58897.appspot.com",
          messagingSenderId: "325443015605",
          appId: "1:325443015605:web:565e445cd3b50016813ffc",
          measurementId: "G-S60LB92CG8"));
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
          return APITestScreen();
        }
        return const LoginScreen();
      },
    );
    return MaterialApp(
      home: stream,
    );
  }
}
