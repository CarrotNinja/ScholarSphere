import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class Uploader extends StatefulWidget {
  @override
  _TranscriptUploaderState createState() => _TranscriptUploaderState();
}

class _TranscriptUploaderState extends State<Uploader> {
  String _status = "Upload a transcript";
  List<String> _courses = [];
  List<String> _grades = [];
  File? _pickedFile;

  Future<void> _uploadTranscript() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _pickedFile = file;
        _status = "Processing transcript...";
      });

      String extractedText = await _extractTextFromPdf(file);
      _processExtractedText(extractedText);

      setState(() {
        _status = "Transcript uploaded successfully";
      });
    } else {
      setState(() {
        _status = "Failed to upload transcript";
      });
    }
  }

  Future<String> _extractTextFromPdf(File file) async {
    // Extract text using Tesseract OCR
    String extractedText = await FlutterTesseractOcr.extractText(file.path);
    return extractedText;
  }

  void _processExtractedText(String text) {
    // Simulate text processing
    // In a real-world scenario, you would parse the text to find courses and grades
    setState(() {
      // This is mock data for demonstration. Replace with actual parsing logic.
      _courses = ["Course 1", "Course 2", "Course 3"];
      _grades = ["A", "B+", "A-"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transcript Uploader"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _status,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadTranscript,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text("Upload Transcript"),
            ),
            SizedBox(height: 20),
            _pickedFile != null
                ? Text(
                    'Selected File: ${_pickedFile!.path}',
                    style: TextStyle(color: Colors.white),
                  )
                : Container(),
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        _courses[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _grades[index],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
