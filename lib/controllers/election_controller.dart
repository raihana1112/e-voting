import 'dart:math';

import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//Function to generate the vote access code as a mix of number and sting

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _random = Random();

class ElectionModel {
  String? id;
  String? accessCode;
  String? description;
  Timestamp? endDate;
  String? name;
  List<String>? options;
  Timestamp? startDate;
  bool? voted;
  String? owner;

  ElectionModel({
    this.id,
    this.accessCode,
    this.description,
    this.endDate,
    this.name,
    this.options,
    this.startDate,
    this.voted,
    this.owner,
  });
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));

class ElectionController extends GetxController {
  Rx<ElectionModel> _electionModel = ElectionModel().obs;
  ElectionModel currentElection = ElectionModel();

  ElectionModel get election => _electionModel.value;

  set election(ElectionModel value) => this._electionModel.value = value;

  bool endElection() {
    _electionModel.value.endDate = DateTime.now().toString() as Timestamp?;
    return true;
  }

  ElectionModel fromDocumentSnapshot(DocumentSnapshot doc) {
    // Ensure doc.data() is not null
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('Document snapshot data is null');
    }

    return ElectionModel(
      id: doc.id,
      accessCode: data['accessCode']! as String?,
      description: data['description'] as String?,
      endDate: data['endDate'] as Timestamp?,
      name: data['name'] as String?,
      options: List<String>.from(data['options'] as List<dynamic>? ?? []),
      startDate: data['startDate'] as Timestamp?,
      voted: data['voted'] as bool?,
      owner: data['owner'] as String?,
    );
  }

  createElection(name, description, startDate, endDate) {
    ElectionModel election = ElectionModel(
        accessCode: getRandomString(6),
        name: name,
        voted: [],
        owner: Get.find<UserController>().user.id,
        description: description,
        startDate: startDate,
        endDate: endDate);
    DataBase().createElection(election);
  }

  candidatesStream(String _uid, String _electionId) {
    DataBase().candidatesStream(_uid, _electionId);
  }

  copyAccessCode(String code) {
    //how to copy to the clipboard using dart
    Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'COPYING ACCESS CODE',
      'Access code copied successfully',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      barBlur: 0.0,
      overlayBlur: 0.0,
      margin: const EdgeInsets.only(top: 200.0),
      icon: Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color.fromARGB(255, 102, 118, 207), Colors.blue]),
    );
  }

  getElection(String _uid, String _electionID) {
    DataBase().getElection(_uid, _electionID).then(
        (_election) => Get.find<ElectionController>().election = _election);
  }
}
