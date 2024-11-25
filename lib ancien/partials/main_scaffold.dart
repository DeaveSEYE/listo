import 'package:flutter/material.dart';
import 'package:listo/partials/app_bar.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/features/calendar/ui/calendar.dart';
import 'package:listo/features/home/ui/home.dart';
import 'package:listo/features/profile/ui/profile.dart';
import 'package:listo/features/tasks/ui/tasklist.dart';

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
      priority:  Priority.basse
    ),
        Task(
           id: 3,
      title: "Meeting ",
      date: "03-11-2024 14h-00",
      categorie: "Réunion",
      categorieColor: Colors.green,
      flagColor: Colors.green,
      isChecked: false,
      priority:  Priority.basse
    ),
    Task(
       id: 4,
      title: "Révision des spécifications",
      date: "10-11-2024 17h-00",
      categorie: "Travail",
      categorieColor: Colors.orange,
      flagColor: Colors.orange,
      isChecked: false,
      priority:  Priority.moyenne
    ),
        Task(
       id: 5,
      title: "Révision des spécifications",
      date: "16-11-2024 17h-00",
      categorie: "dance",
      categorieColor: const Color.fromARGB(255, 255, 0, 0),
      flagColor: const Color.fromARGB(255, 255, 0, 0),
      isChecked: true,
      priority:  Priority.eleve
    ),
        Task(
       id: 6,
      title: "Révision des spécifications",
      date: "18-11-2024 17h-00",
      categorie: "escrime",
      categorieColor: const Color.fromARGB(255, 234, 255, 0),
      flagColor: const Color.fromARGB(255, 234, 255, 0),
      isChecked: true,
      priority:  Priority.eleve
    ),
        Task(
       id: 7,
      title: "Révision des spécifications",
      date: "20-11-2024 17h-00",
      categorie: "sky",
      categorieColor: const Color.fromARGB(54, 111, 44, 227),
      flagColor:  const Color.fromARGB(54, 111, 44, 227),
      isChecked: false,
      priority:  Priority.moyenne
    ),
        Task(
       id: 8,
      title: "Révision des spécifications",
      date: "18-11-2024 17h-00",
      categorie: "marche",
      categorieColor: const Color.fromARGB(255, 0, 255, 242),
      flagColor: const Color.fromARGB(255, 0, 255, 242),
      isChecked: true,
      priority:  Priority.moyenne
    ),
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
     resizeToAvoidBottomInset:
          false, // Désactive le redimensionnement automatique lié au clavier
      appBar: CustomAppBar(),
      body: [
        // Liste des pages affichées en fonction de l'index sélectionné
        Home(tasks: tasks),  // Passez la liste des tâches à Home
        Tasklist(
          tasks: tasks,  // Passez la liste des tâches à Tasklist
        ),
     CalendarPage( tasks: tasks),
        ProfileScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (index) => setCurrentIndex(index),
      ),
    );
  }
}
