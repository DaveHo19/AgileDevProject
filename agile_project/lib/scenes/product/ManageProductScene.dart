import 'dart:typed_data';

import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/category.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/sharedProperties/boxBorder.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/utilities/field_validation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyManageProductScene extends StatefulWidget {
  MyManageProductScene({
    Key? key,
    required this.bookManagement,
    this.passedBook,
  }) : super(key: key);

  final BookManagement bookManagement;
  Book? passedBook;
  @override
  State<MyManageProductScene> createState() => _MyManageProductSceneState();
}

class _MyManageProductSceneState extends State<MyManageProductScene> {
  final _formKey = GlobalKey<FormState>();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  //condition
  bool isNewCover = false;
  bool isExistedID = false;
  bool isProcess = false;

  //text field area (book)
  Uint8List? imgSrc;
  String id = ""; //ISBN-13 No
  String name = "";
  String author = "";
  DateTime publishedDate = DateTime.now();
  List<String> category = [];
  String description = "";
  double tradePrice = 0.0;
  double retailPrice = 0.0;
  int quantity = 0;

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

  @override
  void initState() {
    super.initState();

    publishedDate = (widget.bookManagement == BookManagement.create)
        ? DateTime.now()
        : widget.passedBook!.publishedDate;
    switch (widget.bookManagement) {
      case BookManagement.create:
        initialCreateView();
        break;
      case BookManagement.edit:
        initialEditView();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isProcess
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text((widget.bookManagement == BookManagement.create)
                  ? "Book Creation"
                  : (widget.bookManagement == BookManagement.edit)
                      ? "Book Update"
                      : "Undefined Action"),
              backgroundColor: kPrimaryColor,
              foregroundColor: kPrimaryLightColor,
            ),
            body: SafeArea(
                child: Form(
              key: _formKey,
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
            )),
          );
  }

  Widget _buildSpace() {
    return const SizedBox(height: 20);
  }

//GestureDetector will capture the gesture and dispatch multiple events based on the gesture
//gestures: tap, double tap, long press.
  Widget _buildImageField() {
    return Center(
      child: Container(
        width: 300,
        height: 400,
        padding: const EdgeInsets.all(2),
        decoration: boxDecoration,
        child: GestureDetector(
          onTap: () async {
            var imgResult = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg', 'jpeg']);
            if (imgResult == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No image selected")));
            } else {
              setState(() {
                imgSrc = imgResult.files.single.bytes;
                isNewCover = true;
              });
            }
          },
          child: (imgSrc == null)
              ? Image.asset("sampleCover.png", fit: BoxFit.fill)
              : Image.memory(imgSrc!, fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget _buildIDTextField(String fieldName) {
    DatabaseService databaseService = DatabaseService();
    return TextFormField(
      controller: isbnController,
      validator: (String? val) =>
          (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => id = val);
      },
      decoration: inputDecoration(fieldName).copyWith(
          suffixIcon: IconButton(
        onPressed: () async {
          if (id.isNotEmpty) {
            isExistedID = await databaseService.checkBookExists(id);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("ISBN field is empty!")));
          }
          setState(() {});
        },
        icon: (widget.bookManagement == BookManagement.create)
            ? isExistedID
                ? Icon(Icons.sync)
                : Icon(Icons.check)
            : Icon(Icons.lock),
        color: (widget.bookManagement == BookManagement.create)
            ? isExistedID
                ? Colors.grey
                : Colors.green
            : Colors.transparent,
      )),
      readOnly: !(widget.bookManagement == BookManagement.create),
    );
  }

//all the fields can't be empty else message will be prompted
  Widget _buildTitleTextField(String fieldName) {
    return TextFormField(
      controller: titleController,
      validator: (String? val) =>
          (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => name = val);
      },
      decoration: inputDecoration(fieldName),
    );
  }

  Widget _buildAuthorTextField(String fieldName) {
    return TextFormField(
      controller: authorController,
      validator: (String? val) =>
          (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => author = val);
      },
      decoration: inputDecoration(fieldName),
    );
  }

  Widget _buildDescriptionTextField(String fieldName) {
    return TextFormField(
      controller: descController,
      validator: (String? val) =>
          (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => description = val);
      },
      decoration: inputDecoration(fieldName),
      minLines: 5,
      maxLines: 10,
    );
  }

  Widget _buildCategoryField(String fieldName) {
    return TextFormField(
      decoration: dateInputDecoration(fieldName).copyWith(
          suffixIcon: IconButton(
              onPressed: _callMultiSelectDialog, icon: const Icon(Icons.list))),
      readOnly: true,
      controller: categoryController,
      validator: (String? val) => (val != null && val.isEmpty)
          ? "Select at least one $fieldName"
          : null,
    );
  }

  Widget _buildDateField(String fieldName) {
    return TextFormField(
      decoration: dateInputDecoration(fieldName).copyWith(
          suffixIcon: IconButton(
              onPressed: _callCalendar,
              icon: const Icon(Icons.calendar_month))),
      validator: (String? val) =>
          (val != null && val.isEmpty) ? "Select a date" : null,
      controller: dateController,
    );
  }

