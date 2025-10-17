import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/api_service.dart';
import '../utils/type_colors.dart';
import 'pokemon_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    final pokemons = await _apiService.fetchPokemons();
    setState(() {
      _pokemons = pokemons;
      _filteredPokemons = pokemons;
      _isLoading = false;
    });
  }

  void _filterPokemons(String query) {
    final filtered = _pokemons
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchQuery = query;
      _filteredPokemons = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon fabio alfonso'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          //  Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterPokemons,
              decoration: InputDecoration(
                hintText: 'Buscar Pokémon...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredPokemons.isEmpty
                    ? const Center(
                        child: Text(
                          'No se encontraron Pokémon 😢',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _filteredPokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = _filteredPokemons[index];
                          final mainType = pokemon.types.isNotEmpty
                              ? pokemon.types.first
                              : 'normal';
                          final color = TypeColors.getColor(mainType);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (_, __, ___) =>
                                      PokemonDetailPage(pokemon: pokemon),
                                ),
                              );
                            },
                            child: Hero(
                              tag: pokemon.name,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                color: color.withOpacity(0.8),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //  Número del Pokémon
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, right: 12),
                                        child: Text(
                                          '#${pokemon.id}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //  Imagen
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Image.network(
                                          pokemon.imageUrl,
                                          fit: BoxFit.contain,
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) return child;
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                        ),
                                      ),
                                    ),

                                    // 📛 Nombre
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12, top: 4),
                                      child: Text(
                                        pokemon.name.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),

          // Mostrar resultados de búsqueda
          if (_searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '"$_searchQuery" → ${_filteredPokemons.length} resultados',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }
}

