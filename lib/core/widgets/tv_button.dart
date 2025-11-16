import 'package:flutter/material.dart';

class TvButton extends StatefulWidget {
  final String title;
  final FocusNode focusNode;
  final VoidCallback onPressed;

  const TvButton({
    required this.title,
    required this.focusNode,
    required this.onPressed,
    super.key,
  });

  @override
  State<TvButton> createState() => _TvButtonState();
}

class _TvButtonState extends State<TvButton> {
  bool focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => focused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: widget.focusNode,
      onFocusChange: (f) => setState(() => focused = f),
      actions: {
        ActivateIntent: CallbackAction(onInvoke: (_) {
          widget.onPressed();
          return null;
        })
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          color: focused ? Colors.white : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 22,
            color: focused ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
