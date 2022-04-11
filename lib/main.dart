import 'package:flutter/material.dart';
import 'package:flutter_keyboard_accessory/keyboard_accessory.dart';

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
            customAccessory: Container(
              color: Colors.red,
              height: 50,
            ),
            builder: (awake) {
              return TextButton(onPressed: () {
                awake();
            }, child: const Text('唤起键盘'));
            },
          ),
        ),
      ),
    );
  }
}
