import 'package:flutter/material.dart';
import 'widgets/poster.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 80, left: 30),
        children: [
          const Text("Recomendados", 
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: List.generate(
              12,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 18),
                child: TvPoster(imageIndex: i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
