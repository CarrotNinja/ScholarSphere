import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_sphere/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_sphere/backend/auth.dart';
import 'package:scholar_sphere/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? errorMessage = '';
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  @override
  void dispose() {
    _controllerConfirmPassword.dispose();
    _controllerEmail.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
      if(passwordConfirmed()){
        await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text.trim(),password: _controllerPassword.text);
        addUserDetails(_controllerFirstName.text.trim(), _controllerLastName.text.trim(), _controllerEmail.text.trim());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyApp()));
        //Add user details
      }else{
        showErrorMessage("Passwords don't match");
      }  
    } on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
      showErrorMessage(errorMessage!);
    }
  }

  Future addUserDetails(String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name':firstName,
      'last name':lastName,
      'email':email,
    });
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return  AlertDialog(
            title: Text(message,
              style: TextStyle(color: Colors.black),
            ),
          );
        });
  }

  bool passwordConfirmed(){
    return _controllerPassword.text.trim()==_controllerConfirmPassword.text.trim();
  }

  Widget _errorMessage(){
    return Text(errorMessage=='' ? '': 'Humm ? $errorMessage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height:  MediaQuery.of(context).size.height,
            child: Stack(
                  children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.2,
                    0.3
                  ],
                  colors: [
                Color(0xff56018D),
                
                Color(0xff8B139C),
                Colors.pink,
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
                        controller: _controllerFirstName,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'First Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                      TextField(
                        controller: _controllerLastName,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Last Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                      TextField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                      TextField(
                        controller:_controllerPassword,
                        decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.visibility_off, color: Colors.grey),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                      TextField(
                        controller: _controllerConfirmPassword,
                        decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.visibility_off, color: Colors.grey),
                            label: Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                      
                      SizedBox(
                        height: 10,
                      ),
                      
                      SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: createUserWithEmailAndPassword,
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          stops: [
                                            0.3,
                                            0.6,
                                            0.9
                                          ],
                                          colors: [
                                        Color(0xff56018D),
                                        
                                        Color(0xff8B139C),
                                        Colors.pink,
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
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: Text("Sign in",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),),
                            )
                            
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
                  ],
                ),
          ),
        ));
  }
}