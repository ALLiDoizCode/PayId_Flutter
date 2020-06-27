library payid;

import 'dart:async';
import 'dart:convert' show json, jsonDecode;
import 'package:http/http.dart' as http;
import 'package:payid/network/router.dart';
import 'package:payid/models/PayId.dart';

class Headers {
  static const xrp = "application/xrpl-mainnet+json";
  static const eos = "application/eos-mainnet+json!";
  static const eth = "application/eth-mainnet+json";
  static const btc = "application/btc-mainnet+json";
  static const xrp_test = "application/xrpl-testnet+json";
  static const eos_test = "application/eos-testnet+json!";
  static const eth_test = "application/eth-testnet+json";
  static const btc_test = "application/btc-testnet+json";
  static const payid = "application/payid+json";
  static const admin_version = "2020-05-28";
  static const public_version = "1.0";
}

class PublicClient extends http.BaseClient {
  final String version;
  final String accept;
  final http.Client _inner;

  PublicClient(this.version, this.accept, this._inner);
  
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    print(version);
    print(accept);
    request.headers['PayID-Version'] = version;
    request.headers['Accept'] = accept;
    return _inner.send(request);
  }
}

class AdminClient extends http.BaseClient {
  final String version;
  final String accept;
  final http.Client _inner;

  AdminClient(this.version, this.accept, this._inner);
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['PayID-API-Version'] = version;
    request.headers['Accept'] = accept;
    return _inner.send(request);
  }
}
class PayIdClient {
  var client = http.Client();
  
  Future<String> getPayId(String id) async {
    print(Routes().baseRoute(Permission.Public, id));
    var request = new http.Request("GET", Uri.parse(Routes().baseRoute(Permission.Public, id)));
    http.StreamedResponse streamedResponse = await PublicClient(Headers.public_version, Headers.payid, client).send(request);
    http.Response response = await http.Response.fromStream(streamedResponse);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    Map jsonString = jsonDecode(response.body);
    PayId payid = PayId.fromJson(jsonString);
    print(payid.id);
    return response.body;
  }

  /*Future<String> post(String route) async {
    print(route);
    return http.post(route).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }*/

  /*Future<String> get(String route) async {
    print(route);
    http.Response res = await http.get(route);
    final int statusCode = res.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return res.body;
  }*/
}


/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
  
}


