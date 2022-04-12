import 'package:flutter/material.dart';

const double kDefaultKeyboardAccessoryHeight = 32.0;

class KeyboardCustomInputWidget extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final String? text;
  final double height;

  const KeyboardCustomInputWidget(
      {required this.onSubmitted, this.text, this.height = kDefaultKeyboardAccessoryHeight, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeyboardCustomInputWidgetState();
}

class _KeyboardCustomInputWidgetState extends State<KeyboardCustomInputWidget> {
  late final TextEditingController _controller;
  final FocusNode _node = FocusNode();
  bool _hasInputText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      _setNeedsUpdate(_controller.text.isNotEmpty);
    });
  }

  void _setNeedsUpdate(bool hasText) {
    if (hasText == _hasInputText) return;
    setState(() {
      _hasInputText = hasText;
    });
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentScpeNode = FocusScope.of(context);
    if (currentScpeNode.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  void _hideKeyboardAndPop(BuildContext context) {
    _hideKeyboard(context);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Color(0xffEEEEEE), width: 0.5));

    if (widget.text != null) {
      _controller.text = widget.text!;
    }

    Widget cleanButton = IconButton(
        onPressed: () {
          _controller.clear();
        },
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.close,
          color: Color(0xff333333),
        ));

    Widget input = SizedBox(
        height: kDefaultKeyboardAccessoryHeight,
        width: double.infinity,
        child: TextField(
          focusNode: _node,
          autofocus: true,
          cursorColor: const Color(0xffF20000),
          onSubmitted: (text) {
            widget.onSubmitted(text);
            _hideKeyboardAndPop(context);
          },
          controller: _controller,
          // cursorHeight: 14,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              fillColor: const Color(0xffF8F8F8),
              filled: true,
              hintText: '输入选项内容',
              hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffCCCCCC)),
              contentPadding: const EdgeInsets.only(left: 12, right: 12),
              // 边框
              border: inputBorder,
              // 获取焦点状态
              focusedBorder: inputBorder,
              // 可编辑状态
              enabledBorder: inputBorder,
              suffixIcon: _hasInputText ? cleanButton : null),
        ));

    Widget appendButton = GestureDetector(
      child: Container(
        width: 60,
        height: kDefaultKeyboardAccessoryHeight,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(kDefaultKeyboardAccessoryHeight / 2)),
            gradient: _hasInputText
                ? const LinearGradient(
                    colors: [Color(0xffFF227E), Color(0xffFF2F0F)])
                : LinearGradient(colors: [
                    const Color(0xff333333).withOpacity(0.3),
                    const Color(0xff333333).withOpacity(0.3)
                  ])),
        child: const Center(
          child: Text(
            '新增',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
      onTap: _hasInputText
          ? () {
              widget.onSubmitted(_controller.text);
              _hideKeyboardAndPop(context);
            }
          : null,
    );
    appendButton = Padding(
      padding: const EdgeInsets.only(left: 12),
      child: appendButton,
    );

    return Row(
      children: [Expanded(child: input), appendButton],
    );
  }
}
