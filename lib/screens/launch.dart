import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/home.dart';
import 'package:instagram/screens/login.dart';
import 'package:instagram/screens/signup.dart';
import 'package:instagram/utils/api.dart';

class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);
  var _context;

  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in.
    try {
      Client client = Client()
          .setEndpoint(ApiInfo.url)
          .setProject(ApiInfo.projectId)
          .setSelfSigned(status: true);

      Account account = Account(client);
      Future result = account.get();

      result.then((response) {
        // Logged in user
        Navigator.of(_context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }).catchError((error) {
        print(error.response);
      });
    } catch (error) {
      // User not logged in.
      print(error);
    }
    
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        _context = context;
        return Scaffold(
          body: Column(
            children: [
              Spacer(),
              Center(
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 50.0,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 44.0,
                  child: Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
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
              Padding(padding: EdgeInsets.only(top: 50.0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 44.0,
                  child: Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                      },
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
            ],
          ),
        );
      }),
    );
  }
}
