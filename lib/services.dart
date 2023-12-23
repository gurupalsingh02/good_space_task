// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:good_space/dashboard_page.dart';
import 'package:good_space/loading_screen.dart';
import 'package:good_space/product.dart';
import 'package:good_space/sign_in_page.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url = 'https://api.ourgoodspace.com';

  static Future<void> getOTP(
      {required String phoneNumber, required String countryCode}) async {
    try {
      final response = await http.post(
        Uri.parse("$url/api/d2/auth/v2/login"),
        headers: {
          "Content-Type": "application/json",
          "device-id": "1234",
          "device-type": "android"
        },
        body: json.encode({"number": phoneNumber, "countryCode": countryCode}),
      );
      if (response.statusCode == 200) {
        log(response.body);
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> verifyOTP(
      {required BuildContext context,
      required String phoneNumber,
      required String countryCode,
      required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse("$url/api/d2/auth/verifyotp"),
        headers: {
          "Content-Type": "application/json",
          "device-id": deviceId,
          "device-type": deviceType
        },
        body: json.encode(
            {"number": phoneNumber, "countryCode": countryCode, "otp": otp}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        userToken = json.decode(response.body)["data"]["token"];
        sharedPreferences.setString("token", userToken!);
        print(userToken);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP'),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<List<Product>> getPremiumProducts({
    required BuildContext context,
  }) async {
    List<Product> products = [];
    try {
      final response = await http.get(
        Uri.parse("$url/api/d2/manage_products/getInActiveProducts"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$userToken"
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        for (var doc in data['data']) {
          Product toAdd = Product.fromJson(doc as Map<String, dynamic>);
          products.add(toAdd);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('error occured'),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return products;
  }

  static Future<void> getJobs({
    required BuildContext context,
  }) async {
    List<Product> products = [];
    try {
      final response = await http.get(
        Uri.parse("$url/api/d2/member/dashboard/feed"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$userToken"
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // for (var doc in data['data']) {
        //   Product toAdd = Product.fromJson(doc as Map<String, dynamic>);
        //   products.add(toAdd);
        // }
        print(data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('error occured'),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
