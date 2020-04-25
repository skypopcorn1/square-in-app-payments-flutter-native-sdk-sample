import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // creates a connection to the iOS (or Android) platform allowing our Flutter
  // app to connect with Native iOS/Android & Third-Party APIs
  // More details on this can be found here ---->
  // https://flutter.dev/docs/development/platform-integration/platform-channels

  // Note: the method channel id you provide here must be unique and match the
  // Flutter Method Channel id you provide in the AppDelegate.swift file.
  static const platform = const MethodChannel('com.example.yourprojectname');

  bool finished = false;
  String resultText = '';

  Future _loadNativeSquareIosSdk() async {
    try {
      await platform
          .invokeMethod(
        'getCardNonce',
      )
          .then((result) {
        setState(() {
          finished = true;
          resultText = result;
          print(result);
        });
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Square Native iOS SDK Example"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                onPressed: _loadNativeSquareIosSdk,
                child: Text("Load Square Card Entry Form"),
              ),
            ),
            Text(finished ? resultText : ''),
          ]),
    );
  }
}
