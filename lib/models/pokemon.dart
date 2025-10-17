class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final double height;
  final double weight;
  final List<String> types;
  final List<String> abilities;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List?)
            ?.map((t) => t['type']['name'].toString())
            .toList() ??
        [];

    final abilities = (json['abilities'] as List?)
            ?.map((a) => a['ability']['name'].toString())
            .toList() ??
        [];

    //  Evitar error de tipo Null → double
    final heightValue = json['height'];
    final weightValue = json['weight'];

    final idValue = json['id'];
    final int idParsed = idValue is int
        ? idValue
        : (idValue is String ? int.tryParse(idValue) ?? 0 : 0);

    return Pokemon(
      id: idParsed,
    name: json['name'] ?? 'Desconocido',
    imageUrl: json['sprites']?['other']?['official-artwork']?['front_default'] ??
      json['sprites']?['front_default'] ??
      '',
    height: (heightValue is int || heightValue is double)
      ? heightValue.toDouble()
      : 0.0,
    weight: (weightValue is int || weightValue is double)
      ? weightValue.toDouble()
      : 0.0,
    types: types,
    abilities: abilities,
  );
  }
}
