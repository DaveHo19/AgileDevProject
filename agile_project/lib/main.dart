import 'package:agile_project/scenes/HomeScene.dart';
import 'package:agile_project/scenes/ProfileScene.dart';
import 'package:agile_project/scenes/WishlistScene.dart';
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
  int _selectedNavIndex = 1;
  
  void _onItemTapped(int index){
    setState(() => {
      _selectedNavIndex = index,
    });
  }

  //for navigation scene 
  static List<Widget> _widgetOptions = <Widget>[];
  
  @override
  void initState() {
    super.initState();
    
    //for linking navigation scene
    _widgetOptions.add(const MyHomeScene());
    _widgetOptions.add(const MyWishlistScene());
    _widgetOptions.add(const MyProfileScene());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //top bar
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedNavIndex)),
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
      );
  }
}
