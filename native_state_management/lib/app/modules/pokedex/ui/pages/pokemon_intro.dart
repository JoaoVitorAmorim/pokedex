import 'package:flutter/material.dart';

class PokemonIntro extends StatefulWidget {
  const PokemonIntro({super.key});

  @override
  State<PokemonIntro> createState() => _PokemonIntroState();
}

class _PokemonIntroState extends State<PokemonIntro> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            const Text(
              'LAUCHING YOUR POKEDEX 😊',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Expanded(child: Image.asset('intro.gif')),
          ],
        ),
      ),
    );
  }
}
