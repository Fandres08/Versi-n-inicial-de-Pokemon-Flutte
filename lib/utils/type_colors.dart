import 'package:flutter/material.dart';

class TypeColors {
  static Color getColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'psychic':
        return Colors.purpleAccent;
      case 'ice':
        return Colors.cyanAccent;
      case 'bug':
        return Colors.lightGreen;
      case 'ground':
        return Colors.brown;
      case 'rock':
        return Colors.grey;
      case 'poison':
        return Colors.deepPurple;
      case 'flying':
        return Colors.indigoAccent;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.black54;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      case 'normal':
      default:
        return Colors.redAccent; 
    }
  }
}

