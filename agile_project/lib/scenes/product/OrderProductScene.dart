import 'package:agile_project/constants.dart';
import 'package:agile_project/models/address.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/order.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/models/userInfo.dart';
import 'package:agile_project/scenes/product/PaymentScene.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/services/manager.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class MyOrderProductScene extends StatefulWidget {
  const MyOrderProductScene({Key? key}) : super(key: key);

  @override
  State<MyOrderProductScene> createState() => _MyOrderProductSceneState();
}

class _MyOrderProductSceneState extends State<MyOrderProductScene> {
  AppUser? user;
  bool isProcess = false;
  bool initial = false;
  UserInfomation? userInformation;
  List<Book> bookList = [];
  Map<String, int> cartItemMap = {};
  Map<String, String> billingAddressMap = {};
  Map<String, String> shippingAddressMap = {};
  List<Widget> widgetList = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController bAddressController = TextEditingController();
  TextEditingController sAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return isProcess
        ? const Loading()
        : (!initial) ? FutureBuilder(
            future: initializeDataInformation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Loading();
              } else {
                initial = true;
                return buildContent();
              }
            }) : buildContent();
  }

  Widget buildContent() {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor,
        ),
        body: (cartItemMap.isEmpty) ? const Center(child: Text("No items Here!"),) 
        : Form(
          key: formKey,
          child: ListView.builder(
              itemCount: widgetList.length,
              itemBuilder: (context, i) {
                return widgetList[i];
              }),
        ),
      ),
    );
  }

  void buildFormContent() {
    widgetList.clear();
    widgetList.add(formSection("Order Item(s)"));
    widgetList.add(orderHeader());
    for (int i = 0; i < bookList.length; i++) {
      widgetList.add(orderItem(bookList[i], i));
    }
    widgetList.add(orderItemSubTotal());
    widgetList.add(orderDeliveryTotal());
    widgetList.add(orderTotalPrice());
    widgetList.add(formSection("Customer Infomation"));
    widgetList.add(orderNameRow());
    widgetList.add(orderInfoField("Your Contact", contactController));
    widgetList.add(orderAddressField("Billing Address", bAddressController, AddressType.billing));
    widgetList.add(orderAddressField("Shipping Address", sAddressController, AddressType.shipping));
    widgetList.add(makeOrderButtonRow());

  }

  Widget formSection(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Text(title,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget orderHeader() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: const ListTile(
          leading: Text("No", style: TextStyle(fontWeight: FontWeight.bold)),
          title: Text(
            "Item(s) Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            "Price (RM)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget orderItem(Book book, int index) {
    double itemPrice = 0;
    int quantity = cartItemMap[book.ISBN_13] ?? 0;
    itemPrice = quantity * book.retailPrice;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        leading: Text("# ${++index}"),
        title: Text(book.title),
        subtitle: Text(
            "Quantity: ${quantity.toString()}\nPrice: RM ${book.retailPrice.toStringAsFixed(2)}"),
        trailing: Text(itemPrice.toStringAsFixed(2)),
      ),
    );
  }

  Widget orderItemSubTotal() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: const Text("Item(s) Subtotal"),
        trailing: Text(Manager.estimatedPrice.toStringAsFixed(2)),
      ),
    );
  }

  Widget orderDeliveryTotal() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: const Text("Postage Cost"),
        trailing: Text(calculatePostageCost().toStringAsFixed(2)),
      ),
    );
  }

  Widget orderTotalPrice() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: const Text("Total Price"),
        trailing: Text((Manager.estimatedPrice + calculatePostageCost())
            .toStringAsFixed(2)),
      ),
    );
  }

  Widget orderNameRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(child: orderInfoField("Your Name", nameController)),
          Expanded(child: orderInfoField("Recipient Name", recipientController))
        ],
      ),
    );
  }
  Widget orderInfoField(String fieldName, TextEditingController controller) {
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

  Widget orderAddressField(String fieldName, TextEditingController controller,
      AddressType addressType) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: dateInputDecoration(fieldName).copyWith(
            suffixIcon: IconButton(
                onPressed: () => addressSelector(addressType),
                icon: const Icon(Icons.list))),
        readOnly: true,
        controller: controller,
        validator: (String? val) => (val != null && val.isEmpty) ? "Select the $fieldName" : null, 
      ),
    );
  }

  Widget makeOrderButtonRow(){
    return Center(
      child: Container(
        padding: const EdgeInsets.all(2),
        width: 100,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,          
          ),
          child: const Text(
            "Pay Now",
            style: TextStyle(
              color: kPrimaryLightColor,
              ),
            ),
          onPressed: () {
            proceedToPayment();
          },
        ),
      )
    );
  }

  Future initializeDataInformation() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      userInformation = await dbService.getUserInformation(user!.uid);
      nameController.text = userInformation!.userName;
      contactController.text = userInformation!.phoneNumber ?? "";
      recipientController.text = userInformation!.userName;
      billingAddressMap = await dbService.getBillingAddress(user!.uid);
      shippingAddressMap = await dbService.getShippingAddress(user!.uid);
      cartItemMap = await dbService.getCartItems(user!.uid);
      List<String> bookISBNList =
          cartItemMap.entries.map((e) => e.key).toList();
      bookList = await dbService.getBookListByBookISBNList(bookISBNList);
      bookList.sort((a, b) => a.ISBN_13.length.compareTo(b.ISBN_13.length));
      buildFormContent();
    }
  }

  void proceedToPayment() async {
    if (formKey.currentState!.validate()){
      OrderInfo newOrder = OrderInfo(
        orderCode: "ABC", 
        buyerName: nameController.text.trim(), 
        recipientName: recipientController.text.trim(), 
        contactNumber: contactController.text.trim(),
        billingAddress: bAddressController.text, 
        shippingAddress: sAddressController.text, 
        orderItems: cartItemMap,
        orderItemPrices: Manager.estimatedPrice, 
        deliveryFee: calculatePostageCost(), 
        orderDate: DateTime.now());
        bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => MyPaymentScene(orderData: newOrder)));    
        if (result){
          Navigator.pop(context, true);
        }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all of the field!")));
    }
  }
  int calculatePostageCost() {
    int postage = 0;
    postage += (bookList.length * 3);
    for (int i = 0; i < bookList.length; i++) {
      if (cartItemMap[bookList[i].ISBN_13]! > 1) {
        postage += cartItemMap[bookList[i].ISBN_13]! - 1;
      }
    }
    return postage;
  }

  void addressSelector(AddressType addressType) {
    List<LocationAddress> addressList = (addressType == AddressType.billing)
        ? billingAddressMap.entries
            .map((e) => LocationAddress(name: e.key, address: e.value))
            .toList()
        : (addressType == AddressType.shipping)
            ? shippingAddressMap.entries
                .map((e) => LocationAddress(name: e.key, address: e.value))
                .toList()
            : [];

    showDialog(
        context: context,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, setState) {
              return (AlertDialog(
                  title: const Text("Address"),
                  content: Container(
                    width: (MediaQuery.of(context).size.width / 3) * 2,
                    height: (MediaQuery.of(context).size.height / 2),
                    padding: const EdgeInsets.all(4),
                    child: ListView.builder(
                        itemCount: addressList.length,
                        itemBuilder: (context, index) {
                          return buildAddressRow(addressList[index], (addressType == AddressType.billing) ? bAddressController : sAddressController);
                        }),
                  )));
            }));
  }

  Widget buildAddressRow(LocationAddress address, TextEditingController controller){
    return ListTile(
      title: Text(address.name),
      subtitle: Text(address.address),
      onTap: () {
        controller.text = address.address;
        Navigator.pop(context);
        setState(() {
        });
      },
    );
  }
}
