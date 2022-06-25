import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/cartItem.dart';
import 'package:agile_project/models/order.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class MyPaymentScene extends StatefulWidget {
  const MyPaymentScene({
    Key? key,
    required this.orderData
    }) : super(key: key);

  final OrderInfo orderData; 
  @override
  State<MyPaymentScene> createState() => _MyPaymentSceneState();
}

class _MyPaymentSceneState extends State<MyPaymentScene> {
  AppUser? user;
  List<Widget> formView = [];
  List<String> orderBookIDList = [];
  List<Book> bookList = [];
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardCVCController = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardExpireDate = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderBookIDList = widget.orderData.orderItems.entries.map((e) => e.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    intialFormView();
    user = Provider.of<AppUser?>(context); 
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      body: (user != null) ? buildContent() : const Center( child: Text("No user login")),
    );
  }

  Widget buildContent(){
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Form(
        key: formKey,
        child: ListView.builder(
          itemCount: formView.length,
          itemBuilder: (context, i) => formView[i]),
      ),
    );
  }

  Widget buildField(String fieldName, TextEditingController controller){
     return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
          controller: controller,
          validator: (String? val) =>
              (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
          decoration: inputDecoration(fieldName),
        ),
    );
  }

  Widget buildCardInfoRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: buildField("Expire Date", cardExpireDate)),
          Expanded(
            child: buildField("Card CVC", cardCVCController)),
        ],
      )
    );
  }

  Widget buildPaymentPrice(){
    return Container(
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total Payment: ",
             style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              ),
            ),
          Text(
            "RM${(widget.orderData.orderItemPrices + widget.orderData.deliveryFee).toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )
        ]
      ),
    );
  }

  Widget buildPayButton(){
    return Center(
      child: Container(
        padding: const EdgeInsets.all(2),
        width: 100,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor
          ),
          child: const Text(
            "Pay",
            style: TextStyle(
              color: kPrimaryLightColor
            ),
            ),
          onPressed: (){
            payProcess();
          },
        )
      )
    );
  }

  void payProcess() async {
    if (formKey.currentState!.validate()){
      if(user != null){
        DatabaseService dbService = DatabaseService();
        String id = await dbService.createOrders(widget.orderData, user!.uid);
        if (id.isNotEmpty){
          List<String> curOrderList = await dbService.getOrderList(user!.uid);
          curOrderList.add(id);
          dynamic result = await dbService.updateUserOrder(user!.uid, curOrderList);
          if (result == null){
             bookList = await dbService.getBookListByBookISBNList(orderBookIDList);
             for (int i = 0; i < bookList.length; i++){
              int newQuantity = bookList[i].quantity - widget.orderData.orderItems[bookList[i].ISBN_13]!;
              dynamic result = await dbService.updateBookQuantity(bookList[i].ISBN_13, newQuantity);
              if (result != null){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to change book quantity")));
              }
             }
             result = await dbService.updateUserCartItems(user!.uid, {});
             if (result == null){
              Navigator.pop(context, true);
             } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to clear cart!")));
             }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to create order!")));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all the field!")));
    }
  }
  void intialFormView(){
    formView.clear();
    formView.add(buildField("Card Number", cardNumberController));
    formView.add(buildField("Card Holder Name", cardHolderName));
    formView.add(buildCardInfoRow());
    formView.add(buildPaymentPrice());
    formView.add(buildPayButton());
  }
}