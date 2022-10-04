import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:instagram/api/client.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/utils/api.dart';
import 'package:instagram/widgets/post.dart';
import 'package:instagram/widgets/story.dart';

class HomeHomeTab extends StatefulWidget {
  const HomeHomeTab({Key? key}) : super(key: key);

  @override
  _HomeHomeTab createState() => _HomeHomeTab();
}

class _HomeHomeTab extends State<HomeHomeTab> {
  String _username = "";

  var subscription;

  List<Post> _posts = [
    Post(
        image: "assets/profile_4.png",
        name: "joshua_l",
        location: "Tokyo, Japan",
        post: "assets/post.png",
        caption:
            "joshua_l The game in Japan was amazing and I want to share some photos",
        date: "September 19",
        liked: false),
  ];

  void likePost(BuildContext context, int i) {
    List<Post> newPosts = List.from(_posts);
    
    newPosts[i].liked = !newPosts[i].liked;
    if (newPosts[i].liked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You have liked this post."),
        ),
      );
    }
    setState(() {
      _posts = List.from(newPosts);
    });

  }

  void updateList() {
    _posts = [];

    // Get the list of documents (posts).
    Future result = ApiClient.databases.listDocuments(
      databaseId: ApiInfo.databaseId,
      collectionId: ApiInfo.collectionId,
    );

    result.then((response) {

      List docs = response.documents;

      for (int i = docs.length-1; i >= 0; i--) {
        // Assign a random profile pic to each post.
        int profileId = (i % 4) + 1;

        setState(() {

          _posts.add(Post(
            name: docs[i].data["username"],
            caption: docs[i].data["caption"],
            post: docs[i].data["imageId"],
            image: "assets/profile_$profileId.png",
          ));
        });
      }
    }).catchError((error) {
      // Error
      print(error.response);
    });
  }

  @override
  void initState() {
    super.initState();

    // Get the currently logged in account.
    Future result = ApiClient.account.get();

    result.then((response) {
      // Success
      setState(() {

        // Set the username fetched from account.
        _username = response.name;
      });
    }).catchError((error) {
      // Error
      print(error.response);
    });

    // Subscribe to changes in posts.
    subscription = ApiClient.realtime.subscribe([
      'databases.${ApiInfo.databaseId}.collections.${ApiInfo.collectionId}.documents'
    ]);

    // Call updateList every time a change has been detected.
    subscription.stream.listen((response) {
      updateList();
    });

    // Set the list once in initState.
    updateList();
  }

  @override
  void dispose() {
    super.dispose();

    // Close the subscription when tab is disposed.
    subscription.close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(0xFF121212),
          child: Padding(
            padding: const EdgeInsets.only(top: 44.0, bottom: 12.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Image.asset(
                    "assets/camera.png",
                    width: 24.0,
                  ),
                ),
                Spacer(),
                Image.asset(
                  "assets/logo.png",
                  width: 105.0,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    "assets/igtv.png",
                    width: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    "assets/messanger.png",
                    width: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              StoryWidget(
                image: Image.asset(
                  "assets/profile.png",
                  width: 56.0,
                ),
                name: _username,
                seen: false,
              ),
              StoryWidget(
                image: Image.asset(
                  "assets/profile_1.png",
                  width: 56.0,
                ),
                name: "zachjohn",
                seen: false,
              ),
              StoryWidget(
                image: Image.asset(
                  "assets/profile_2.png",
                  width: 56.0,
                ),
                name: "kieron_d",
                seen: false,
              ),
              StoryWidget(
                image: Image.asset(
                  "assets/profile_3.png",
                  width: 56.0,
                ),
                name: "craig_joe",
                seen: false,
              ),
              StoryWidget(
                image: Image.asset(
                  "assets/profile_1.png",
                  width: 56.0,
                ),
                name: "zachjohn",
                seen: false,
              ),
              StoryWidget(
                image: Image.asset(
                  "assets/profile_2.png",
                  width: 56.0,
                ),
                name: "kieron_d",
                seen: false,
              ),
              StoryWidget(
                image: Image.asset(
                  "assets/profile_3.png",
                  width: 56.0,
                ),
                name: "craig_joe",
                seen: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _posts.length,
            itemBuilder: (context, i) {
              return PostWidget(
                post: _posts[i],
                id: i,
                likePost: likePost,
              );
            },
          ),
        ),
        Container(
          height: 0.5,
          color: Color(0x55FFFFFF),
        ),
      ],
    );
  }
}
