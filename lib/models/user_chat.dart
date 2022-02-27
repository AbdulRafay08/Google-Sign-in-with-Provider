import 'package:chat_app/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  String phoneNumber;
  UserChat(
      {required this.aboutMe,
      required this.id,
      required this.photoUrl,
      required this.phoneNumber,
      required this.nickname});
  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.phoneNumber: phoneNumber,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
      // ignore: empty_catches
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
      // ignore: empty_catches
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e)
    // ignore: empty_catches
    {}
    try {
      phoneNumber = doc.get(FirestoreConstants.phoneNumber);
      // ignore: empty_catches
    } catch (e) {}
    return UserChat(
        aboutMe: aboutMe,
        id: doc.id,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        nickname: nickname);
  }
}
