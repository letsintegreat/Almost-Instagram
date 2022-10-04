import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/api/client.dart';
import 'package:instagram/utils/api.dart';

class HomeNewpostTab extends StatefulWidget {
  const HomeNewpostTab({super.key});

  @override
  State<HomeNewpostTab> createState() => _HomeNewpostTabState();
}

class _HomeNewpostTabState extends State<HomeNewpostTab> {
  String _imageId = "";
  String _username = "";
  final TextEditingController _caption = TextEditingController();
  bool _imageSelected = false;

  void createNewPost(BuildContext context) {
    // Check if user has not selected an image yet.
    if (!_imageSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Select an image.",
          ),
        ),
      );
      return;
    }

    // Create a new document in our posts collection.
    Future result = ApiClient.databases.createDocument(
        databaseId: ApiInfo.databaseId,
        collectionId: ApiInfo.collectionId,
        documentId: "unique()",
        data: {
          'username': _username,
          'imageId': _imageId,
          'caption': _caption.text,
        });

    result.then((response) {
      // Success.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Image posted!",
          ),
        ),
      );
    }).catchError((error) {
      // Failure.
      print(error.response);
    });
  }

  Future<void> selectImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    try {

      // Upload the image file to appwrite storage.
      Future result = ApiClient.storage.createFile(
        bucketId: ApiInfo.bucketId,
        fileId: "unique()",
        file: InputFile(path: image!.path, filename: image.name),
      );

      result.then((response) {
        // Success.
        setState(() {
          _imageId = response.$id;
          _imageSelected = true;
        });
      }).catchError((error) {
        // Failure.
        print(error.response);
      });
    } catch (error) {
      // User backed out before selecting an image, do nothing.
    }
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
        child: Column(children: [
          SizedBox(
            height: 45.0,
            child: Row(
              children: [
                Spacer(),
                Text(
                  "New post",
                  style: TextStyle(
                    color: Color(0xFFF9F9F9),
                    fontSize: 16.0,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => createNewPost(context),
                      icon: Icon(Icons.check),
                      color: Colors.blue,
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 62 + 16 * 2,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/profile.png",
                  width: 62.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextField(
                    controller: _caption,
                    style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFF121212),
                      hintText: 'Write a caption...',
                      hintStyle:
                          TextStyle(fontSize: 14.0, color: Color(0x99FFFFFF)),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          (_imageSelected)
              ? FutureBuilder(
                  future: ApiClient.storage.getFileDownload(
                      bucketId: ApiInfo.bucketId, fileId: _imageId),
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Image.memory(
                              snapshot.data! as Uint8List,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CircularProgressIndicator();
                  },
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 44.0,
                    child: Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () => selectImage(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Select image',
                          style:
                              TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
                        ),
                      );
                    }),
                  ),
                ),
        ]),
      ),
    );
  }
}
