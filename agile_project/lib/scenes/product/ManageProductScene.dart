import 'dart:html';
import 'dart:typed_data';

import 'package:agile_project/models/category.dart';
import 'package:agile_project/scenes/sharedProperties/boxBorder.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyManageProductScene extends StatefulWidget{
  const MyManageProductScene({Key? key}) : super (key: key);

  @override
  State<MyManageProductScene> createState() => _MyManageProductSceneState();
}

class _MyManageProductSceneState extends State<MyManageProductScene>{

  final _formKey = GlobalKey<FormState>();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  List<Widget> formWidgetList = [];
  @override
  void initState() {
    super.initState();
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
    formWidgetList.add(_buildButton());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Manage Product"),
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
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
                    child: formWidgetList[i],
                  );
                }),
            )
          ),
        );
  }

  Widget _buildSpace(){
    return const SizedBox(height: 20);
  }

  Widget _buildImageField(){
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
              allowedExtensions: ['png', 'jpg', 'jpeg']
            );
            if(imgResult == null){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No image selected")));
            } else {
              setState(() => imgSrc = imgResult.files.single.bytes);
            }
          },
          child: (imgSrc == null) ? Image.asset("sampleCover.png", fit: BoxFit.fill) 
                                  : Image.memory(imgSrc!, fit: BoxFit.fill),
          ),
        ),
      );
  }

  Widget _buildIDTextField(String fieldName){
    return TextFormField(
      validator: (String? val) => (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => id = val);
      },
      decoration: inputDecoration(fieldName),
    );
  }
  Widget _buildTitleTextField(String fieldName){
    return TextFormField(
      validator: (String? val) => (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => name = val);
      },
      decoration: inputDecoration(fieldName),
    );
  }
    Widget _buildAuthorTextField(String fieldName){
    return TextFormField(
      validator: (String? val) => (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => author = val);
      },
      decoration: inputDecoration(fieldName),
    );
  }
    Widget _buildDescriptionTextField(String fieldName){
    return TextFormField(
      validator: (String? val) => (val != null && val.isEmpty) ? "Enter the $fieldName" : null,
      onChanged: (val) {
        setState(() => description = val);
      },
      decoration: inputDecoration(fieldName),
      minLines: 5,
      maxLines: 10,
    );
  }

  Widget _buildCategoryField(String fieldName){
    return TextFormField(
      decoration: dateInputDecoration(fieldName).copyWith(
        suffixIcon: IconButton(
          onPressed: _callMultiSelectDialog, 
          icon: const Icon(Icons.list))),
        readOnly: true,
        controller: categoryController,
    );
  }
  Widget _buildDateField(String fieldName){
    return TextFormField(
      decoration: dateInputDecoration(fieldName).copyWith(
        suffixIcon: IconButton(
          onPressed: _callCalendar, 
          icon: const Icon(Icons.calendar_month))),
      readOnly: true,
      controller: dateController,
      
    );
  }

  Widget _buildTradePriceField(String fieldName){
    return Slider(
      value: tradePrice, 
      max: 100,
      min: 0,
      divisions: 10,
      label: tradePrice.roundToDouble().toString(),
      onChanged: (val){
        setState(() {
          tradePrice = val;
        });
      }
      ,);
  }

  Widget _buildButton(){
    return Center(
      child: ElevatedButton(
        onPressed: () {
          print(id);
          print(name);
          print(author);
          print(description);
          print(tradePrice);
        },
        child: const Text("Debug"),
      )
    );
  }
  Widget _categoryRow(String items){
    bool added = category.contains(items);
    return StatefulBuilder(
      builder: (context, setState) {
        return ListTile(
          subtitle: Text(items),
          trailing: Checkbox(
            value: added,
            onChanged: (val) => setState(() {
              added = val??false;
              added ? category.add(items) : category.remove(items);
              categoryController.text = "";
              if(category.isNotEmpty){
                category.forEach((element) {
                  categoryController.text += element + "; ";
                });
              }
            },
          ),
            ),);
      }
    );
  }
  
  void _callMultiSelectDialog(){
    List<String> categoryList = getCategoryList();
    showDialog(context: context, builder: (BuildContext context) => 
    StatefulBuilder(
      builder: (context, setState) {
        return ( 
          AlertDialog(
            title: const Text("Categories"),
            content: Container(
                width: (MediaQuery.of(context).size.width / 3 ) * 2,
                height: (MediaQuery.of(context).size.height / 2),
                padding: const EdgeInsets.all(4),
                child: ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return _categoryRow(categoryList[index]);   
                  }),
          )));
      }
    ));
    
  }

  void _callCalendar(){
    showDialog(
      context: context,
      builder: (BuildContext context) => (
        AlertDialog(
          title: const Text("Date"),
          content: Container(
            width: (MediaQuery.of(context).size.width / 3 ) * 2,
            height: (MediaQuery.of(context).size.height / 2),
            padding: const EdgeInsets.all(4),
            child: TableCalendar(
              firstDay: DateTime.utc(1900, 01, 01),
              lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay){
                if(!isSameDay(_selectedDay, selectedDay)){
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    publishedDate = _selectedDay??DateTime.now();
                    dateController.text = DateFormat("yyyy-MM-dd").format(publishedDate);
                    Navigator.pop(context);
                  });
                }
              },
              onPageChanged: (focusedDay){
                _focusedDay = focusedDay;
              },
            ),
            ),
          )
        )
      );
  }
}
