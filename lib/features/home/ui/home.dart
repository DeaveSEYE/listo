import 'package:flutter/material.dart';
import 'package:listo/core/theme/ListCategories.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/partials/Listview.dart';
import 'package:listo/partials/searchbar.dart';

class Home extends StatefulWidget {
  final List<Task> tasks; // Liste des tâches passée en paramètre

  const Home({super.key, required this.tasks});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> filteredTasks = []; // Liste des tâches filtrées
  bool isCompletedSelected = true; // Suivi de la carte sélectionnée (terminée ou en attente)

  @override
  void initState() {
    super.initState();
    // Initialiser avec toutes les tâches
    filteredTasks = widget.tasks;
  }

  // Filtrer les tâches en fonction de leur statut
  void _filterTasks(bool isCompleted) {
    setState(() {
      filteredTasks = widget.tasks.where((task) {
        return task.isChecked == isCompleted;
      }).toList();
      isCompletedSelected = isCompleted; // Mettre à jour la carte sélectionnée
    });
  }

  // Appliquer un filtre spécifique
  void _applyFilter(String filter) {
    setState(() {
      if (filter == "date") {
        // Trier les tâches par date
        filteredTasks.sort((a, b) => a.date.compareTo(b.date));
      } else if (filter == "priority") {
        // Trier les tâches par couleur de priorité
        filteredTasks.sort((a, b) => a.flagColor.value.compareTo(b.flagColor.value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Searchbar(),
          const SizedBox(height: 10),
          // ListCategories utilise toujours widget.tasks
          ListCategories(tasks: widget.tasks),
          const Text(
            "Aperçu des tâches",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Carte Terminés
              _buildStatusCard(
                "Terminés",
                "${widget.tasks.where((task) => task.isChecked).length}",
                isCompletedSelected ? Colors.blue[200]! : Colors.white,
                true,
              ),
              const SizedBox(width: 10),
              // Carte En attente
              _buildStatusCard(
                "En attente",
                "${widget.tasks.where((task) => !task.isChecked).length}",
                isCompletedSelected ? Colors.white : Colors.blue[200]!,
                false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Liste des tâches",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list), // Icône du bouton de filtre
                onSelected: (value) {
                  // Gérer la sélection de filtre
                  _applyFilter(value);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "date",
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 18),
                        SizedBox(width: 8),
                        Text("Date"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "priority",
                    child: Row(
                      children: [
                        Icon(Icons.flag, size: 18),
                        SizedBox(width: 8),
                        Text("Priorité"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Listviews utilise filteredTasks
          Listviews(filteredTasks),
        ],
      ),
    );
  }

  // Méthode pour construire les cartes de statut
  Widget _buildStatusCard(
      String title, String count, Color color, bool isCompleted) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Filtrer les tâches selon le statut
          _filterTasks(isCompleted);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                count,
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
