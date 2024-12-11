// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:listo/core/api/service.dart';
import 'package:listo/core/theme/colors.dart';
import 'package:listo/core/utils/categorie.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/features/home/ui/home.dart';
import 'package:listo/features/tasks/ui/tasklist.dart';
import 'package:listo/features/calendar/ui/calendar.dart';
import 'package:listo/features/profile/ui/profile.dart';
import 'package:listo/partials/TaskModal.dart';
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
            TaskModal(
              context: context,
              categories: categories,
              task: null, // Tâche vide pour ajouter une nouvelle tâche
              onTaskAdded: (taskData) async {
                // Call your API to add the task
                await ApiService.addTask(taskData);
                // Update tasks and show success
                await _fetchTasks();
              },
            ).showAddTaskModal();
          },
          icon: Icons.add,
        ),
      ),
    );
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
