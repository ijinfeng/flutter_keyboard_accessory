import 'package:flutter/material.dart';
import 'package:flutter_keyboard_accessory/core/keyboard_accessory.dart';
import 'package:flutter_keyboard_accessory/core/keyboard_custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: KeyboardAccessory(
            // customAccessory: Container(
            //   color: Colors.red,
            //   height: 50,
            // ),
            customAccessory: KeyboardCustomAccessory(builder: () {
              return TextField();
            }, height: 44,),
            onSubmitted: (text) {
              print("$text");
            },
            builder: (awake) {
              return Container(
                height: 200,
                child: Column(
                  children: [
                    TextButton(onPressed: () {
                      awake();
            }, child: const Text('唤起键盘')),
            TextField(cursorColor: const Color(0xffF20000),)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
