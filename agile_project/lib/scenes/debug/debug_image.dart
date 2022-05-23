
import 'dart:typed_data';

import 'package:agile_project/services/databaseService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DebugImage extends StatefulWidget {
  const DebugImage({ Key? key }) : super(key: key);

  @override
  State<DebugImage> createState() => _DebugImageState();
}

class _DebugImageState extends State<DebugImage> {

  final DatabaseService dbService = DatabaseService();
  Uint8List? imgSrc;
  String? imgName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Debug-Image"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: const Text("Select Image"),
                onPressed: () async {
                  final imgResult = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'jpeg']
                  );
                  if(imgResult == null){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not selected")));
                  } else {
                    setState(() {
                      imgSrc = imgResult.files.single.bytes!;
                      imgName = imgResult.files.single.name;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 300,
                child: (imgSrc == null) ? 
                  Image.asset(
                    "sampleCover.png", 
                    fit: BoxFit.fill,) 
                  : Image.memory(
                    imgSrc!,
                    fit: BoxFit.fill,), 
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text("Upload"),
                onPressed: () async {
                  if (imgSrc != null){
                    String url = await dbService.uploadBookCover(imgSrc!, "SampleID");
                    print(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an image first")));
                  }
                  
                },
              ),
            ),
          ],  
        ),
      )
    );
  }
}