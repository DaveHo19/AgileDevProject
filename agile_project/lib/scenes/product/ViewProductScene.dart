import 'dart:convert';

import 'package:agile_project/models/book.dart';
import 'package:agile_project/scenes/cart/CartProvider.dart';
import 'package:agile_project/scenes/cart/CartScene.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/sharedProperties/boxBorder.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cart/CartProvider.dart';
import 'package:badges/badges.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agile_project/models/cart.dart';

class MyViewProductScene extends StatefulWidget {
  const MyViewProductScene({
    Key? key,
    required this.book,
    required this.viewManagement,
  }) : super(key: key);

  final Book book;
  final ViewManagement viewManagement;
  @override
  State<MyViewProductScene> createState() => _MyViewProductSceneState();
}

class _MyViewProductSceneState extends State<MyViewProductScene> {
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController tradePriceController = TextEditingController();
  TextEditingController retailPriceController = TextEditingController();

  List<Widget> formWidgetList = [];
  late Box<Cart> cartBox;

  @override
  void initState() {
    super.initState();
    initialController();
    switch (widget.viewManagement) {
      case ViewManagement.private:
        initialPrivateView();
        break;
      case ViewManagement.public:
        initialPublicView();
        break;
    }
    cartBox = Hive.box("cart_items");
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isbnController.text),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: (widget.viewManagement == ViewManagement.public)
            ? [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Badge(
                      badgeContent: Consumer<CartProvider>(
                        builder: (context, value, child) {
                          return Text(value.getCounter().toString(),
                              style: TextStyle(color: Colors.white));
                        },
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyCartScene()))
                        },
                      ),
                    ),
                  ),
                ),
              ]
            : [
                PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ];
                    },
                    onSelected: (int i) => {
                          menuItemHandler(context, i),
                        })
              ],
      ),
      body: SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: formWidgetList.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10),
                child: formWidgetList[i],
              );
            }),
      ),
      floatingActionButton: (widget.viewManagement == ViewManagement.private)
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              onPressed: () {
                _addToCart(cart);
              }),
    );
  }

  void menuItemHandler(BuildContext context, int index) {
    switch (index) {
      case 0:
        //for edit
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("This features in implement in future!")));
        break;
      case 1:
        //for delete
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("This features in implement in future!")));
        break;
    }
  }

  void _addToCart(cart) {
    Cart cartObject = Cart(
        ISBN_13: widget.book.ISBN_13,
        title: widget.book.title,
        imageCoverURL: widget.book.imageCoverURL,
        retailPrice: widget.book.retailPrice,
        quantity: widget.book.quantity,
        cartQuantity: 1);

    if (cartBox.containsKey(cartObject.ISBN_13)) {
      int cartQuantity = cartBox.get(cartObject.ISBN_13)!.cartQuantity + 1;
      if (cartQuantity <= widget.book.quantity) {
        cart.addItem(
            widget.book.ISBN_13,
            widget.book.title,
            widget.book.imageCoverURL,
            widget.book.retailPrice,
            widget.book.quantity,
            1);

        Cart tempObject = Cart(
            ISBN_13: widget.book.ISBN_13,
            title: widget.book.title,
            imageCoverURL: widget.book.imageCoverURL,
            retailPrice: widget.book.retailPrice,
            quantity: widget.book.quantity,
            cartQuantity: cartQuantity);

        cartBox.put(cartObject.ISBN_13, tempObject);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Book Added into Cart!"),
          duration: const Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Fail to Add Book into Cart due to reaching maximum quantity in the stock!"),
          duration: const Duration(seconds: 2),
        ));
      }
    } else {
      cart.addItem(
          widget.book.ISBN_13,
          widget.book.title,
          widget.book.imageCoverURL,
          widget.book.retailPrice,
          widget.book.quantity,
          1);
      cartBox.put(cartObject.ISBN_13, cartObject);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Book Added into Cart!")));
    }
  }

  Widget _buildSpace() {
    return const SizedBox(height: 20);
  }

  Widget _buildImageField() {
    return Center(
      child: Container(
          width: 300,
          height: 400,
          padding: const EdgeInsets.all(2),
          decoration: boxDecoration,
          child: Image.network(widget.book.imageCoverURL, fit: BoxFit.fill)),
    );
  }

  Widget _buildIDTextField(String fieldName) {
    isbnController.text = widget.book.ISBN_13;
    return TextFormField(
      controller: isbnController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildTitleTextField(String fieldName) {
    titleController.text = widget.book.title;
    return TextFormField(
      controller: titleController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildAuthorTextField(String fieldName) {
    authorController.text = widget.book.author;
    return TextFormField(
      controller: authorController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildDescriptionTextField(String fieldName) {
    descController.text = widget.book.description!;
    return TextFormField(
      controller: descController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
      minLines: 5,
      maxLines: 10,
    );
  }

  Widget _buildCategoryField(String fieldName) {
    categoryController.text = widget.book.tags.toString();
    return TextFormField(
      decoration: dateInputDecoration(fieldName),
      readOnly: true,
      controller: categoryController,
    );
  }

  Widget _buildDateField(String fieldName) {
    dateController.text =
        DateFormat('yyyy-MM-dd').format(widget.book.publishedDate);
    return TextFormField(
      decoration: dateInputDecoration(fieldName),
      readOnly: true,
      controller: dateController,
    );
  }

  Widget _buildTradePriceField(String fieldName) {
    double tradePrice = widget.book.tradePrice.toDouble();
    return TextFormField(
      controller: tradePriceController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildRetailPriceField(String fieldName) {
    double retailPrice = widget.book.retailPrice.toDouble();
    return TextFormField(
      controller: retailPriceController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildQuantity(String fieldName) {
    int quantity = widget.book.quantity.toInt();
    return TextFormField(
      controller: quantityController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  void initialController() {
    isbnController.text = widget.book.ISBN_13;
    titleController.text = widget.book.title;
    authorController.text = widget.book.author;
    descController.text = widget.book.description ?? "";
    dateController.text =
        DateFormat('yyyy-MM-dd').format(widget.book.publishedDate);
    tradePriceController.text = widget.book.tradePrice.toStringAsFixed(2);
    retailPriceController.text = widget.book.retailPrice.toStringAsFixed(2);
    quantityController.text = widget.book.quantity.toString();
    widget.book.tags.forEach((element) {
      categoryController.text += element + "; ";
    });
  }

  void initialPrivateView() {
    formWidgetList.clear();
    formWidgetList.add(_buildImageField());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildIDTextField("ISBN-13 No"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildTitleTextField("Book Name"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildAuthorTextField("Book Author"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildCategoryField("Book Category"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildDescriptionTextField("Book Description"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildDateField("Published Date"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildTradePriceField("Trade Price"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildRetailPriceField("Retail Price"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildQuantity("Book Quantity"));
    formWidgetList.add(_buildSpace());
    // formWidgetList.add(_buildButton());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
  }

  void initialPublicView() {
    formWidgetList.clear();
    formWidgetList.add(_buildImageField());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildIDTextField("ISBN-13 No"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildTitleTextField("Book Name"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildAuthorTextField("Book Author"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildCategoryField("Book Category"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildDescriptionTextField("Book Description"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildDateField("Published Date"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildRetailPriceField("Retail Price"));
    formWidgetList.add(_buildSpace());
    // formWidgetList.add(_buildButton());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
  }
}
