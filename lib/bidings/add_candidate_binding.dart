import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/services/database.dart';
import 'package:get/get.dart';

class AddCandidateBinding extends Bindings {
  @override
  void dependencies() {
    getData() async {
      var data;
      await DataBase()
          .candidatesStream(Get.find<UserController>().user.id,
              Get.arguments[0].id.toString())
          .then((election) {
        data = election.data() != "option";
        Get.find<ElectionController>().currentElection.options = data;
      });
    }
  }
}
