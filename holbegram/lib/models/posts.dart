import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String postId;
  final String uid;
  final String username;
  final String description;
  final String postUrl;
  final String profImage;
  final List<dynamic> likes;
  final int commentCount;
  final DateTime datePublished;

  const Posts({
    required this.postId,
    required this.uid,
    required this.username,
    required this.description,
    required this.postUrl,
    required this.profImage,
    required this.likes,
    required this.commentCount,
    required this.datePublished,
  });

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    
    return Posts(
      postId: snapshot['postId'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      description: snapshot['description'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      datePublished: (snapshot['datePublished'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'uid': uid,
      'username': username,
      'description': description,
      'postUrl': postUrl,
      'profImage': profImage,
      'likes': likes,
      'commentCount': commentCount,
      'datePublished': Timestamp.fromDate(datePublished),
    };
  }
}
