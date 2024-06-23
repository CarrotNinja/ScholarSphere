import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class AcademicsPage extends StatefulWidget {
  final String userId; // Add userId as a parameter

  AcademicsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  final List<Map<String, dynamic>> _transcripts = [];
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // Call a method to fetch transcripts from Firestore when the page loads
    _fetchTranscripts();
  }

  void _fetchTranscripts() {
    // Fetch transcripts from Firebase Storage or Firestore (not implemented here)
  }

  Future<void> _pickTranscript() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _transcripts.add({
          'file': File(pickedFile.path),
          'text': '',
        });
      });
      await _uploadTranscript(File(pickedFile.path));
      await _extractText(File(pickedFile.path));
    }
  }

  Future<void> _uploadTranscript(File file) async {
    try {
      String fileName = 'transcripts/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(file);

      await uploadTask.whenComplete(() => null);
      String fileURL = await storageRef.getDownloadURL();

      print('File uploaded to Firebase Storage: $fileURL');
    } catch (e) {
      print('Error uploading transcript: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload transcript')));
    }
  }

  Future<void> _extractText(File file) async {
    final inputImage = InputImage.fromFile(file);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textDetector.processImage(inputImage);

    setState(() {
      _transcripts.last['text'] = recognizedText.text;
    });

    print('Extracted text: ${recognizedText.text}');
  }

  void _removeTranscript(int index) {
    setState(() {
      _transcripts.removeAt(index);
    });
    // Remove from Firebase Storage or Firestore if needed
  }

  Widget _buildList() {
    return _transcripts.isEmpty
        ? Center(
            child: Text(
              'No transcripts yet. Upload a transcript!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          )
        : ListView.builder(
            itemCount: _transcripts.length,
            itemBuilder: (context, index) {
              return _buildItem(_transcripts[index], index);
            },
          );
  }

  Widget _buildItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['file'].path),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeTranscript(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transcript deleted')),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(
            item['file'].path.split('/').last,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(item['text']),
        ),
      ),
    );
  }

  void _promptAddItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Transcript'),
          content: Text('Upload a new transcript to add it to your academic records.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Upload'),
              onPressed: () {
                Navigator.of(context).pop();
                _pickTranscript();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Academics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.3, 0.6, 0.9],
            colors: [
              Color(0xff56018D),
              Color(0xff8B139C),
              Colors.pink,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddItem,
        tooltip: 'Upload transcript',
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}
