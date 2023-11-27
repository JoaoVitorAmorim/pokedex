import 'package:flutter/material.dart';

class PokemonIntro extends StatefulWidget {
  const PokemonIntro({super.key});

  @override
  State<PokemonIntro> createState() => _PokemonIntroState();
}

class _PokemonIntroState extends State<PokemonIntro>
    with SingleTickerProviderStateMixin {
  Offset? position;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void initState() {
    position = const Offset(0.0, 0.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static double smallLogo = 200;
  static double bigLogo = 300;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size biggest = constraints.biggest;
      return Stack(
        children: <Widget>[
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromSize(
                Rect.fromLTWH(0, 0, smallLogo, smallLogo),
                biggest,
              ),
              end: RelativeRect.fromSize(
                Rect.fromLTWH(biggest.width - bigLogo, biggest.height - bigLogo,
                    bigLogo, bigLogo),
                biggest,
              ),
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.linear,
            )),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.asset('intro.gif'),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
