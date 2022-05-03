import 'package:agile_project/models/user.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLoginScene extends StatefulWidget{
  const MyLoginScene({Key? key}) : super (key: key);

  @override
  State<MyLoginScene> createState() => _MyLoginSceneState();
}

class _MyLoginSceneState extends State<MyLoginScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final status = Provider.of<AppUser?>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
            child: (status == null) ? 
            ElevatedButton(
              onPressed: () async {
                  dynamic loginResult = await _auth.signInAnon();
                  if(loginResult != null){
                    Navigator.pop(context);
                }
              }, 
              child: const Text("Login as anon")) :
              ElevatedButton(
              onPressed: () async {
                  _auth.signOut().then((value) => Navigator.pop(context));
                },
              child: const Text("Logout")),
          ),
        ),
    );
  }
}
