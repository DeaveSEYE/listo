import 'package:listo/core/utils/task.dart';

class TaskFilter {
  /// Trie les tâches par date ou priorité
  static void applyFilter(List<Task> tasks, String filter) {
    if (filter == "date") {
      // Trier par date
<<<<<<< HEAD
=======
<<<<<<< HEAD
      tasks.sort((a, b) => a.date.compareTo(b.date));
    } else if (filter == "priority") {
      // Trier par priorité
      tasks.sort((a, b) => _getPriorityValue(a.priority).compareTo(_getPriorityValue(b.priority)));
=======
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
      tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else if (filter == "priority") {
      // Trier par priorité
      tasks.sort((a, b) => _getPriorityValue(a.priority)
          .compareTo(_getPriorityValue(b.priority)));
<<<<<<< HEAD
=======
>>>>>>> 21e5289 (initial commit)
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
    }
  }

  /// Retourne une valeur numérique correspondant à chaque priorité
  static int _getPriorityValue(Priority priority) {
    switch (priority) {
      case Priority.basse:
        return 1; // Priorité basse
      case Priority.moyenne:
        return 2; // Priorité moyenne
      case Priority.eleve:
        return 3; // Priorité élevée
      default:
        return 0; // Valeur par défaut
    }
  }
}
