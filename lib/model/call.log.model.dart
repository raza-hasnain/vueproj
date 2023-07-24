class CallLogModel {
  late String phoneNumber;
  late String durationOfCall;
  late String nameOfPerson;
  late String dateTime;
  late String status;

  CallLogModel(
      {required this.phoneNumber,
      required this.durationOfCall,
      required this.nameOfPerson,
      required this.dateTime,
      required this.status});

  CallLogModel.fromMap(Map<String, dynamic> map) {
    phoneNumber = map['leadContact'];
    durationOfCall = map['duration'];
    nameOfPerson = map['personName'];
    status = map['status'];
    dateTime = map['dateTime'];
  }
}
