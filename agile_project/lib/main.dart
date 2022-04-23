import 'package:agile_project/components/_enumList.dart';
import 'package:agile_project/scenes/authentication/LoginScene.dart';
import 'package:agile_project/scenes/authentication/RegisterScene.dart';
import 'package:agile_project/scenes/nav/HomeScene.dart';
import 'package:agile_project/scenes/nav/ProfileScene.dart';
import 'package:agile_project/scenes/admin-only/StockLevelScene.dart';
import 'package:agile_project/scenes/nav/WishlistScene.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agile Project",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppBase(title: "Agile Project"),
    );
  }
}

class AppBase extends StatefulWidget {
  const AppBase({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AppBase> createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  //initial scene for bottom navigator
  int _selectedNavIndex = 0;
  AccountType accountType = AccountType.guest;

  void _onItemTapped(int index){
    setState(() => {
      _selectedNavIndex = index,
    });
  }

  //for navigation scene 
  static List<Widget> _bottomNavigationScene = <Widget>[];
  
  @override
  void initState() {
    super.initState();
    //for linking navigation scene
    _initialBottomNavigationScene();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //top bar
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: pass,
          ),
          //debug purpose
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: ()=>{
              accountType = (accountType == AccountType.admin) ? AccountType.guest : AccountType.admin,
              //for refresh purpose
              setState(() => {
                _initialBottomNavigationScene(),
              }),
            },
          ),
          //debug purpose
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Login"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Register"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("StockLevel"),
              ),              
            ], 
            onSelected: (int i) => {
              debugHandler(context, i)
            },),
        ],
      
      ),
      body: SafeArea(
        child: _bottomNavigationScene.elementAt(_selectedNavIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Wishlist",
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              ),
          ],
          currentIndex: _selectedNavIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: (accountType == AccountType.admin) ? 
          FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.settings, color: Colors.white,),
            onPressed: _onFabTapped)
          : null,
      );
  }

  //for passing function purpose
  void pass(){}

  void _initialBottomNavigationScene(){
    _bottomNavigationScene.clear();
    _bottomNavigationScene.add(MyHomeScene(currAccountType: accountType,));
    _bottomNavigationScene.add(MyWishlistScene(currAccountType: accountType,));
    _bottomNavigationScene.add(MyProfileScene(currAccountType: accountType,));
  }

  void _onFabTapped(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyStockLevelScene(
    )));
  }

  void debugHandler(BuildContext context, int i){
    switch (i){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLoginScene()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyRegisterScene()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyStockLevelScene()));    
        break;
    }
  }
}
