import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'methods/post_storage.dart';
import '../home.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _image;
  final TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;

  void selectImage() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _image = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose from gallery"),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _image = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    throw Exception('No image selected');
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await PostStorage().uploadPost(
        _captionController.text,
        uid,
        username,
        profImage,
        _image!,
      );

      if (res == "Ok") {
        setState(() {
          _isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(context, 'Posted!');
          clearImage();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, err.toString());
    }
  }

  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  void showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Add Image",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _image != null
                ? () => postImage("uid", "username", "profImage")
                : null,
            child: const Text(
              "Post",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0)),
          const SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Divider(),
          ),
          const SizedBox(height: 20),
          const Text(
            "Add Image",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Choose an image from your gallery or take a one.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          _image != null
              ? SizedBox(
                  height: 200,
                  width: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_image!),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: selectImage,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/galleryIcon.webp',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: "Write a caption...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 