import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scholar_sphere/backend/read_data/get_user_name.dart';
import 'package:scholar_sphere/pages/awards_page.dart';
import 'package:scholar_sphere/util/ec_tile.dart';
import 'package:scholar_sphere/util/emotion_face.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_sphere/backend/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;
  final User? user = Auth().currentUser;

  String docID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDocID();
  }

  Future<void> fetchDocID() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Fetch docID based on user's email or any other criteria
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          // Assuming you expect only one document
          setState(() {
            docID = snapshot.docs[0].id;
          });
        } else {
          setState(() {
            // Handle case where no document is found
            docID = ''; // or set it to some default value
          });
        }
      }).catchError((error) {
        print('Error fetching docID: $error');
        setState(() {
          docID = ''; // Handle error case
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
        //backgroundColor: Colors.blue[800],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.all(16),
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.group,
                  text: "Social",
                ),
                GButton(
                  icon: Icons.settings,
                  text: "Settings",
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color(0xff56018D),
                Colors.pink,
              ])),
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
                                  CircleAvatar(
                                    radius: 48,
                                    backgroundImage: NetworkImage(
                                        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AWindows_10_Default_Profile_Picture.svg&psig=AOvVaw3hdK3rOp2uuBaVKQSq4g9w&ust=1718686961239000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLiQ34Du4YYDFQAAAAAdAAAAABBw'),
                                  )
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
                                    return Text('Error: ${snapshot.error}',
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
                                    // Handle case where data is not available
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

                      //How do you feel?
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "How do you feel?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      //faces
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              EmotionFace(emoticanFace: '🤕'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Bad',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              EmotionFace(emoticanFace: '😐'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Fine',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              EmotionFace(emoticanFace: '😀'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Well',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              EmotionFace(emoticanFace: '🥳'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Excellent',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _userUID(),
                          _signOutButton(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
                                  EcTile(
                                    icon: Icons.lightbulb,
                                    EcName: 'Academics',
                                    color: Colors.orange,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AwardsPage()));
                                    },
                                    child: EcTile(
                                      icon: Icons.emoji_events,
                                      EcName: 'Awards',
                                      color: Colors.blue,
                                    ),
                                  ),
                                  EcTile(
                                    icon: Icons.groups,
                                    EcName: 'Clubs',
                                    color: Colors.pink,
                                  ),
                                  EcTile(
                                    icon: Icons.star,
                                    EcName: 'Extracurriculars',
                                    color: Colors.purple,
                                  ),
                                  EcTile(
                                    icon: Icons.list,
                                    EcName: 'Other',
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
