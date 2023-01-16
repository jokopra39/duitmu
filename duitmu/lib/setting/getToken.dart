import 'dart:convert';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:mplan/config/api.dart';
// import 'package:mplan/mixin/chat.dart';
// import 'package:mplan/mixin/firstload.dart';
//import 'package:mplan/mixin/firstload.dart';
// import 'package:mplan/mixin/global_var.dart';
// import 'package:mplan/refresh/main_bloc.dart';
//import 'package:mplan/mixin/global_var.dart';
// import 'package:mplan/mixin/test.dart';
// import 'package:mplan/screen/register.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import 'mainMenu.dart';

//import 'newscreen.dart';
class GetToken extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

enum LoginStatus { notSignIn, signIn }

String _homeScreenText = "Waiting for token...";
String siap = "siap...";

class _PushMessagingExampleState extends State<GetToken> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  //String username, password;
  static int i = 0;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  //final List<Message> messages = [];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static String dataName = '';
  static String dataAge = '';

  var value;
  var getuser;
  var idoffice;
  var getId;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print(siap);
        //onBackgroundMessages(message);
        getDataFcm(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print(siap);
        getDataFcm(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = token;
        // GlobalVar.homeScreenText = token;
      });
      print(_homeScreenText);
    });
  }

  @override
  void dispose() {
    // mainBlocChart = null; // destroying the mainBloc object to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Push Messaging Demo'),
        ),
        body: const Center(
          child: Text("oook"),
        ));
  }

  void getDataFcm(Map<String, dynamic> message) {
    String name = '';
    String age = '';
    if (Platform.isIOS) {
      name = message['name'];
      age = message['age'];
    } else if (Platform.isAndroid) {
      var data = message['data'];
      name = data['name'];
      age = data['age'];
    }
    if (name.isNotEmpty && age.isNotEmpty) {
      setState(() {
        dataName = name;
        dataAge = age;
      });
    }
    debugPrint('getDataFcm: name: $name & age: $age');
  }
}
