import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String avatar;
  String id;
  String name;
  String phoneNumber;
  String email;
  List<dynamic> ownedElections;

  UserModel(
      {required this.avatar,
      required this.id,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.ownedElections});

  UserModel fromDocumentSnapshot(DocumentSnapshot doc) {
    UserModel _user = UserModel(avatar: '', id: '', name: '', phoneNumber: '', email: '', ownedElections: []);
    _user.id = doc.id;
    _user.email = doc['email'];
    _user.name = doc['name'];
    _user.phoneNumber = doc['phonenumber'];
    _user.ownedElections = doc['owned_elections'];
    _user.avatar = doc['avatar'];
    return _user;
  }
}
