import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:instagram/api/client.dart';
import 'package:instagram/screens/launch.dart';
import 'package:instagram/utils/api.dart';

import '../../widgets/story.dart';

class HomeProfileTab extends StatefulWidget {
  const HomeProfileTab({Key? key}) : super(key: key);

  @override
  State<HomeProfileTab> createState() => _HomeProfileTabState();
}

class _HomeProfileTabState extends State<HomeProfileTab> {
  String _username = "";

  void logout(BuildContext context) {

    // Delete the current session.
    Future result = ApiClient.account.deleteSession(
      sessionId: 'current',
    );

    result.then((response) {
      // Successfully logged out.

      // Remove all the routes and push LaunchScreen.
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LaunchScreen()),
        ModalRoute.withName('/'),
      );

    }).catchError((error) {
      // Failure
      print(error.response);
    });
  }

  @override
  void initState() {
    super.initState();
    Future result = ApiClient.account.get();
    result.then((response) {
      setState(() {
        _username = response.name;
      });
    }).catchError((error) {
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFF121212),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              child: Row(
                children: [
                  Spacer(),
                  Image.asset(
                    "assets/private_icon.png",
                    width: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Text(
                      _username,
                      style: TextStyle(
                        color: Color(0xFFF9F9F9),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/accounts_list.png",
                    width: 7.0,
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/story_wrap_seen.png",
                          width: 96.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            "assets/profile.png",
                            width: 86.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "54",
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Posts",
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 13.0,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "834",
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 13.0,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "162",
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 13.0,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 16.0),
              child: Text(
                _username,
                style: TextStyle(color: Color(0xFFF9F9F9), fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16.0),
              child: Text(
                "Digital goodies designer @pixsellz\nEverything is designed.",
                style: TextStyle(color: Color(0xFFF9F9F9), fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: Builder(builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      side: BorderSide(
                        color: Color(0x27FFFFFF),
                        width: 1.0,
                      ),
                    ),
                    onPressed: () => logout(context),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Color(0xFFF9F9F9),
                        fontSize: 13.0,
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 62.0,
                          width: 62.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0x14FFFFFF), width: 1.0),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/add_story.png",
                              width: 18.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                          child: Center(
                            child: Text(
                              "New",
                              style: TextStyle(
                                color: Color(0xFFF9F9F9),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  StoryWidget(
                    image: Image.asset(
                      "assets/profile_story_1.png",
                      width: 56.0,
                    ),
                    name: "Friends",
                    seen: true,
                  ),
                  StoryWidget(
                    image: Image.asset(
                      "assets/profile_story_2.png",
                      width: 56.0,
                    ),
                    name: "Sports",
                    seen: true,
                  ),
                  StoryWidget(
                    image: Image.asset(
                      "assets/profile_story_3.png",
                      width: 56.0,
                    ),
                    name: "Design",
                    seen: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
