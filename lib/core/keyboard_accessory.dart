import 'package:flutter/material.dart';
import 'package:flutter_keyboard_accessory/core/keyboard_custom.dart';
import 'package:flutter_keyboard_accessory/core/keyboard_custom_input.dart';

typedef AccessoryChildBuilder = Widget Function(VoidCallback awake);

class KeyboardAccessory extends StatelessWidget {
  final AccessoryChildBuilder builder;

  /// 自定义键盘辅助输入框
  late KeyboardCustomAccessory? customAccessory;

  /// 点击空白处关闭
  final bool isDismissible;

  /// 背景色
  final Color? barrierColor;

  final ValueChanged<String> onSubmitted;

  final String? text;

  KeyboardAccessory(
      {this.customAccessory,
      this.text,
      this.isDismissible = true,
      this.barrierColor,
      required this.builder,
      required this.onSubmitted,
      Key? key})
      : super(key: key) {
    customAccessory ??= KeyboardCustomAccessory(builder: () {
      return KeyboardCustomInputWidget(
        onSubmitted: onSubmitted,
        text: text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return builder(() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: false,
          barrierColor: barrierColor,
          isDismissible: isDismissible,
          builder: (context) {
            return _buildAccessoryInput(context);
          });
    });
  }

  Widget _buildAccessoryInput(BuildContext context) {
    Widget current;

    // 输入框上下间距
    double vspace = 8.0;
    double expandHeight = 32.0;

    assert(customAccessory != null);
    current = customAccessory!.builder();
    expandHeight = customAccessory!.height;

    current = Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: vspace),
      color: Colors.white,
      alignment: Alignment.topCenter,
      height:
          MediaQuery.of(context).viewInsets.bottom + expandHeight + vspace * 2,
      child: current,
    );

    return current;
  }
}

