import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/home.dart';
import 'package:instagram/utils/api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Client? client;
  Account? account;

  void login(BuildContext context) {
    // Attempt to login with email and password
    Future result = account!.createEmailSession(
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
  void initState() {
    super.initState();
    client = Client()
        .setEndpoint(ApiInfo.url)
        .setProject(ApiInfo.projectId)
        .setSelfSigned(status: true);
    account = Account(client!);
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
          Row(
            children: [
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, top: 20.0, bottom: 30.0),
                child: Text(
                  "Forgot password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF3797EF)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 44.0,
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () => login(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Log in',
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
                  "Don't have an account? ",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12.0, color: Color(0x99FFFFFF)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "Sign up.",
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
