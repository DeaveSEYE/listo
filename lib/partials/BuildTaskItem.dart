import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:listo/core/utils/task.dart';

class BuildTaskItem extends StatefulWidget {
  final Task task;
  final int index;
  final Function(int) onDelete;
  final Function(int) onUpdate;

  const BuildTaskItem({
    super.key,
    required this.task,
    required this.index,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  _BuildTaskItemState createState() => _BuildTaskItemState();
}

class _BuildTaskItemState extends State<BuildTaskItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    // Initialize the state with the current value of isChecked from the task
    isChecked = widget.task.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ValueKey(widget.task),
      leadingActions: [
        SwipeAction(
          onTap: (handler) {
            // widget.onUpdate(widget.index);
          },
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.edit, color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ],
      trailingActions: [
        SwipeAction(
          onTap: (CompletionHandler handler) async {
            await handler(true);
            setState(() {
              // widget.task.removeAt(widget.index);
            });
          },
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          color: Colors.red,
        ),
      ],
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            onPressed: () {
              setState(() {
                isChecked = !isChecked; // Toggle checked state
              });
            },
          ),
          title: Text(
            widget.task.title,
            overflow: TextOverflow.ellipsis, // Ajoute "..."
            maxLines: 1, // Limite à une ligne
          ),
          subtitle: Text(
            widget.task.dueDate,
            overflow: TextOverflow.ellipsis, // Ajoute "..."
            maxLines: 1, // Limite à une ligne
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.task.categorieColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.task.categorie,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.flag,
                color: _getPriorityColor(
                    widget.task.priority), // Couleur dynamique
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Fonction pour retourner la couleur en fonction de la priorité
  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.moyenne:
        return Colors.yellow; // Moyenne priorité : Jaune
      case Priority.eleve:
        return Colors.red; // Haute priorité : Rouge
      default:
        return Colors.green; // Couleur par défaut
    }
  }
}
