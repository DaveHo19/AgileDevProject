import 'package:agile_project/models/user.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugAuth extends StatefulWidget{
  const DebugAuth({Key? key}) : super (key: key);

  @override
  State<DebugAuth> createState() => _DebugAuthState();
}

class _DebugAuthState extends State<DebugAuth>{

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
          title: const Text("Debug-Login"),
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
