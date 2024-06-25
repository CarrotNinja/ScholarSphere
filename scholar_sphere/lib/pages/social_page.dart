import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:scholar_sphere/backend/auth.dart';
import 'package:scholar_sphere/backend/paragraph_pdf_api.dart';
import 'package:scholar_sphere/backend/read_data/get_user_name.dart';
import 'package:scholar_sphere/backend/save_and_open_pdf.dart';
import 'package:scholar_sphere/backend/simple_pdf_api.dart';
import 'package:scholar_sphere/util/profile_picture.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  final User? user = Auth().currentUser;
  String docID = "";
  var now = DateTime.now();
  var formatter = DateFormat.yMMMMd('en_US');
  String? formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = formatter.format(now);
    fetchDocID();
  }

  Future<void> fetchDocID() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          setState(() {
            docID = snapshot.docs[0].id;
          });
        } else {
          setState(() {
            docID = '';
          });
        }
      }).catchError((error) {
        print('Error fetching docID: $error');
        setState(() {
          docID = '';
        });
      });
    }
  }

  Future<String> fetchPortfolioData() async {
    String userId = docID;
    StringBuffer portfolioData = StringBuffer();
    portfolioData.write("Check Out My Scholar Sphere Portfolio!\n");
    // Fetch transcripts
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transcripts')
        .get()
        .then((querySnapshot) {
      portfolioData.writeln('Semester Report Cards:');
      for (var doc in querySnapshot.docs) {
        List<String> grades = List<String>.from(doc['grades']);
        portfolioData.writeln('\n ${doc['fileName']}: ${grades.join('\n')}');
      }
    });
    portfolioData.writeln('\n');
    // Fetch awards
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('awards')
        .get()
        .then((querySnapshot) {
      portfolioData.writeln('Awards:');
      for (var doc in querySnapshot.docs) {
        portfolioData.writeln(' - ${doc['task']}');
      }
    });
    portfolioData.writeln('\n');
    // Fetch extracurriculars (Ecs)
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Ecs')
        .get()
        .then((querySnapshot) {
      portfolioData.writeln('Extracurriculars:');
      for (var doc in querySnapshot.docs) {
        portfolioData.writeln(' - ${doc['task']}');
      }
    });
    portfolioData.writeln('\n');
    // Fetch clubs
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Clubs')
        .get()
        .then((querySnapshot) {
      portfolioData.writeln('Clubs:');
      for (var doc in querySnapshot.docs) {
        portfolioData.writeln(' - ${doc['task']}');
      }
    });
    portfolioData.writeln('\n');
    // Fetch others
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Others')
        .get()
        .then((querySnapshot) {
      portfolioData.writeln('Other:');
      for (var doc in querySnapshot.docs) {
        portfolioData.writeln(' - ${doc['task']}');
      }
    });
    portfolioData.writeln('\n');

    return portfolioData.toString();
  }



  void sharePortfolio() async {
    String portfolioData = await fetchPortfolioData();
    await Share.share(portfolioData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff56018D),
              Colors.pink,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Greetings row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Hi name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ProfilePicture(userId: docID),
                              ],
                            ),
                            FutureBuilder<String>(
                              future: GetUserName(documentId: docID)
                                  .getUserName(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading...',
                                      style: TextStyle(color: Colors.white));
                                } else if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Text('Error',
                                      style: TextStyle(color: Colors.white));
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  String userName = snapshot.data!;
                                  return Text(
                                    "Hi $userName!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return Text('Username not available',
                                      style: TextStyle(color: Colors.white));
                                }
                              },
                            ),
                          ],
                        ),
                        // Notifications
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Text(
                              formattedDate!,
                              style: TextStyle(
                                  color: Colors.blue[200], fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'Search',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  child: Container(
                    padding: EdgeInsets.all(25),
                    color: Colors.grey[300],
                    child: Center(
                      child: Column(
                        children: [
                          // Heading
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Social Page',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(Icons.more_horiz),
                            ],
                          ),
                          SizedBox(height: 25),
                          // Content
                          Expanded(
                            child: ListView(
                              children: [
                                TextButton(
                                  onPressed: () async{
                                    final paragraphPdf = await ParagraphPdfApi.generateParagraphPdf(docID);
                                    SaveAndOpenDocument.openPdf(paragraphPdf);
                                  },
                                  child: Text('Generate PDF'),
                                ),
                                TextButton(
                                  onPressed: sharePortfolio,
                                  child: Text('Share Portfolio'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
