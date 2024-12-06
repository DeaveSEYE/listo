<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:listo/core/api/service.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/categorie.dart';

class ListCategories extends StatefulWidget {
  // final List<Task> tasks;
  final List<Categorie> categories; // Liste des tâches passée en paramètre
  final Function(String category, Color color) onCategorySelected;

  const ListCategories({
    super.key,
    //required this.tasks,
    required this.categories,
    required this.onCategorySelected,
  });
=======
import 'package:flutter/material.dart';
import 'package:listo/core/utils/task.dart';

class ListCategories extends StatefulWidget {
  final List<Task> tasks; // Liste des tâches

  const ListCategories({super.key, required this.tasks});
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
<<<<<<< HEAD
  String? selectedCategory;
  Color? selectedCategoryColor;
  Map<String, Color> categories = {};

  @override
  void initState() {
    super.initState();
    categories = _extractCategories();
  }

  Map<String, Color> _extractCategories() {
    final Map<String, Color> categories = {};
    for (var categorie in widget.categories) {
      if (!categories.containsKey(categorie.categorie)) {
        categories[categorie.categorie] = categorie.categorieColor;
=======
  // Méthode pour extraire les catégories et leurs couleurs uniques
  Map<String, Color> _extractCategories() {
    final Map<String, Color> categories = {};
    for (var task in widget.tasks) {
      if (!categories.containsKey(task.categorie)) {
        categories[task.categorie] = task.categorieColor; // Ajoute la catégorie et sa couleur
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
      }
    }
    return categories;
  }

<<<<<<< HEAD
  void _addCategory(String name, Color color) {
    setState(() {
      categories[name] = color;
    });
  }

  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController categoryNameController =
        TextEditingController();
    Color? selectedColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ajouter une nouvelle catégorie"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: categoryNameController,
                    decoration: const InputDecoration(
                      labelText: "Nom de la catégorie",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: Colors.primaries.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: color,
                          child: selectedColor == color
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () async {
                final categoryName = categoryNameController.text.trim();

                if (categoryName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Veuillez entrer un nom pour la catégorie."),
                    ),
                  );
                  return;
                }
                if (selectedColor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Veuillez sélectionner une couleur."),
                    ),
                  );
                  return;
                }
                print(
                    "#${selectedColor!.value.toRadixString(16).substring(2).toUpperCase()}");
                final categoryData = {
                  'categorie': categoryName,
                  'categorieColor':
                      "#${selectedColor!.value.toRadixString(16).substring(2).toUpperCase()}",
                };

                try {
                  await ApiService.addCategory(categoryData);
                  _addCategory(categoryName, selectedColor!);
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Erreur: $e"),
                    ),
                  );
                }
              },
              child: const Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () => _showAddCategoryDialog(context),
                    child: const Chip(
                      label: Icon(Icons.add, color: AppColors.primary),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                ...categories.entries.map((entry) {
                  final category = entry.key;
                  final color = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                          selectedCategoryColor = color;
                        });
                        widget.onCategorySelected(category, color);
                      },
                      child: Chip(
                        label: Text(category),
                        backgroundColor: selectedCategory == category
                            ? color.withOpacity(0.7)
                            : color,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.all(5),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
=======
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
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
    );
  }
}
