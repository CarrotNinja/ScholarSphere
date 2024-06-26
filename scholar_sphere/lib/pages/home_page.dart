import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholar_sphere/backend/read_data/get_user_name.dart';
import 'package:scholar_sphere/pages/academics_page.dart';
import 'package:scholar_sphere/pages/awards_page.dart';
import 'package:scholar_sphere/pages/clubs_page.dart';
import 'package:scholar_sphere/pages/ec_page.dart';
import 'package:scholar_sphere/pages/other_page.dart';
import 'package:scholar_sphere/util/ec_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_sphere/backend/auth.dart';
import 'package:scholar_sphere/util/gradient_service.dart';
import 'package:scholar_sphere/util/profile_picture.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;
  final User? user = Auth().currentUser;
  var now = DateTime.now();
  var formatter = DateFormat.yMMMMd('en_US');
  String? formattedDate;
  String docID = "6cHwPquSMMkpue7r6RRN";

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

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUID() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("Sign Out"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LinearGradient>(
        stream: GradientService(userId:docID ?? '').getGradientStream(),
        builder: (context, snapshot) {
          final gradient = snapshot.data ??
              LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff56018D),
                  Colors.pink,
                ],
              );
          return Container(
            decoration: BoxDecoration(gradient: gradient),
            child: SafeArea(
              child: Column(
                children: [
                  //greetings row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Hi name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ProfilePicture(userId: docID,)
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
                                      print(snapshot.error.toString());
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
                                )
                              ],
                            ),
                            //Noti
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12)),
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

                        //search bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(children: [
                            Icon(Icons.search, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              'Search',
                              style: TextStyle(color: Colors.black),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                      child: Container(
                        padding: EdgeInsets.all(25),
                        color: Colors.grey[300],
                        child: Center(
                          child: Column(
                            children: [
                              //heading
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Your Portfolio',
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
                              //listview
                              Expanded(
                                child: ListView(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AcademicsPage(userId: docID,)));
                                      },
                                      child: EcTile(
                                        icon: Icons.lightbulb,
                                        EcName: 'Academics',
                                        color: Colors.orange,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AwardsPage(userId: docID,)));
                                      },
                                      child: EcTile(
                                        icon: Icons.emoji_events,
                                        EcName: 'Awards',
                                        color: Colors.blue,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClubsPage(userId: docID,)));
                                      },
                                      child: EcTile(
                                      icon: Icons.groups,
                                      EcName: 'Clubs',
                                      color: Colors.pink,
                                    ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EcsPage(userId: docID,)));
                                      },
                                      child: EcTile(
                                      icon: Icons.assignment,
                                      EcName: 'Extracurricular',
                                      color: Colors.green,
                                    ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OthersPage(userId: docID,)));
                                      },
                                      child: EcTile(
                                      icon: Icons.more_horiz,
                                      EcName: 'Other',
                                      color: Colors.purple,
                                    ),
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
          );
        },
      ),
    );
  }
}
