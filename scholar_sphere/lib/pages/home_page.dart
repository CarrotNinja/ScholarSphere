import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scholar_sphere/util/ec_tile.dart';
import 'package:scholar_sphere/util/emotion_face.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blue[800],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Transform.flip(
                  flipX: true,
                  child: const Icon(Icons.reply),
                ),
                label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.deepPurple,
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
                              const Text(
                                "Hi Razam!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                      SizedBox(
                        height: 25,
                      )
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
                                  EcTile(
                                    icon: Icons.emoji_events,
                                    EcName: 'Awards',
                                    color: Colors.blue,
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
