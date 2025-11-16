import 'package:flutter/material.dart';

class TvInput extends StatefulWidget {
  final String label;
  final bool obscure;
  final FocusNode focusNode;
  final TextEditingController controller;

  const TvInput({
    required this.label,
    required this.focusNode,
    required this.controller,
    this.obscure = false,
    super.key,
  });

  @override
  State<TvInput> createState() => _TvInputState();
}

class _TvInputState extends State<TvInput> {
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => isFocused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: isFocused ? 3 : 1,
          color: isFocused ? Colors.white : Colors.grey.shade700,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.25),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.obscure,
        style: const TextStyle(fontSize: 22, color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.label,
          labelStyle: TextStyle(
            color: isFocused ? Colors.white : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