//prices will be set to 2 dp
  Widget _buildTradePriceField(String fieldName) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("$fieldName: RM ${tradePrice.toStringAsFixed(2)}")),
          Slider(
            value: tradePrice,
            max: 100,
            min: 0,
            divisions: 10000,
            label: tradePrice.toStringAsFixed(2),
            onChanged: (val) {
              tradePrice = val;
              setState(() {
                tradePrice = val;
              });
            },
          ),
        ],
      );
    });
  }

  Widget _buildRetailPriceField(String fieldName) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("$fieldName: RM ${retailPrice.toStringAsFixed(2)}")),
          Slider(
            value: retailPrice,
            max: 100,
            min: 0,
            divisions: 10000,
            label: retailPrice.toStringAsFixed(2),
            onChanged: (val) {
              retailPrice = val;
              setState(() {
                retailPrice = val;
              });
            },
          ),
        ],
      );
    });
  }

  Widget _buildQuantity(String fieldName) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("$fieldName: $quantity")),
          Slider(
            value: quantity.toDouble(),
            max: 20,
            min: 0,
            divisions: 20,
            label: quantity.toString(),
            onChanged: (val) {
              quantity = val.toInt();
              setState(() {
                quantity = val.toInt();
              });
            },
          ),
        ],
      );
    });
  }

//validate all the fields before save into database
  Widget _buildButton() {
    DatabaseService dbService = DatabaseService();
    //For validation processes
    FieldValidation validation = FieldValidation();
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          if (validation.bookFieldValidation(category, tradePrice, retailPrice,
              quantity, imgSrc, widget.bookManagement)) {
            if (validation.dateValidation(dateController.text)) {
              switch (widget.bookManagement) {
                case BookManagement.create:
                  await createBookProcess();
                  break;
                case BookManagement.edit:
                  await editBookProcess();
                  break;
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Date input is in wrong format! Please follow [yyyy-mm-dd] format!")));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Some of the fields are in wrong value!")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("There are some field does not entered!!")));
        }
      },
      child: Text(widget.bookManagement == BookManagement.create
          ? "Create"
          : widget.bookManagement == BookManagement.edit
              ? "Edit"
              : "??"),
    );
  }

  Widget _categoryRow(String items) {
    bool added = category.contains(items);
    return StatefulBuilder(builder: (context, setState) {
      return ListTile(
        subtitle: Text(items),
        trailing: Checkbox(
          value: added,
          onChanged: (val) => setState(
            () {
              added = val ?? false;
              added ? category.add(items) : category.remove(items);
              categoryController.text = "";
              if (category.isNotEmpty) {
                for (int i = 0; i < category.length; i++) {
                  categoryController.text += category[i] + "; ";
                }
              }
            },
          ),
        ),
      );
    });
  }

