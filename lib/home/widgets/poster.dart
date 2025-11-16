import 'package:flutter/material.dart';

class TvPoster extends StatefulWidget {
  final int imageIndex;

  const TvPoster({required this.imageIndex, super.key});

  @override
  State<TvPoster> createState() => _TvPosterState();
}

class _TvPosterState extends State<TvPoster> {
  final focusNode = FocusNode();
  bool focused = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() => focused = focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    focusNode.dispose(); // libera o foco para evitar vazamentos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: focusNode,
      onFocusChange: (f) => setState(() => focused = f),
      child: Transform.scale(
        scale: focused ? 1.12 : 1.0,
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          width: 180,
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage("assets/posters/${widget.imageIndex % 6}.jpg"),
              fit: BoxFit.cover,
            ),
            boxShadow: focused
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
