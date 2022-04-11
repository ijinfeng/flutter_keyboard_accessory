import 'package:flutter/material.dart';

typedef AccessoryChildBuilder = Widget Function(VoidCallback awake);
double _kDefaultKeyboardAccessoryHeight = 44.0;

class KeyboardAccessory extends StatelessWidget {
  final AccessoryChildBuilder builder;

  /// 自定义键盘辅助输入框
  final Widget? customAccessory;

  final FocusNode _node = FocusNode();

  /// 点击空白处关闭
  final bool isDismissible;

  final Color? barrierColor;

  final ValueChanged<String>? onSubmitted;

  final GlobalKey<_AccessoryContainerState> _globalKey = GlobalKey<_AccessoryContainerState>();
  late Widget? _globalAccessoryWidget;

  KeyboardAccessory(
      {this.customAccessory,
      this.isDismissible = true,
      this.barrierColor,
      required this.builder,
      this.onSubmitted,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (customAccessory != null) {
      _globalAccessoryWidget = _AccessoryContainer(key: _globalKey, child: customAccessory,);
      print(_globalAccessoryWidget?.key);
    }
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

    current = TextField(
      focusNode: _node,
      autofocus: true,
      onSubmitted: onSubmitted,
    );

    double vspace = 4;
    double expandHeight = _kDefaultKeyboardAccessoryHeight;
    if (_globalAccessoryWidget != null) {
      print(_globalKey.currentState.toString());
       expandHeight = _globalKey.currentContext?.findRenderObject()?.semanticBounds.size.height ?? 0;
    }

    current = Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: vspace),
      color: Colors.white,
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).viewInsets.bottom +
          expandHeight +
          vspace * 2,
      child: customAccessory ?? current,
    );

    return current;
  }
}

class _AccessoryContainer extends StatefulWidget {
  final Widget? child;
  const _AccessoryContainer({required this.child, Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _AccessoryContainerState();
}

class _AccessoryContainerState extends State<_AccessoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
