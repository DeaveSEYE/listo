import 'package:flutter/material.dart';
import 'package:listo/partials/Listview.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Pour parser les dates personnalisées
import 'package:listo/core/utils/task.dart';


class CalendarPage extends StatefulWidget {
  final List<Task> tasks; // Liste des tâches passée en paramètre
  
  const CalendarPage({super.key, required this.tasks});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
      List<Task> filteredTasks = []; // Liste des tâches filtrées
      @override
      void initState() {
    super.initState();
    // Initialiser avec toutes les tâches
    filteredTasks = widget.tasks;
  }
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy'); // Changez selon le format de vos tâches
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // Récupère les dates ayant des tâches
  Set<DateTime> _taskDates() {
    return widget.tasks.map((task) {
      final taskDate = _dateFormat.parse(task.date.split(" ")[0]); // Parse selon le format
      return DateTime(taskDate.year, taskDate.month, taskDate.day); // Normalise la date
    }).toSet();
  }

  // Récupère les tâches pour une journée donnée
  List<Task> _getTasksForDay(DateTime day) {
    return widget.tasks.where((task) {
      final taskDate = _dateFormat.parse(task.date.split(" ")[0]); // Parse selon le format
      return taskDate.year == day.year &&
          taskDate.month == day.month &&
          taskDate.day == day.day;
    }).toList();
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
    final taskDates = _taskDates(); // Liste des dates avec des tâches

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendrier
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                markersAutoAligned: true,
              ),
              eventLoader: (day) {
                // Indique s'il y a des événements pour une journée donnée
                return taskDates.contains(DateTime(day.year, day.month, day.day))
                    ? [true] // Utilisation d'un tableau pour signaler un marqueur
                    : [];
              },
            ),
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
          // Affichage des tâches pour le jour sélectionné
          if (_selectedDay != null)
            Text(
              "Tâches pour ${_selectedDay!.day}-${_selectedDay!.month}-${_selectedDay!.year}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 10),
          // Affichage des tâches
          _selectedDay != null
              ? _getTasksForDay(_selectedDay!).isNotEmpty
                  ? Listviews(_getTasksForDay(_selectedDay!)) // Utiliser Listviews pour afficher les tâches
                  : const Center(child: Text("Aucune tâche pour ce jour"))
              : const Center(child: Text("Veuillez sélectionner une date")),
        ],
      ),
    );
  }
}
