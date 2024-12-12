import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listo/core/api/service.dart';
import 'package:listo/core/utils/task.dart';

List<Task> tasks = [];

class Data {
  final List<Task> tasks;
  final bool isLoading;

  Data(this.tasks, {this.isLoading = false});
}

class TaskCubit extends Cubit<Data> {
  TaskCubit() : super(Data([])) {
    _fetchTasks(); // Charge les tâches dès la création du Cubit
  }

  // Méthode pour récupérer les tâches.
  Future<void> _fetchTasks() async {
    try {
      final fetchedTasks = await ApiService
          .fetchTasks(); // Appel à l'API pour récupérer les tâches
      tasks = fetchedTasks; // Mise à jour de la liste des tâches
      emit(Data(tasks)); // Mise à jour de l'état avec les nouvelles tâches
      print(tasks); // Debugging pour voir les tâches récupérées
    } catch (e) {
      print(e); // Gestion des erreurs
    }
  }

  // Méthode pour recharger les tâches
Future<void> reload() async {
  emit(Data([], isLoading: true)); // Affiche l'indicateur de chargement
  await _fetchTasks();
  emit(Data(tasks, isLoading: false)); // Cache l'indicateur de chargement après le chargement des tâches
}
}
