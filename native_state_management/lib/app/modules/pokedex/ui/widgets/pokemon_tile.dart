import 'package:flutter/material.dart';
import 'package:native_state_management/app/core/utils/string_extension.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';
import 'dart:math' as math;

class PokemonTile extends StatefulWidget {
  final Pokemon p;
  const PokemonTile({
    required this.p,
    super.key,
  });

  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

class _PokemonTileState extends State<PokemonTile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xFFEB2E52),
        ),
        child: SizedBox(
          width: 350,
          height: 80,
          child: Stack(
            children: [
              Positioned(
                left: -40,
                bottom: -35,
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'pokeball.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.p.frontDefault != null)
                        AspectRatio(
                          aspectRatio: 0.8,
                          child: Image.network(
                            widget.p.frontDefault!,
                          ),
                        ),
                      Text(
                        widget.p.name.capitalize(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 30,
                      top: 25,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 0.3,
                        child: Text(
                          getMaskedId(
                            widget.p.id.toString(),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getMaskedId(String s) {
  if (s.length < 3) {
    final int nZeros = 3 - s.length;

    for (int i = 0; i < nZeros; i++) {
      s = "0$s";
    }
    return '#$s';
  } else {
    return '#$s';
  }
}
