import 'package:flutter/material.dart';
import 'package:login_page_wto/empty_screen.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class OtpScreen extends StatefulWidget {
   const OtpScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  final _otplessFlutterPlugin = Otpless();
  void verifyOtp() {
    Map<String, dynamic> arg = {};
    arg["phone"] = widget.phoneNumber;
    arg["countryCode"] = "+91";
    arg["otp"] = otpController.text;
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }

  void onHeadlessResult(dynamic result) {
    setState(() {
      print(result);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EmptyScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "Login here",
              style: TextStyle(
                color: Color(0xff1F41BB),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome back you’ve \nbeen missed!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Color(0xff626262),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF1F4FF),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff1F41BB)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff1F41BB)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "OTP",
                hintStyle: const TextStyle(
                  color: Color(0xff626262),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
        
            ElevatedButton(
              onPressed: () {
                verifyOtp();
              },
              child: Text(
                'Verify',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
