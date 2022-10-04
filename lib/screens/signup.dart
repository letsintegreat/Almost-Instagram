import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:instagram/api/client.dart';
import 'package:instagram/screens/home.dart';

import '../utils/api.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final TextEditingController _email = TextEditingController();

  Future<void> signup(BuildContext context) async {
    // Attempt to create an account.
    try {
      var result = await ApiClient.account.create(
          userId: ID.unique(),
          email: _email.text,
          password: _password.text,
          name: _username.text);
      if (result.status) {
        // Success, new account created.

        // Now login:
        login(context);
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    } catch (error) {
      // Failure
      print(error);
    }
  }

  void login(BuildContext context) {
    // Attempt to login with email and password
    Future result = ApiClient.account.createEmailSession(
      email: _email.text,
      password: _password.text,
    );
    result.then((response) {
      // Success
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }).catchError((error) {
      // Failure
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      body: Column(
        children: [
          Spacer(),
          Center(
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 50.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
            child: TextField(
              controller: _username,
              style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF121212),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Username',
                hintStyle: TextStyle(fontSize: 14.0, color: Color(0x99FFFFFF)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: TextField(
              controller: _password,
              obscureText: true,
              style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF121212),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(fontSize: 14.0, color: Color(0x99FFFFFF)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: TextField(
              controller: _confirm,
              obscureText: true,
              style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF121212),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(fontSize: 14.0, color: Color(0x99FFFFFF)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: TextField(
              controller: _email,
              style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF121212),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x33FFFFFF), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(fontSize: 14.0, color: Color(0x99FFFFFF)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 44.0,
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () => signup(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
                  ),
                );
              }),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 0.5,
                    color: Color(0x99FFFFFF),
                  ),
                ),
              ),
              Text("OR",
                  style: TextStyle(fontSize: 14.0, color: Color(0x99FFFFFF))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 0.5,
                    color: Color(0x99FFFFFF),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 5.0),
                child: Text(
                  "Have an account? ",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12.0, color: Color(0x99FFFFFF)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "Log in.",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF3797EF)),
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Container(
            height: 0.5,
            color: Color(0x99FFFFFF),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              "Instagram from Meta",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12.0, color: Color(0x99FFFFFF)),
            ),
          ),
        ],
      ),
    );
  }
}
