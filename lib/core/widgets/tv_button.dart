import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  return Focus(
    focusNode: widget.focusNode,
    child: GestureDetector(
      onTap: widget.onPressed,
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) => widget.onPressed(),
            ),
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: widget.focusNode.hasFocus ? Colors.white : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                color: widget.focusNode.hasFocus ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
