import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message)));
}


String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty'; // Error message for empty input
  }
  if (value.length < 8 || value.length > 20) {
    return 'Password must be at least 8 characters long'; // Error message for short password
  }
  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
    return 'Password must contain at least one letter and one number'; // Error message for invalid format
  }
  return null; // Return null if the input is valid
}


String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty'; // Error message for empty input
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address'; // Error message for invalid email format
  }
  return null; // Return null if the input is valid
}
