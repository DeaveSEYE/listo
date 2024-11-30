<<<<<<< HEAD
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
          widget.task.date,
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
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
               ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.flag,
              color: _getPriorityColor(widget.task.priority), // Couleur dynamique
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
    case Priority.basse:
      return Colors.green; // Basse priorité : Vert
    case Priority.moyenne:
      return Colors.yellow; // Moyenne priorité : Jaune
    case Priority.eleve:
      return Colors.red; // Haute priorité : Rouge
    default:
      return Colors.grey; // Couleur par défaut
  }
}

}
=======
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
            overflow: TextOverflow.ellipsis, // Ajoute "...",
            maxLines: 1, // Limite à une ligne
          ),
          subtitle: Text(
            widget.task.dueDate,
            overflow: TextOverflow.ellipsis, // Ajoute "...",
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
          onTap: () {
            showTaskDetails(context, widget.task); // Affiche le modal au tap
          },
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

  void showTaskDetails(BuildContext context, task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor:
              0.5, // Réduit la hauteur du modal à la moitié de l'écran
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Prend toute la largeur de l'écran
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18), // Titre en gras
                  ),
                  SizedBox(height: 8),
                  Text(task.description), // Affichage de la description
                  SizedBox(height: 16),
                  Spacer(), // Pousse tout le contenu vers le haut pour mettre le bouton en bas
                  Align(
                    alignment:
                        Alignment.center, // Centrer le bouton horizontalement
                    child: ElevatedButton(
                      onPressed: () {
                        // Ajoutez la logique pour la modification de la tâche ici
                        print('Modifier la tâche');
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Texte en blanc
                        padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12), // Un peu d'espace autour du texte
                      ),
                      child: Text('Modifier'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
>>>>>>> 21e5289 (initial commit)
