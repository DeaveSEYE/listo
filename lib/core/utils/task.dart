

import 'package:flutter/material.dart';
enum Priority { basse, moyenne, eleve }
// Task model
class Task {
  final int id;
  final String title;
  final String date;
  final String categorie;
  final Color categorieColor;
  final Color flagColor;
  bool isChecked;
  Priority priority;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.categorie,
    required this.categorieColor,
    required this.flagColor,
    this.isChecked = false, // Valeur par défaut
    this.priority = Priority.basse, // Valeur par défaut pour la priorité
  });
}