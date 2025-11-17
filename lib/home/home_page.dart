import 'package:flutter/material.dart';
import 'widgets/poster.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  bool showButtons1 = false;
  bool showButtons2 = false;

  final double itemWidth = 198; // 180 poster + 18 padding
  final int totalItems1 = 9;  // imagens 0–11
  final int totalItems2 = 9;   // imagens 9–17

  void scrollRight(ScrollController controller, int totalItems) {
    double nextOffset = controller.offset + itemWidth;
    if (nextOffset >= itemWidth * (totalItems - 1)) nextOffset = 0;
    controller.animateTo(nextOffset,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void scrollLeft(ScrollController controller, int totalItems) {
    double nextOffset = controller.offset - itemWidth;
    if (nextOffset < 0) nextOffset = itemWidth * (totalItems - 1);
    controller.animateTo(nextOffset,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Widget buildCarousel({
    required String title,
    required ScrollController controller,
    required int totalItems,
    required bool showButtons,
    required Function(bool) setShowButtons,
    int startIndex = 0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, bottom: 10),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 260,
          child: MouseRegion(
            onEnter: (_) => setShowButtons(true),
            onExit: (_) => setShowButtons(false),
            child: Stack(
              children: [
                ListView.builder(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: totalItems,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: TvPoster(imageIndex: startIndex + i),
                  ),
                ),
                // Botão esquerda
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: showButtons ? 1 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: _ScrollButton(
                      icon: Icons.chevron_left,
                      onPressed: () => scrollLeft(controller, totalItems),
                    ),
                  ),
                ),
                // Botão direita
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: showButtons ? 1 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: _ScrollButton(
                      icon: Icons.chevron_right,
                      onPressed: () => scrollRight(controller, totalItems),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          // Primeiro carrossel: imagens 0–11
          buildCarousel(
            title: "Recomendados",
            controller: _scrollController1,
            totalItems: totalItems1,
            showButtons: showButtons1,
            setShowButtons: (v) => setState(() => showButtons1 = v),
            startIndex: 0,
          ),
          // Segundo carrossel: imagens 9–17
          buildCarousel(
            title: "Pinturas",
            controller: _scrollController2,
            totalItems: totalItems2,
            showButtons: showButtons2,
            setShowButtons: (v) => setState(() => showButtons2 = v),
            startIndex: 9,
          ),
        ],
      ),
    );
  }
}

class _ScrollButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ScrollButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.black.withOpacity(0.15),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Icon(icon, color: Colors.white.withOpacity(0.6), size: 22),
          ),
        ),
      ),
    );
  }
}
