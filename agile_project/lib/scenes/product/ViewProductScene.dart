import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/cartItem.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/product/CartScene.dart';
import 'package:agile_project/scenes/product/ManageProductScene.dart';
import 'package:agile_project/scenes/sharedProperties/boxBorder.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/services/manager.dart';
import 'package:agile_project/utilities/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  List<Widget> formWidgetList = <Widget>[];
  List<String> userWishlist = <String>[];
  Map<String, int> cartItemMap = {};
  AppUser? user;

  bool isProcess = false;
  bool priceChanges = false;

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
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, priceChanges);
        return Future.value(priceChanges);
      },
      child: isProcess
          ? const Loading()
          : FutureBuilder(
              future: initialDataInformation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Loading();
                } else {
                  return _buildContent();
                }
              }),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(isbnController.text),
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
        actions: (widget.viewManagement == ViewManagement.public)
            ? [
                (user != null)
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          bool result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyCartScene()));
                          if (result) {
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: Text(Manager.estimatedPrice.toStringAsFixed(2)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent))
                    : Container(),
                (user != null)
                    ? IconButton(
                        onPressed: () async {
                          manageWishlist();
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red))
                    : Container(),
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
      floatingActionButton: (widget.viewManagement == ViewManagement.private ||
              user == null ||
              widget.book.quantity == 0)
          ? null
          : FloatingActionButton(
              backgroundColor: kPrimaryColor,
              child: const Icon(
                Icons.shopping_bag,
                color: kPrimaryLightColor,
              ),
              onPressed: () {
                manageCart();
              }),
    );
  }

  void menuItemHandler(BuildContext context, int index) async {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyManageProductScene(
                    bookManagement: BookManagement.edit,
                    passedBook: widget.book)));
        break;
      case 1:
        CustomDialog customDialog = CustomDialog();
        bool result = await customDialog.confirm_dialog(context, "Confirmation",
            "Are you sure to delete ${widget.book.title}? This action cannot undo!");
        if (result) {
          await deleteBookProcess();
        }
        break;
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
    return TextFormField(
      controller: tradePriceController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildRetailPriceField(String fieldName) {
    return TextFormField(
      controller: retailPriceController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  Widget _buildQuantity(String fieldName) {
    return TextFormField(
      controller: quantityController,
      decoration: inputDecoration(fieldName),
      readOnly: true,
    );
  }

  void manageWishlist() async {
    DatabaseService dbService = DatabaseService();
    bool add = true;

    if (user != null) {
      setState(() {
        isProcess = true;
      });
      if (userWishlist.contains(widget.book.ISBN_13)) {
        userWishlist.remove(widget.book.ISBN_13);
        add = false;
      } else {
        userWishlist.add(widget.book.ISBN_13);
        add = true;
      }
      dynamic result = dbService.updateUserWishlist(user!.uid, userWishlist);
      if (result != null) {
        setState(() {
          isProcess = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: add
                ? const Text("Book Added To Wishlist!")
                : const Text("Book Removed From Wishlist!")));
      } else {
        setState(() {
          isProcess = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to perform this actions!")));
      }
    }
  }

  void manageCart() async {
    DatabaseService dbService = DatabaseService();
    bool add = true;
    bool reachLimit = false;
    if (user != null) {
      setState(() {
        isProcess = true;
      });
      if (cartItemMap.keys.contains(widget.book.ISBN_13)) {
        if (cartItemMap[widget.book.ISBN_13]! < widget.book.quantity) {
          int quantity = cartItemMap[widget.book.ISBN_13]!;
          quantity++;
          cartItemMap[widget.book.ISBN_13] = quantity;
          add = false;
        } else {
          reachLimit = true;
        }
      } else {
        cartItemMap[widget.book.ISBN_13] = 1;
        add = true;
      }
      if (!reachLimit) {
        dynamic result = dbService.updateUserCartItems(user!.uid, cartItemMap);
        setState(() {
          isProcess = false;
        });
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: add
                  ? const Text("Book Added To Cart!")
                  : const Text("Book Quantity in Cart Increased!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to perform this actions!")));
        }
      } else {
        isProcess = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "The quantity of this product is reach the stock limit in your cart!!")));
      }
    }
  }

  Future<void> deleteBookProcess() async {
    //for delete
    setState(() {
      isProcess = true;
    });
    DatabaseService dbService = DatabaseService();
    var result = await dbService.deleteBook(widget.book.ISBN_13);
    if (result == null) {
      setState(() {
        isProcess = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Book is successfully deleted")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to delete book")));
    }
  }

  Future getEstimatePrice() async {
    Manager.estimatedPrice = 0;
    DatabaseService dbService = DatabaseService();
    if (cartItemMap.isNotEmpty && user != null) {
      List<CartItem> cartItemList = [];
      cartItemList = cartItemMap.entries
          .map((e) => CartItem(bookID: e.key, quantity: e.value))
          .toList();
      for (int i = 0; i < cartItemList.length; i++) {
        Book tempBook = await dbService.getBookByISBN(cartItemList[i].bookID);
        double priceForBook = tempBook.retailPrice * cartItemList[i].quantity;
        Manager.estimatedPrice += priceForBook;
        priceChanges = true;
      }
    }
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
    for (int i = 0; i < widget.book.tags.length; i++) {
      categoryController.text += widget.book.tags[i] + "; ";
    }
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
    formWidgetList.add(_buildQuantity("Available In Stock"));
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
  }

  Future initialDataInformation() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      userWishlist = await dbService.getUserWishlist(user!.uid);
      cartItemMap = await dbService.getCartItems(user!.uid);
      await getEstimatePrice();
    }
  }
}
