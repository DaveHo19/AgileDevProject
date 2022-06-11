import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/authentication/login/LoginScene.dart';
import 'package:agile_project/scenes/authentication/register/RegisterScene.dart';
import 'package:agile_project/scenes/user/ProfileScene.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillingAddress extends StatefulWidget{
  const MyProfileScene {Key? key}) : super (key: key);

  @override
  Widget build (BuildContext context){
    return const MyProfileScene(

      title: AddressInformation
      home：AddressBody(),
    );
  }

 class AddressInformation extends StatefulWidget {
  const AddressInformation{Key? key}):super (key: key);

  @override
  AddressInformationState createState() =>_AddressInformationState()}

  class AddressInformationState extends State<AddressInformation> {

    String BillingAddress = (Auth().auth.BillingAddress).address.toString();
    TextEditingController addressController = TextEditingController();
    bool isLoading = false;
    final refDatabase = FirebaseAuth.instance;

    @override
    Widget build (BuildContext context){

   onPressed:(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: BuildContext context) => const AddressInformation ();
     ),
   },
    },

    



    
  }
   
 } 