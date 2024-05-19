import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); // constructor call for 3rd party package

const uuid = Uuid(); // constructor call for 3rd party package

enum Category { food, travel, leisure, work } // this is not String

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// why we create this Expense class . Think ?
class Expense {
  final String id; // so that every expense has unique id
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // getters used here => properties that are dynamically derived
  String get formattedDate {
    // use 3rd party package => flutter intl
    return formatter.format(date); // return String of human readable date
  }

  Expense({
    // don't add id here,build unique id dynamically
    // whenever new expense is created --->flutter uuid(3rd party package)
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
