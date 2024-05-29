class ElectionModel {
  String accessCode;
  String name;
  String description;
  String startDate;
  String endDate;
  List<dynamic> options;
  List<dynamic> voted;
  String id;
  String owner;

  ElectionModel(
      {required this.name,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.accessCode,
      required this.options,
      required this.voted,
      required this.owner,
      required this.id});
}
