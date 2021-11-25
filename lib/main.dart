import 'dart:io';

import 'package:banking_app/bloc/customer_provider.dart';
import 'package:banking_app/model/customer.dart';
import 'package:banking_app/push%20notification/push_notification.dart';
import 'package:banking_app/routes/routes.dart';
import 'package:banking_app/screens/home_screen.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

int count = 0;
// This is firebase handler for background messages
Future<void> _messageHandler(RemoteMessage message) async {
  count++;
  print('$count background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CustomerAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerProvider>(
            create: (context) => CustomerProvider()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
          routes: routes,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseMessaging _messaging;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   print(
      //       'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
      // });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print(initialMessage);
    }
  }

  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    pushNotification(context);
    checkForInitialMessage();
    // registerNotification();
    // _initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return const HomeScreen();
  }
}
