import 'dart:convert';
import '../network/router.dart';

class PayId {
  final List<Address> addresses;
  final String id;

  PayId(this.addresses, this.id);

  factory PayId.fromJson(Map<String, dynamic> json) {
    var list = json['addresses'] as List;
    List<Address> addresses =
        list.map((i) => Address.fromJson(i)).toList();
    var id = json["payId"];
    return PayId(addresses, id);
  }
}

class Address {
  final String paymentNetwork;
  final String environment;
  final String addressDetailsType;
  final AddressDetail addressDetail;

  Address(this.paymentNetwork, this.environment, this.addressDetailsType, this.addressDetail);

  Address.fromJson(Map<String, dynamic> json)
      : paymentNetwork = json["paymentNetwork"],
        environment = json["environment"],
        addressDetailsType = json["addressDetailsType"],
        addressDetail = AddressDetail.fromJson(json["addressDetail"]);
}

class AddressDetail {
  final String address;
  final String tag;
  final String memo;

  AddressDetail(this.address, this.tag, this.memo);

  AddressDetail.fromJson(Map<String, dynamic> json)
      : address = json["address"],
        tag = json["tag"],
        memo = json["memo"];
}