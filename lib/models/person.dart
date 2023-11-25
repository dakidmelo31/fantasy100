// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hospital/utils/globals.dart';

class Person {
  final String name;
  final String image;
  final String userID;
  final String phone;
  final String age;
  final String alias;
  final String address;

  final String insuranceID;
  final String sex;
  final List<String> allergies;
  final String preferredHospital;
  final bool handicapped;
  final String handicappedCondition;
  final String nokName;
  final String nokPhone;
  final String nokAddress;
  bool helpNow;
  final int priority;
  final bool isInsured;
  final bool activeInsurance;

  Person({
    required this.name,
    required this.image,
    required this.userID,
    required this.phone,
    required this.age,
    required this.alias,
    required this.address,
    required this.insuranceID,
    required this.sex,
    required this.allergies,
    required this.preferredHospital,
    required this.handicapped,
    required this.handicappedCondition,
    required this.nokName,
    required this.nokPhone,
    required this.nokAddress,
    required this.helpNow,
    required this.priority,
    required this.isInsured,
    required this.activeInsurance,
  });

  Person copyWith({
    String? name,
    String? image,
    String? userID,
    String? phone,
    String? age,
    String? alias,
    String? address,
    String? insuranceID,
    String? sex,
    List<String>? allergies,
    String? preferredHospital,
    bool? handicapped,
    String? handicappedCondition,
    String? nokName,
    String? nokPhone,
    String? nokAddress,
    bool? helpNow,
    int? priority,
    bool? isInsured,
    bool? activeInsurance,
  }) {
    return Person(
      name: name ?? this.name,
      image: image ?? this.image,
      userID: userID ?? this.userID,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      alias: alias ?? this.alias,
      address: address ?? this.address,
      insuranceID: insuranceID ?? this.insuranceID,
      sex: sex ?? this.sex,
      allergies: allergies ?? this.allergies,
      preferredHospital: preferredHospital ?? this.preferredHospital,
      handicapped: handicapped ?? this.handicapped,
      handicappedCondition: handicappedCondition ?? this.handicappedCondition,
      nokName: nokName ?? this.nokName,
      nokPhone: nokPhone ?? this.nokPhone,
      nokAddress: nokAddress ?? this.nokAddress,
      helpNow: helpNow ?? this.helpNow,
      priority: priority ?? this.priority,
      isInsured: isInsured ?? this.isInsured,
      activeInsurance: activeInsurance ?? this.activeInsurance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'userID': userID,
      'phone': phone,
      'age': age,
      'alias': alias,
      'address': address,
      'insuranceID': insuranceID,
      'sex': sex,
      'allergies': allergies,
      'preferredHospital': preferredHospital,
      'handicapped': handicapped,
      'handicappedCondition': handicappedCondition,
      'nokName': nokName,
      'nokPhone': nokPhone,
      'nokAddress': nokAddress,
      'helpNow': helpNow,
      'priority': priority,
      'isInsured': isInsured,
      'activeInsurance': activeInsurance,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'] as String,
      image: map['image'] as String,
      userID: map['userID'] as String,
      phone: map['phone'] as String,
      age: map['age'] as String,
      alias: map['alias'] as String,
      address: map['address'] as String,
      insuranceID: map['insuranceID'] as String,
      sex: map['sex'] as String,
      allergies: List<String>.from((map['allergies']) as List<String>),
      preferredHospital: map['preferredHospital'] as String,
      handicapped: map['handicapped'] as bool,
      handicappedCondition: map['handicappedCondition'] as String,
      nokName: map['nokName'] as String,
      nokPhone: map['nokPhone'] as String,
      nokAddress: map['nokAddress'] as String,
      helpNow: map['helpNow'] as bool,
      priority: map['priority'] as int,
      isInsured: map['isInsured'] as bool,
      activeInsurance: map['activeInsurance'] as bool,
    );
  }

  Future<void> getHelp() async {
    helpNow = true;
    Globals.toast("Get Help");
  }

  Future<void> dontGetHelp() async {
    helpNow = false;
    Globals.toast("No more help");
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) =>
      Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Person(name: $name, image: $image, userID: $userID, phone: $phone, age: $age, alias: $alias, address: $address, insuranceID: $insuranceID, sex: $sex, allergies: $allergies, preferredHospital: $preferredHospital, handicapped: $handicapped, handicappedCondition: $handicappedCondition, nokName: $nokName, nokPhone: $nokPhone, nokAddress: $nokAddress, helpNow: $helpNow, priority: $priority, isInsured: $isInsured, activeInsurance: $activeInsurance)';
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        other.userID == userID &&
        other.phone == phone &&
        other.age == age &&
        other.alias == alias &&
        other.address == address &&
        other.insuranceID == insuranceID &&
        other.sex == sex &&
        listEquals(other.allergies, allergies) &&
        other.preferredHospital == preferredHospital &&
        other.handicapped == handicapped &&
        other.handicappedCondition == handicappedCondition &&
        other.nokName == nokName &&
        other.nokPhone == nokPhone &&
        other.nokAddress == nokAddress &&
        other.helpNow == helpNow &&
        other.priority == priority &&
        other.isInsured == isInsured &&
        other.activeInsurance == activeInsurance;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        userID.hashCode ^
        phone.hashCode ^
        age.hashCode ^
        alias.hashCode ^
        address.hashCode ^
        insuranceID.hashCode ^
        sex.hashCode ^
        allergies.hashCode ^
        preferredHospital.hashCode ^
        handicapped.hashCode ^
        handicappedCondition.hashCode ^
        nokName.hashCode ^
        nokPhone.hashCode ^
        nokAddress.hashCode ^
        helpNow.hashCode ^
        priority.hashCode ^
        isInsured.hashCode ^
        activeInsurance.hashCode;
  }
}
