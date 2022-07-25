import 'package:superchat/pages/driver.dart';
import 'package:superchat/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //Always needed for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirestoreService _ = FirestoreService();
  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SocialApp',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const Driver());
  }
}
