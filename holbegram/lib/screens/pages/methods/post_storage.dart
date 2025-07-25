import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/methods/user_storage.dart';

class PostStorage {
  final _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String caption, String uid, String username, String profImage, Uint8List image) async {
    try {
      StorageMethods storageMethods = StorageMethods();
      String imageUrl = await storageMethods.uploadImageToStorage(true, 'posts', image);
      
      await _firestore.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'isFavorite': false,
      });
      
      return "Ok";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String postId, String publicId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
} 