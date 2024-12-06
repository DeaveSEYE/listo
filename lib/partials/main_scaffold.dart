<<<<<<< HEAD
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
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:listo/core/theme/ListCategories.dart';
import 'package:listo/partials/app_bar.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/features/calendar/ui/calendar.dart';
import 'package:listo/features/home/ui/home.dart';
import 'package:listo/features/profile/ui/profile.dart';
import 'package:listo/features/tasks/ui/tasklist.dart';
import 'package:listo/partials/floating_action_button.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Liste des tâches
  List<Task> tasks = [
    Task(
      id: 1,
      title: "Design application Flutter",
      date: "03-11-2024 10h-00",
      categorie: "Design",
      categorieColor: Colors.blue,
      flagColor: Colors.blue,
      isChecked: false,
    ),
    Task(
        id: 2,
        title: "Meeting avec l'équipe",
        date: "03-11-2024 14h-00",
        categorie: "Réunion",
        categorieColor: Colors.green,
        flagColor: Colors.green,
        isChecked: true,
        priority: Priority.basse),
    Task(
        id: 3,
        title: "Meeting ",
        date: "03-11-2024 14h-00",
        categorie: "Réunion",
        categorieColor: Colors.green,
        flagColor: Colors.green,
        isChecked: false,
        priority: Priority.basse),
    Task(
        id: 4,
        title: "Révision des spécifications",
        date: "10-11-2024 17h-00",
        categorie: "Travail",
        categorieColor: Colors.orange,
        flagColor: Colors.orange,
        isChecked: false,
        priority: Priority.moyenne),
    Task(
        id: 5,
        title: "Révision des spécifications",
        date: "16-11-2024 17h-00",
        categorie: "dance",
        categorieColor: const Color.fromARGB(255, 255, 0, 0),
        flagColor: const Color.fromARGB(255, 255, 0, 0),
        isChecked: true,
        priority: Priority.eleve),
    Task(
        id: 6,
        title: "Révision des spécifications",
        date: "18-11-2024 17h-00",
        categorie: "escrime",
        categorieColor: const Color.fromARGB(255, 234, 255, 0),
        flagColor: const Color.fromARGB(255, 234, 255, 0),
        isChecked: true,
        priority: Priority.eleve),
    Task(
        id: 7,
        title: "Révision des spécifications",
        date: "20-11-2024 17h-00",
        categorie: "sky",
        categorieColor: const Color.fromARGB(54, 111, 44, 227),
        flagColor: const Color.fromARGB(54, 111, 44, 227),
        isChecked: false,
        priority: Priority.moyenne),
    Task(
        id: 8,
        title: "Révision des spécifications",
        date: "18-11-2024 17h-00",
        categorie: "marche",
        categorieColor: const Color.fromARGB(255, 0, 255, 242),
        flagColor: const Color.fromARGB(255, 0, 255, 242),
        isChecked: true,
        priority: Priority.moyenne),
  ];

  setCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      //resizeToAvoidBottomInset:
      // false, // Désactive le redimensionnement automatique lié au clavier
      appBar: const CustomAppBar(),
      body: [
        // Liste des pages affichées en fonction de l'index sélectionné
        Home(tasks: tasks), // Passez la liste des tâches à Home
        Tasklist(
          tasks: tasks, // Passez la liste des tâches à Tasklist
        ),
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
    DateTime? selectedDate;
    Color selectedFlagColor = Colors.grey;
    Color selectedPaletteColor = Colors.grey;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled:
          true, // Important pour permettre au modal de se redimensionner
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Ajout dynamique de padding pour éviter le clavier
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
                            onPressed: () {
                              // Logic to save the task
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: const Text('Enregistrer',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Nom de la tâche',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListCategories(tasks: tasks),
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
                              if (picked != null) {
                                setState(() {
                                  selectedDate = picked;
                                });
                              }
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
                                      IconButton(
                                        icon: const Icon(Icons.flag,
                                            color: Colors.green),
                                        onPressed: () {
                                          setState(() {
                                            selectedFlagColor = Colors.green;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.flag,
                                            color: Colors.yellow),
                                        onPressed: () {
                                          setState(() {
                                            selectedFlagColor = Colors.yellow;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.flag,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            selectedFlagColor = Colors.red;
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
                        ],
                      ),
                      const SizedBox(height: 8),
                      const TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
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
}
=======
import 'package:flutter/material.dart';
import 'package:listo/core/theme/ListCategories.dart';
import 'package:listo/partials/app_bar.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/features/calendar/ui/calendar.dart';
import 'package:listo/features/home/ui/home.dart';
import 'package:listo/features/profile/ui/profile.dart';
import 'package:listo/features/tasks/ui/tasklist.dart';
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
import 'package:listo/partials/floating_action_button.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
<<<<<<< HEAD
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
=======

  // Liste des tâches
  List<Task> tasks = [
    Task(
      id: 1,
      title: "Design application Flutter",
      description: "Design application Flutter",
      categorie: "Design",
      createdAt: "03-11-2024 10h-00",
      updatedAt: "03-11-2024 10h-00",
      dueDate: "03-11-2024 10h-00",
      categorieColor: Colors.blue,
      isChecked: false,
      priority: Priority.basse,
    ),
    Task(
        id: 2,
        title: "Meeting avec l'équipe",
        description: "Meeting avec l'équipe",
        createdAt: "03-11-2024 14h-00",
        updatedAt: "03-11-2024 10h-00",
        dueDate: "03-11-2024 10h-00",
        categorie: "Réunion",
        categorieColor: Colors.green,
        isChecked: true,
        priority: Priority.basse),
    Task(
        id: 3,
        title: "Meeting ",
        description: "Meeting",
        createdAt: "03-11-2024 14h-00",
        updatedAt: "03-11-2024 10h-00",
        dueDate: "03-11-2024 10h-00",
        categorie: "Réunion",
        categorieColor: Colors.green,
        isChecked: false,
        priority: Priority.basse),
    Task(
        id: 4,
        title: "Révision des spécifications",
        description: "Révision des spécifications",
        createdAt: "10-11-2024 17h-00",
        updatedAt: "10-11-2024 10h-00",
        dueDate: "10-11-2024 10h-00",
        categorie: "Travail",
        categorieColor: Colors.orange,
        isChecked: false,
        priority: Priority.moyenne),
    Task(
        id: 5,
        title: "Révision des spécifications",
        description: "Révision des spécifications",
        createdAt: "16-11-2024 17h-00",
        updatedAt: "16-11-2024 10h-00",
        dueDate: "16-11-2024 10h-00",
        categorie: "dance",
        categorieColor: const Color.fromARGB(255, 255, 0, 0),
        isChecked: true,
        priority: Priority.eleve),
    Task(
        id: 6,
        title: "Révision des spécifications",
        description: "Révision des spécifications",
        createdAt: "18-11-2024 17h-00",
        updatedAt: "18-11-2024 10h-00",
        dueDate: "18-11-2024 10h-00",
        categorie: "escrime",
        categorieColor: const Color.fromARGB(255, 234, 255, 0),
        isChecked: true,
        priority: Priority.eleve),
    Task(
        id: 7,
        title: "Révision des spécifications",
        description: "Révision des spécifications",
        createdAt: "20-11-2024 17h-00",
        updatedAt: "20-11-2024 10h-00",
        dueDate: "20-11-2024 10h-00",
        categorie: "sky",
        categorieColor: const Color.fromARGB(54, 111, 44, 227),
        isChecked: false,
        priority: Priority.moyenne),
    Task(
        id: 8,
        title: "Révision des spécifications",
        description: "Révision des spécifications",
        createdAt: "18-11-2024 17h-00",
        updatedAt: "18-11-2024 10h-00",
        dueDate: "18-11-2024 10h-00",
        categorie: "marche",
        categorieColor: const Color.fromARGB(255, 0, 255, 242),
        isChecked: true,
        priority: Priority.moyenne),
  ];

  setCurrentIndex(int index) {
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
<<<<<<< HEAD
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : [
              Home(tasks: tasks, categories: categories),
              Tasklist(tasks: tasks, categories: categories),
              CalendarPage(tasks: tasks),
              const ProfileScreen(),
            ][_selectedIndex],
=======
      //resizeToAvoidBottomInset:
      // false, // Désactive le redimensionnement automatique lié au clavier
      appBar: const CustomAppBar(),
      body: [
        // Liste des pages affichées en fonction de l'index sélectionné
        Home(tasks: tasks), // Passez la liste des tâches à Home
        Tasklist(
          tasks: tasks, // Passez la liste des tâches à Tasklist
        ),
        CalendarPage(tasks: tasks),
        const ProfileScreen(),
      ][_selectedIndex],
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
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
<<<<<<< HEAD
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
=======
    DateTime? selectedDate;
    Color selectedFlagColor = Colors.grey;
    Color selectedPaletteColor = Colors.grey;

>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
<<<<<<< HEAD
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
=======
      isScrollControlled:
          true, // Important pour permettre au modal de se redimensionner
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Ajout dynamique de padding pour éviter le clavier
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
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
<<<<<<< HEAD
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
=======
                            onPressed: () {
                              // Logic to save the task
                              Navigator.pop(context);
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
<<<<<<< HEAD
                            child: const Text(
                              'Enregistrer',
                              style: TextStyle(color: Colors.white),
                            ),
=======
                            child: const Text('Enregistrer',
                                style: TextStyle(color: Colors.white)),
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
<<<<<<< HEAD
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
=======
                      const TextField(
                        decoration: InputDecoration(
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
                          hintText: 'Nom de la tâche',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
<<<<<<< HEAD
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
=======
                      ListCategories(tasks: tasks),
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
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
                              if (picked != null) {
                                setState(() {
                                  selectedDate = picked;
                                });
                              }
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
<<<<<<< HEAD
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
=======
                                      IconButton(
                                        icon: const Icon(Icons.flag,
                                            color: Colors.green),
                                        onPressed: () {
                                          setState(() {
                                            selectedFlagColor = Colors.green;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.flag,
                                            color: Colors.yellow),
                                        onPressed: () {
                                          setState(() {
                                            selectedFlagColor = Colors.yellow;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.flag,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            selectedFlagColor = Colors.red;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
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
<<<<<<< HEAD
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
=======
                        ],
                      ),
                      const SizedBox(height: 8),
                      const TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
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
<<<<<<< HEAD

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
=======
}
>>>>>>> 21e5289 (initial commit)
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
