import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_sphere/pages/login_screen.dart';
import 'package:scholar_sphere/pages/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffB81736),
            Color(0xff2B1836),
          ])),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Icon(
                    Icons.logo_dev,
                    size: 200,
                  )),
              SizedBox(
                height: 50,
              ),
              Text(
                'Welcome Back',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                      child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap:() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                      child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
                ),
              ),
              Spacer(),
              Text(
                'Login with Social Media',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ],
          )),
    );
  }
}
