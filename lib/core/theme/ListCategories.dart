import 'package:flutter/material.dart';
import 'package:listo/core/utils/task.dart';

class ListCategories extends StatefulWidget {
  final List<Task> tasks; // Liste des tâches

  const ListCategories({super.key, required this.tasks});

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  // Méthode pour extraire les catégories et leurs couleurs uniques
  Map<String, Color> _extractCategories() {
    final Map<String, Color> categories = {};
    for (var task in widget.tasks) {
      if (!categories.containsKey(task.categorie)) {
        categories[task.categorie] = task.categorieColor; // Ajoute la catégorie et sa couleur
      }
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final categories = _extractCategories(); // Récupère les catégories et leurs couleurs

    return SizedBox(
      height: 50, // Définissez une hauteur pour que les Chips s'affichent correctement
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Active le défilement horizontal
        child: Row(
          children: categories.entries.map((entry) {
            final category = entry.key;
            final color = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0), // Espacement entre les Chips
              child: Chip(
                label: Text(category), // Affiche le nom de la catégorie
                backgroundColor: color, // Couleur de fond 
                labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // Texte de la couleur de la catégorie
                padding: const EdgeInsets.all(5), // Padding interne du Chip
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
