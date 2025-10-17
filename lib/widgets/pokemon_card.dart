import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../screens/pokemon_detail.dart';
import '../utils/type_colors.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final mainType = pokemon.types.isNotEmpty ? pokemon.types.first : 'Normal';
    final bgColor = TypeColors.getColor(mainType);

    return Hero(
      tag: pokemon.name,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => PokemonDetailPage(pokemon: pokemon),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO((bgColor.r * 255.0).round() & 0xff, (bgColor.g * 255.0).round() & 0xff, (bgColor.b * 255.0).round() & 0xff, 0.85),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO((bgColor.r * 255.0).round() & 0xff, (bgColor.g * 255.0).round() & 0xff, (bgColor.b * 255.0).round() & 0xff, 0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Franja superior con el color del tipo
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Color.fromRGBO((bgColor.r * 255.0).round() & 0xff, (bgColor.g * 255.0).round() & 0xff, (bgColor.b * 255.0).round() & 0xff, 1.0),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Número del Pokémon (id real)
                    Text(
                      '#${pokemon.id}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Imagen
                    Image.network(
                      pokemon.imageUrl.isNotEmpty ? pokemon.imageUrl : 'https://via.placeholder.com/96',
                      height: 80,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 80,
                          child: Center(child: Icon(Icons.broken_image, size: 40, color: Colors.white70)),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // Nombre
                    Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Tipo principal
                    Text(
                      mainType,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
