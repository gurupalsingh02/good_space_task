import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_space/services.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String countryCode;
  final String mobileNumber;
  const OTPVerificationScreen(
      {Key? key, required this.mobileNumber, required this.countryCode})
      : super(key: key);

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late String newCountryCode;
  final TextEditingController firstDigitOTPController = TextEditingController();
  final TextEditingController secondDigitOTPController =
      TextEditingController();
  final TextEditingController thirdDigitOTPController = TextEditingController();
  final TextEditingController fourthDigitOTPController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          surfaceTintColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          content: SingleChildScrollView(
                            child: SizedBox(
                              child: Column(
                                children: [
                                  const Text(
                                    "Enter Correct Phone Number",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextField(
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
                                              newCountryCode =
                                                  value.code ?? "IN";
                                            })
                                          },
                                          initialSelection: widget.countryCode,
                                          favorite: const ['+91'],
                                          alignLeft: false,
                                        ),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide()),
                                        hintText: "Please enter mobile no."),
                                  ),
                                  const Text(
                                    "Please be sure to select the correct area code and enter 10 digits. ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(ctx).size.width * 0.8,
                                            60),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Services.getOTP(
                                            phoneNumber:
                                                phoneNumberController.text,
                                            countryCode: widget.countryCode);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OTPVerificationScreen(
                                                        mobileNumber:
                                                            phoneNumberController
                                                                .text,
                                                        countryCode: widget
                                                            .countryCode)));
                                      },
                                      child: const Text('Verify Phone')),
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: const Row(
                children: [
                  Text(
                    'Edit Phone number',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.grey,
                  )
                ],
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'OTP sent to ${widget.mobileNumber}\nEnter OTP to confirm your phone',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'You\'ll receive a four-digit verification code.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  MediaQuery.of(context).size.width > 300
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  autofocus: true,
                                  onChanged: (value) => {
                                    if (firstDigitOTPController.text.length ==
                                        1)
                                      {FocusScope.of(context).nextFocus()}
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  focusNode: otpFocusNode,
                                  controller: firstDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  onChanged: (value) => {
                                    if (secondDigitOTPController.text.length ==
                                        1)
                                      {FocusScope.of(context).nextFocus()}
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  controller: secondDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  onChanged: (value) => {
                                    if (thirdDigitOTPController.text.length ==
                                        1)
                                      {FocusScope.of(context).nextFocus()}
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  controller: thirdDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  controller: fourthDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  autofocus: true,
                                  onChanged: (value) => {
                                    if (firstDigitOTPController.text.length ==
                                        1)
                                      {FocusScope.of(context).nextFocus()}
                                  },
                                  focusNode: otpFocusNode,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  controller: firstDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  onChanged: (value) => {
                                    if (secondDigitOTPController.text.length ==
                                        1)
                                      {FocusScope.of(context).nextFocus()}
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  controller: secondDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  onChanged: (value) => {
                                    if (thirdDigitOTPController.text.length ==
                                        1)
                                      {FocusScope.of(context).nextFocus()}
                                  },
                                  controller: thirdDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allow only digits
                                  ],
                                  controller: fourthDigitOTPController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MediaQuery.of(context).size.width > 300
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Didn\'t receive the code? ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Services.getOTP(
                                        phoneNumber: widget.mobileNumber,
                                        countryCode: widget.countryCode);
                                  },
                                  child: const Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Didn\'t receive the code? ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await Services.getOTP(
                                        phoneNumber: widget.mobileNumber,
                                        countryCode: widget.countryCode);
                                  },
                                  child: const Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.5, 60),
                            maximumSize: Size(
                                MediaQuery.of(context).size.width * 0.8, 60),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            String otp = firstDigitOTPController.text +
                                secondDigitOTPController.text +
                                thirdDigitOTPController.text +
                                fourthDigitOTPController.text;
                            if (otp.length == 4) {
                              Services.verifyOTP(
                                  context: context,
                                  phoneNumber: widget.mobileNumber,
                                  countryCode: widget.countryCode,
                                  otp: otp);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("OTP should be of 4 digit")));
                            }
                          },
                          child: const Text('Verify Phone')),
                    ],
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
