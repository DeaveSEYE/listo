// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:listo/core/api/service.dart';
import 'package:listo/core/theme/ListCategories.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/categorie.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/features/home/ui/home.dart';
import 'package:listo/features/tasks/ui/tasklist.dart';
import 'package:listo/features/calendar/ui/calendar.dart';
import 'package:listo/features/profile/ui/profile.dart';
import 'package:listo/partials/app_bar.dart';
import 'package:listo/partials/floating_action_button.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  List<Task> tasks = [];
  List<Categorie> categories = []; // Liste des catégories
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
    _fetchCategories();
  }

  Future<void> _fetchTasks() async {
    try {
      final fetchedTasks = await ApiService.fetchTasks();
      setState(() {
        tasks = fetchedTasks;
        isLoading = false;
        //print(tasks);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Impossible de charger la liste des taches : $e')),
      );
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final fetchedCategories = await ApiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
        //isLoading = false;
        //print(tasks);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Impossible de charger la liste des categories : $e')),
      );
    }
  }

  void setCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : [
              Home(tasks: tasks, categories: categories),
              Tasklist(tasks: tasks, categories: categories),
              CalendarPage(tasks: tasks),
              const ProfileScreen(),
            ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primary,
        selectedItemColor: const Color.fromARGB(255, 240, 244, 247),
        unselectedItemColor: AppColors.background,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tâches'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (index) => setCurrentIndex(index),
      ),
      floatingActionButton: Builder(
        builder: (context) => CustomFloatingActionButton(
          onPressed: () {
            _showAddTaskModal(context);
          },
          icon: Icons.add,
        ),
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    // final TextEditingController dateController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();

    Color? selectedCategoryColor;
    String? selectedCategory;
    DateTime? selectedDate;
    Color selectedFlagColor = Colors.grey;
    Color selectedPaletteColor = Colors.grey;
    String prior = "";
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
                              // Collect data and send to API

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
                                "isChecked": "0",
                                "categorieColor": colorName
                              };

                              try {
                                await ApiService.addTask(taskData);
                                Navigator.pop(context);
                                // Mise à jour de la liste des tâches
                                await _fetchTasks();
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
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: const Text(
                              'Enregistrer',
                              style: TextStyle(color: Colors.white),
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

                                              // selectedFlagColor = color;
                                              // priorityController.text =
                                              //   selectedFlagColor.toString();
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
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      for (var color in [
                                        Colors.blue,
                                        Colors.green,
                                        Colors.red,
                                        Colors.orange,
                                        Colors.purple,
                                        Colors.pink,
                                        Colors.yellow
                                      ])
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedPaletteColor = color;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.palette,
                                color: selectedPaletteColor, size: 24),
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

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
