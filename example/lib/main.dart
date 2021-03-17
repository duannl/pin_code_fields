import 'dart:async';
import 'package:flutter/material.dart';
import 'package:date_fields/pin_code_fields.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: PinCodeVerificationScreen(
          "+8801376221100"), // a random number, please don't call xD
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  PinCodeVerificationScreen(this.phoneNumber);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final scaffoldKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Ngày', style: TextStyle(fontSize: 19)),
                              const SizedBox(width: 25),
                              Text('Tháng', style: TextStyle(fontSize: 19)),
                              const SizedBox(width: 18),
                              Text('Năm', style: TextStyle(fontSize: 19)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          PinCodeTextField(
                            appContext: context,
                            textStyle: TextStyle(
                                fontSize: 19, color: Color(0xFF414141)),
                            length: 8,
                            obscureText: false,
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            mainAxisAlignment: MainAxisAlignment.start,
                            validator: (v) {
                              return null;
                            },
                            pinTheme: PinTheme(
                              activeColor: Color(0xFFff6b8e),
                              inactiveColor: Color(0xFFff6b8e),
                              selectedColor: Color(0xFFff6b8e),
                              shape: PinCodeFieldShape.underline,
                              borderWidth: 1,
                              fieldHeight: 34,
                              fieldWidth: 18,
                            ),
                            cursorColor: Colors.black,
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: false,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: false,
                            onCompleted: (v) {
                              print("Completed");
                            },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              return false;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Nhập ngày tháng năm sinh của bạn (>18 tuổi)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFa0a9b3),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
