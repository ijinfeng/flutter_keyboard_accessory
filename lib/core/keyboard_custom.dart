import 'package:flutter/material.dart';

typedef CustomAccessoryBuilder = Widget Function();

class KeyboardCustomAccessory {
  final CustomAccessoryBuilder builder;
  final double height;

  const KeyboardCustomAccessory(
      {
      required this.builder,
      this.height = 32,});
}
