import 'package:Electchain/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel(avatar: '', id: '', name: '', phoneNumber: '', email: '', ownedElections: []).obs;

  UserModel get user => _userModel.value;
  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel(avatar: '', id: '', name: '', phoneNumber: '', email: '', ownedElections: []);
  }

  UserModel fromDocumentSnapshot(DocumentSnapshot doc) {
    UserModel _user = UserModel(avatar: '', id: '', name: '', phoneNumber: '', email: '', ownedElections: []);
    _user.id = doc.id;

    var data = doc.data() as Map<String, dynamic>;
    _user.email = data['email'];
    _user.name = data['name'];
    _user.phoneNumber = data['phonenumber'];
    _user.ownedElections = List<String>.from(data['owned_elections'] ?? []);
    _user.avatar = data['avatar'];

    return _user;
  }
}
