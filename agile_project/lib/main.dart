import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/authentication/LoginScene.dart';
import 'package:agile_project/scenes/authentication/RegisterScene.dart';
import 'package:agile_project/scenes/home/HomeScene.dart';
import 'package:agile_project/scenes/user/ProfileScene.dart';
import 'package:agile_project/scenes/admin-only/StockLevelScene.dart';
import 'package:agile_project/scenes/user/WishlistScene.dart';
import 'package:agile_project/scenes/product/ManageProductScene.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:agile_project/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCwVr4eW2AcEDK9PBboyihxqia_piR4BCE",
            authDomain: "agileproject-abd4b.firebaseapp.com",
            projectId: "agileproject-abd4b",
            storageBucket: "agileproject-abd4b.appspot.com",
            messagingSenderId: "1003614072630",
            appId: "1:1003614072630:web:c50df18ecafc2dbc384d97"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: "Agile Project",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
