import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/order.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import "package:flutter/material.dart";

class MyViewOrderDetails extends StatefulWidget {
  const MyViewOrderDetails({
    Key? key,
    required this.orderInfoData,
  }) : super(key: key);

  final OrderInfo orderInfoData;
  @override
  State<MyViewOrderDetails> createState() => _MyViewOrderDetailsState();
}

class _MyViewOrderDetailsState extends State<MyViewOrderDetails> {
  List<Widget> widgetList = [];
  List<Book> bookList = [];
  Map<String, int> cartItemMap = {};
  Map<String, String> billingAddressMap = {};
  Map<String, String> shippingAddressMap = {};
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController bAddressController = TextEditingController();
  TextEditingController sAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeDataInformation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          } else {
            return buildContent();
          }
        });
  }

  Widget buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Info"),
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      body: ListView.builder(
          itemCount: widgetList.length,
          itemBuilder: (context, i) {
            return widgetList[i];
          }),
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
    widgetList.add(orderInfoField("Billing Address", bAddressController));
    widgetList.add(orderInfoField("Shipping Address", sAddressController));
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

//shows order item price and quantity
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
        trailing: Text(widget.orderInfoData.orderItemPrices.toStringAsFixed(2)),
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
        trailing: Text(widget.orderInfoData.deliveryFee.toStringAsFixed(2)),
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
        trailing: Text((widget.orderInfoData.orderItemPrices +
                widget.orderInfoData.deliveryFee)
            .toStringAsFixed(2)),
      ),
    );
  }

  Widget orderNameRow() {
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
        decoration: inputDecoration(fieldName),
        readOnly: true,
      ),
    );
  }

  Future initializeDataInformation() async {
    DatabaseService dbService = DatabaseService();

    nameController.text = widget.orderInfoData.buyerName;
    recipientController.text = widget.orderInfoData.recipientName;
    bAddressController.text = widget.orderInfoData.billingAddress;
    sAddressController.text = widget.orderInfoData.shippingAddress;
    cartItemMap = widget.orderInfoData.orderItems;
    List<String> bookISBNList = cartItemMap.entries.map((e) => e.key).toList();
    bookList = await dbService.getBookListByBookISBNList(bookISBNList);
    bookList.sort((a, b) => a.ISBN_13.length.compareTo(b.ISBN_13.length));
    buildFormContent();
  }
}
