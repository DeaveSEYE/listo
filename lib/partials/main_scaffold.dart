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
