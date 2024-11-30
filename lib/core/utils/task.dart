import 'package:flutter/material.dart';

enum Priority { basse, moyenne, eleve }

// Task model
class Task {
  final int id;
  final String title;
  final String categorie;
  final String description;
  final Color categorieColor;
  Priority priority;
  bool isChecked;
  final String createdAt;
  final String updatedAt;
  final String dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.dueDate,
    required this.categorie,
    required this.categorieColor,
    this.isChecked = false, // Valeur par défaut
    this.priority = Priority.basse, // Valeur par défaut pour la priorité
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      dueDate: json['dueDate'],
      categorie: json['categorie'],
      categorieColor: Color(json['categorieColor']),
      isChecked: json['isChecked'],
      priority: Priority.values[json['priority']],
    );
  }
}
