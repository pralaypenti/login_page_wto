import 'package:flutter/material.dart';
import 'package:login_page_wto/otp_screen.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneNymberController = TextEditingController();
  final _otplessFlutterPlugin = Otpless();

  @override
  void initState() {
    _otplessFlutterPlugin.initHeadless("GYAZZUKY316G1H8ZOGFC");
    _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
    super.initState();
  }

  void onHeadlessResult(dynamic result) {
    setState(() {
      print(result);
    });
  }

  void sendOtp() {
    if (phoneNymberController.text.isEmpty) {
      print("phone number required");
    } else {
      Map<String, dynamic> arg = {};
      arg["phone"] =phoneNymberController.text;
      arg["countryCode"] = "+91";
      _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) =>  OtpScreen(phoneNumber: phoneNymberController.text,)),
      );
    }
  }

  void socialLogin(String channel) {
    Map<String, dynamic> arg = {'channelType': channel};
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Text Page '),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneNymberController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'phoneNumber',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                sendOtp();
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
