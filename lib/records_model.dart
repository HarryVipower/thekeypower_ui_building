import 'dart:core';

//Most fields in this model are taken from the firestore records collection
//keyTag and keyNumber are retrieved by querying the firestore allKeys collection using the specified keyCode

class Record {
  String? keyCode;
  String? visitorName;
  String? visitorEmail;
  String? visitorCompany;
  String? visitorPhoneNo;
  String? keyTag;
  int? keyNumber;
  DateTime? issueTime;
  DateTime? returnTime;

  Record({
    this.keyCode,
    this.visitorName,
    this.visitorEmail,
    this.visitorCompany,
    this.visitorPhoneNo,
    this.keyTag,
    this.keyNumber,
    this.issueTime,
    this.returnTime,
  });
}