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
