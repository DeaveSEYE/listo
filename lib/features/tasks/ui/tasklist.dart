import 'package:flutter/material.dart';
import 'package:listo/core/theme/ListCategories.dart';
import 'package:listo/core/utils/task.dart';
import 'package:listo/partials/BuildTaskItem.dart';

class Tasklist extends StatefulWidget {
  final List<Task> tasks; // Liste des tâches passées par le parent

  const Tasklist({
    super.key,
    required this.tasks,  // Passer la liste des tâches
  });

  @override
  State<Tasklist> createState() => _TasklistState();
  
}

class _TasklistState extends State<Tasklist> {
    List<Task> filteredTasks = []; // Liste des tâches filtrées
      @override
      void initState() {
    super.initState();
    // Initialiser avec toutes les tâches
    filteredTasks = widget.tasks;
  }
  // Function to handle task deletion
  void _onDelete(int index) {
    setState(() {
      widget.tasks.removeAt(index); // Removes the task at the given index
    });
  }

  // Function to handle task update
  void _onUpdate(int index) {
    setState(() {
      widget.tasks[index].isChecked = !widget.tasks[index].isChecked; // Toggles isChecked
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
          ListCategories(tasks:widget.tasks),
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                return BuildTaskItem(
            key: ValueKey(widget.tasks[index].id), // Passing a unique key for each item
            task: widget.tasks[index],
            index: index,
            onDelete: _onDelete,
            onUpdate: _onUpdate,
          );
              },
            ),
          ),
        ],
      ),
    );
  }
}