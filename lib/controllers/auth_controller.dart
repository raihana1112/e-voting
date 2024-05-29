import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/models/models.dart';
import 'package:Electchain/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  var usercontroller = Get.put(UserController());

  String? get user => firebaseUser.value?.email;

  @override
  // ignore: must_call_super
  void onInit() {
    firebaseUser.bindStream(_auth.userChanges());
  }

  void createUser(imgURL, name, phoneNumber, email, password) async {
    try {
      var _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Create a user in firestore
      UserModel _user = UserModel(
          id: _authResult.user!.uid,
          avatar: imgURL,
          name: name,
          phoneNumber: phoneNumber,
          email: email, ownedElections: ['']);
      if (await DataBase().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (err) {
      Get.snackbar('Processing Error', err.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      var _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Get.find<UserController>().user =
          await DataBase().getUser(_authResult.user!.uid);
      Get.back();
    } catch (err) {
      Get.snackbar('Processing Error', err.toString());
    }
  }

  void signOut() {
    try {
      _auth.signOut();
      Get.find<UserController>().clear();
    } catch (err) {
      Get.snackbar('Processing Error', err.toString());
    }
  }
}
