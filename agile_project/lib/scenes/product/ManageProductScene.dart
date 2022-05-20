import 'dart:html';
import 'dart:typed_data';

import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/category.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/sharedProperties/boxBorder.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyManageProductScene extends StatefulWidget {
  MyManageProductScene({
    Key? key,
    required this.bookManagement,
  }) : super(key: key);

  final BookManagement bookManagement;
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

  List<Widget> formWidgetList = [];
  @override
  void initState() {
    super.initState();

    switch (widget.bookManagement) {
      case BookManagement.create:
        initialCreateView();
        break;
      case BookManagement.edit:
        break;
      case BookManagement.delete:
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
                      : (widget.bookManagement == BookManagement.delete)
                          ? "Book Deletion"
                          : "Undefined Action"),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
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
              imgSrc = imgResult.files.single.bytes;
              isNewCover = true;
              setState(() {});
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
          setState(() {
            initialCreateView();
          });
        },
        icon: isExistedID ? Icon(Icons.sync) : Icon(Icons.check),
        color: isExistedID ? Colors.grey : Colors.green,
      )),
    );
  }

  Widget _buildTitleTextField(String fieldName) {
    return TextFormField(
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
      readOnly: true,
      controller: dateController,
    );
  }

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

  Widget _buildButton() {
    DatabaseService dbService = DatabaseService();
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          if (validation()) {
            switch (widget.bookManagement) {
              case BookManagement.create:
                if (!isExistedID) {
                  setState(() {
                    isProcess = true;
                  });
                  String url = await dbService.uploadBookCover(imgSrc!, id);
                  if (url.isNotEmpty) {
                    Book newBook = Book(
                        ISBN_13: id,
                        title: name,
                        author: author,
                        publishedDate: publishedDate,
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Book created successfully")));
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        isProcess = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Result failed to update!")));
                    }
                  } else {
                    setState(() {
                      isProcess = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Book cover failed to upload!")));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please check the ISBN-No first")));
                }
                break;
              case BookManagement.edit:
                break;
              case BookManagement.delete:
                break;
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("The value field cannot less than 1!!")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("There are some field does not entered!!")));
        }
      },
      child: const Text("Debug"),
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
                category.forEach((element) {
                  categoryController.text += element + "; ";
                });
              }
            },
          ),
        ),
      );
    });
  }

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

  bool validation() {
    return ((category.isNotEmpty) &&
        (tradePrice > 0) &&
        (retailPrice > 0) &&
        (quantity > 0) &&
        (imgSrc != null));
  }

  void initialCreateView() {
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
}
