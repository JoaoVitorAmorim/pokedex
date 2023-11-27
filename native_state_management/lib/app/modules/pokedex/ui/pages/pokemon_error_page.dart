import 'package:flutter/material.dart';

class PokemonErrorPage extends StatefulWidget {
  const PokemonErrorPage({super.key});

  @override
  State<PokemonErrorPage> createState() => _PokemonErrorPageState();
}

class _PokemonErrorPageState extends State<PokemonErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: const Color(0xFFF7F7F7),
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 90.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Something went wrong',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'please try again later...',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFEB2E52),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Try again now',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset('pikachu.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
