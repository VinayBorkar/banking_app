import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_core/firebase_core.dart';

pushNotification(BuildContext context) async {
  await Firebase.initializeApp();
  const storage = FlutterSecureStorage(); // flutter secure storage instance

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message.notification!.title);
    showSimpleNotification(
        GestureDetector(
          onTap: () {
            // add the screen to navigate to when clicked on banner
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      message.notification!.title != null
                          ? message.notification!.title!
                          : "Banking App",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        message.notification!.body!,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      ),
                    ),
                    // trailing: SizedBox.fromSize(
                    //   size: const Size(30, 30),
                    //   child: Container(
                    //     child:
                    //         Image.asset("assets/launcher_icon/ic_launcher.png"),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
        background: Colors.transparent,
        duration: const Duration(milliseconds: 2000));
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });

  // to fetch the fcm token
  FirebaseMessaging.instance.getToken().then((token) async {
    assert(token != null);
    String? oldFcmToken = await storage.read(key: 'FCMToken');
    print('Token: $token');
    await storage.write(key: 'FCMToken', value: token);
  });
}
