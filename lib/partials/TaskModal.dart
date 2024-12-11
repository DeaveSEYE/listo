import 'package:flutter/material.dart';
import 'package:listo/core/api/service.dart';
import 'package:listo/core/theme/ListCategories.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/categorie.dart';
import 'package:listo/core/utils/task.dart';

class TaskModal {
  final BuildContext context;
  final Function onTaskAdded;
  final Task? task; // Laisser `task` nullable pour gérer le cas de l'ajout
  final List<Categorie> categories; // Liste des tâches passée en paramètre
  TaskModal({
    required this.context,
    required this.onTaskAdded,
    required this.categories,
    required this.task, // Initialisez avec la tâche existante
  });

  void showAddTaskModal() {
    final titleController = TextEditingController(text: task?.title ?? '');
    final descriptionController =
        TextEditingController(text: task?.description ?? '');
    // final TextEditingController dateController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();

    Color? selectedCategoryColor;
    String? selectedCategory;
    DateTime? selectedDate;
    Color selectedFlagColor = Colors.grey;
    String prior = "";
    bool isEditing = task != null;

    if (task != null) {
      //print(task!.priority.name);
      selectedFlagColor = flagFromPriority(task!.priority.name);
      prior = task!.priority.name;
    }
    if (task != null) {
      selectedCategory = task!.categorie;
    }
    if (task != null) {
      selectedCategoryColor = task!.categorieColor;
    }
    if (task != null) {
      selectedDate = DateTime.parse(task!.dueDate);
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Row(
                              children: [
                                Icon(Icons.arrow_back),
                                SizedBox(width: 8),
                                Text('Retour', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              String colorName =
                                  getColorName(selectedCategoryColor!);
                              //print(colorName); // Cela renverra "Orange"
                              
                              // Vérifier si les champs sont valides
                              if (titleController.text.isEmpty ||
                                  titleController.text.length < 2) {
                                showErrorMessage(
                                    "Le titre est vide ou trop court (minimum 2 caractères)");
                                return;
                              }

                              if (selectedCategory == null ||
                                  selectedCategory!.isEmpty) {
                                showErrorMessage(
                                    "Veuillez sélectionner une catégorie");
                                return;
                              }

                              if (descriptionController.text.isEmpty ||
                                  descriptionController.text.length < 2) {
                                showErrorMessage(
                                    "La description est vide ou trop courte (minimum 2 caractères)");
                                return;
                              }

                              if (selectedDate == null) {
                                showErrorMessage(
                                    "Veuillez sélectionner une date d'échéance");
                                return;
                              }

                              if (prior.isEmpty) {
                                showErrorMessage(
                                    "Veuillez sélectionner une priorité");
                                return;
                              }

                              final taskData = {
                                'title': titleController.text,
                                'categorie': selectedCategory,
                                'description': descriptionController.text,
                                'dueDate': selectedDate?.toIso8601String(),
                                "priority": prior,
                                "isChecked": false,
                                "categorieColor": colorName
                              };

                              if (isEditing) {
                                print('edition');
                                print(taskData);
                              } else {
                                try {
                                  await ApiService.addTask(taskData);
                                  Navigator.pop(context);
                                  // Mise à jour de la liste des tâches
                                  //  await _fetchTasks();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Tâche ajoutée avec succès!')),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Erreur: $e')),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: Text(
                              isEditing ? 'Modifier' : 'Enregistrer',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Nom de la tâche',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListCategories(
                        //tasks: tasks, // Liste des tâches
                        categories: categories, // Liste des tâches
                        onCategorySelected: (category, color) {
                          setState(() {
                            selectedCategory = category;
                            selectedCategoryColor = color;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              setState(() {
                                selectedDate = picked;
                              });
                            },
                            child: Column(
                              children: [
                                const Icon(Icons.calendar_today, size: 24),
                                if (task != null)
                                  Text(
                                    // Afficher la date de la tâche sous forme de jour/mois/année
                                    "${DateTime.parse(task!.dueDate).day}/${DateTime.parse(task!.dueDate).month}/${DateTime.parse(task!.dueDate).year}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                if (selectedDate != null)
                                  Text(
                                    "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for (var color in [
                                        Colors.green,
                                        Colors.yellow,
                                        Colors.red
                                      ])
                                        IconButton(
                                          icon: Icon(Icons.flag, color: color),
                                          onPressed: () {
                                            setState(() {
                                              selectedFlagColor = color;
                                              priorityController.text =
                                                  selectedFlagColor.toString();

                                              // Définir automatiquement la priorité
                                              prior = priorityFromColorString(
                                                  priorityController.text);
                                              print('Priorité : $prior');
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.flag,
                                color: selectedFlagColor, size: 24),
                          ),
                          if (selectedCategory != null)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                label: Text(
                                  '$selectedCategory',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                backgroundColor:
                                    selectedCategoryColor, // Couleur de fond basée sur la catégorie sélectionnée
                              ),
                            ),
                          if (task != null)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                label: Text(
                                  task!.categorie,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                backgroundColor: task!
                                    .categorieColor, // Couleur de fond basée sur la catégorie sélectionnée
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Description de la tâche',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Utility methods
  String getColorName(Color color) {
    // print(color.value); // Affiche la valeur de la couleur

    // Comparaison avec les couleurs personnalisées en utilisant leurs valeurs hexadécimales
    if (color.value == Color(0xffff0000).value) {
      // Red
      return "Color(0xffff0000)";
    } else if (color.value == Color(0xff008000).value) {
      // Green
      return "green";
    } else if (color.value == Color(0xffffff00).value) {
      // Yellow
      return "yellow";
    } else if (color.value == Color(0xff0000ff).value) {
      // Blue
      return "blue";
    } else if (color.value == Color(0xffffa500).value) {
      // Orange
      return "orange";
    } else if (color.value == Color(0xff800080).value) {
      // Purple
      return "purple";
    } else if (color.value == Color(0xffffc0cb).value) {
      // Pink
      return "pink";
    } else if (color.value == Color(0xffa52a2a).value) {
      // Brown
      return "brown";
    } else if (color.value == Color(0xff808080).value) {
      // Grey
      return "grey";
    } else if (color.value == Color(0xff000000).value) {
      // Black
      return "black";
    } else if (color.value == Color(0xffffffff).value) {
      // White
      return "white";
    } else {
      // Si la couleur ne correspond à aucune des prédéfinies
      return "Unknown";
    }
  }

  String priorityFromColorString(String colorString) {
    String colorName = getColorNameFromToString(colorString);

    return (colorName == "red")
        ? "eleve"
        : (colorName == "green")
            ? "basse"
            : (colorName == "yellow")
                ? "moyenne"
                : "inconnue";
  }

  Color flagFromPriority(String priority) {
    switch (priority) {
      case 'eleve':
        return Colors.red;
      case 'moyenne':
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  String getColorNameFromToString(String colorString) {
    if (colorString.contains('Color(0xff4caf50)')) {
      return "green"; // Colors.green
    }
    if (colorString.contains('Color(0xffffeb3b)')) {
      return "yellow"; // Colors.yellow
    }
    if (colorString.contains('Color(0xfff44336)')) return "red"; // Colors.red
    return "unknown"; // Si la couleur n'est pas reconnue
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
