import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scholar_sphere/backend/auth.dart';
import 'package:scholar_sphere/backend/read_data/get_user_name.dart';
import 'package:scholar_sphere/util/profile_picture.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  int myIndex = 1; // Assuming this page is the second tab
   final User? user = Auth().currentUser;

  String docID = "";

  @override
  void initState() {
    super.initState();
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
                              '8 June, 2024',
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
                          SizedBox(
                            height: 20,
                          ),
                          // Placeholder for social features
                          Expanded(
                            child: Center(
                              child: Text(
                                'Social features will be here',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
