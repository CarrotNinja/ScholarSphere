import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffB81736),
            Color(0xff2B1836),
          ])),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Create Your\nAccount',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        label: Text(
                          'Full Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736)),
                        )),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.check, color: Colors.grey),
                        label: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736)),
                        )),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.visibility_off, color: Colors.grey),
                        label: Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736)),
                        )),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.visibility_off, color: Colors.grey),
                        label: Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736)),
                        )),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          Color(0xffB81736),
                          Color(0xff2B1836),
                        ])),
                    child: Center(
                      child: Text('SIGN UP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Already have an account?",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),),
                        Text("Sign in",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black,
                        ),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}