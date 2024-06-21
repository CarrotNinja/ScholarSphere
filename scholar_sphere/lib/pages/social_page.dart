import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  int myIndex = 1; // Assuming this page is the second tab

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
                                CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(
                                      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AWindows_10_Default_Profile_Picture.svg&psig=AOvVaw3hdK3rOp2uuBaVKQSq4g9w&ust=1718686961239000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLiQ34Du4YYDFQAAAAAdAAAAABBw'),
                                )
                              ],
                            ),
                            Text(
                              "Hi User!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
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
