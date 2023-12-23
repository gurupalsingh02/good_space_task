// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_space/otp_page.dart';
import 'package:good_space/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

String deviceId = "device-id";
String deviceType = "device";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final phoneNumberController = TextEditingController();
  List<String> imagePaths = [
    'Assets/Images/signup-1.png',
    'Assets/Images/signup-2.png',
    'Assets/Images/signup-3.png',
  ];
  int currentIndex = 0;
  CountryCode countryCode = CountryCode(dialCode: "+91", code: "IN");
  @override
  void initState() {
    super.initState();
    // Start the loop when the widget is created
    startImageLoop();
    getDeviceInfo();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();
    super.dispose();
  }

  void startImageLoop() {
    // Change image every 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        currentIndex = (currentIndex + 1) % imagePaths.length;
        startImageLoop(); // Call the function recursively for continuous looping
      });
    });
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      var info = await deviceInfo.webBrowserInfo;
      deviceId = "${info.productSub} web browser";
      deviceType = "web";
    } else if (Platform.isAndroid) {
      var info = await deviceInfo.androidInfo;
      deviceId = info.id;
      deviceType = "android";
    } else if (Platform.isIOS) {
      var info = await deviceInfo.iosInfo;
      deviceId = info.identifierForVendor ?? "ios";
      deviceType = "ios";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.4,
                      image: AssetImage(imagePaths[currentIndex]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.25,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04),
                    child: SizedBox(
                      child: RichText(
                        text: const TextSpan(
                          text: 'Please Enter your phone number to sign in ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'GoodSpace ',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(text: 'Account'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only digits
                      ],
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                          prefixIcon: CountryCodePicker(
                            onChanged: (value) => {
                              setState(() {
                                countryCode = value;
                              })
                            },
                            initialSelection: countryCode.code,
                            favorite: const ['+91'],
                            alignLeft: false,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          hintText: "Please enter mobile no."),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.5, 60),
                          maximumSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 60),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () async {
                          if (phoneNumberController.text.length == 10) {
                            await Services.getOTP(
                                phoneNumber: phoneNumberController.text.trim(),
                                countryCode: countryCode.dialCode ?? "+91");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPVerificationScreen(
                                          mobileNumber:
                                              phoneNumberController.text.trim(),
                                          countryCode:
                                              countryCode.dialCode ?? "+91",
                                        )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Mobile Number should be of 10 digit")));
                          }
                        },
                        child: const Text('Send OTP')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
