import 'dart:core';

class Record {
  String? keyCode;
  String? visitorName;
  String? visitorEmail;
  String? visitorCompany;
  String? visitorPhoneNo;
  DateTime? issueTime;
  DateTime? returnTime;

  Record({
    this.keyCode,
    this.visitorName,
    this.visitorEmail,
    this.visitorCompany,
    this.visitorPhoneNo,
    this.issueTime,
    this.returnTime,
  });
}