//multiple selection of category
  void _callMultiSelectDialog() {
    List<String> categoryList = getCategoryList();
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, setState) {
              return (AlertDialog(
                  title: const Text("Categories"),
                  content: Container(
                    width: (MediaQuery.of(context).size.width / 3) * 2,
                    height: (MediaQuery.of(context).size.height / 2),
                    padding: const EdgeInsets.all(4),
                    child: ListView.builder(
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return _categoryRow(categoryList[index]);
                        }),
                  )));
            }));
  }

  void _callCalendar() {
    showDialog(
        context: context,
        builder: (BuildContext context) => (AlertDialog(
              title: const Text("Date"),
              content: Container(
                width: (MediaQuery.of(context).size.width / 3) * 2,
                height: (MediaQuery.of(context).size.height / 2),
                padding: const EdgeInsets.all(4),
                child: TableCalendar(
                  firstDay: DateTime.utc(1900, 01, 01),
                  lastDay: DateTime.utc(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        publishedDate = _selectedDay ?? DateTime.now();
                        dateController.text =
                            DateFormat("yyyy-MM-dd").format(publishedDate);
                        Navigator.pop(context);
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            )));
  }

//process of create new book in system with all the details and image
  Future<void> createBookProcess() async {
    DatabaseService dbService = DatabaseService();
    if (!isExistedID) {
      setState(() {
        isProcess = true;
      });
      String url = await dbService.uploadBookCover(imgSrc!, id);
      DateTime pDate = DateFormat("yyyy-MM-dd").parse(dateController.text);
      if (url.isNotEmpty) {
        Book newBook = Book(
            ISBN_13: id.trim(),
            title: name.trim(),
            author: author.trim(),
            description: description,
            publishedDate: pDate,
            imageCoverURL: url,
            tags: category,
            tradePrice: tradePrice,
            retailPrice: retailPrice,
            quantity: quantity);
        var result = await dbService.createBook(newBook);
        if (result == null) {
          setState(() {
            isProcess = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Book created successfully")));
          Navigator.pop(context);
        } else {
          setState(() {
            isProcess = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Result failed to update!")));
        }
      } else {
        setState(() {
          isProcess = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Book cover failed to upload!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please check the ISBN-No first")));
    }
  }

//process of edit book details
  Future<void> editBookProcess() async {
    DatabaseService dbService = DatabaseService();
    setState(
      () => isProcess = true,
    );
    DateTime pDate = DateFormat("yyyy-MM-dd").parse(dateController.text);
    Book updBook = Book(
        ISBN_13: widget.passedBook!.ISBN_13.trim(),
        title: name.trim(),
        author: author.trim(),
        description: description,
        publishedDate: pDate,
        imageCoverURL: widget.passedBook!.imageCoverURL,
        tags: category,
        tradePrice: tradePrice,
        retailPrice: retailPrice,
        quantity: quantity);
    var result = await dbService.updateBook(updBook);
    if (result == null) {
      setState(
        () => isProcess = false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Book update successfully")));
      Navigator.pop(context);
    } else {
      setState((() => isProcess = false));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Result failed to update")));
    }
  }

  bool dateValidation() {
    return RegExp(r"^[0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-4][0-9]")
        .hasMatch(dateController.text);
  }

  void initialCreateView() {
    dateController.text = "";
    categoryController.text = "";
    quantityController.text = "";
    isbnController.text = "";
    titleController.text = "";
    descController.text = "";
    authorController.text = "";
    tradePriceController.text = "";
    retailPriceController.text = "";

    formWidgetList.clear();
    dateController.text = DateFormat("yyyy-MM-dd").format(publishedDate);
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
    formWidgetList.add(_buildButton());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
  }

  void initialEditView() {
    dateController.text =
        DateFormat("yyyy-MM-dd").format(widget.passedBook!.publishedDate);
    quantityController.text = widget.passedBook!.quantity.toString();
    isbnController.text = widget.passedBook!.ISBN_13;
    titleController.text = widget.passedBook!.title;
    descController.text = widget.passedBook!.description ?? "";
    authorController.text = widget.passedBook!.author;
    tradePrice = widget.passedBook!.tradePrice;
    retailPrice = widget.passedBook!.retailPrice;

    id = widget.passedBook!.ISBN_13;
    name = widget.passedBook!.title;
    author = widget.passedBook!.author;
    description = widget.passedBook!.description ?? "";
    tradePrice = widget.passedBook!.tradePrice;
    retailPrice = widget.passedBook!.retailPrice;
    quantity = widget.passedBook!.quantity;

    widget.passedBook!.tags.forEach((element) {
      categoryController.text += element + "; ";
      category.add(element);
    });

    formWidgetList.clear();
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
    dateController.text = DateFormat("yyyy-MM-dd").format(publishedDate);
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
    formWidgetList.add(_buildButton());
    formWidgetList.add(_buildSpace());
    formWidgetList.add(_buildSpace());
  }
}
