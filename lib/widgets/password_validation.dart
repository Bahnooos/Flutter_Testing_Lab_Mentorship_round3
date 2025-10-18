import 'package:flutter/material.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(
          'At least 1 special character',
          hasSpecialCharacters,
        ),
        SizedBox(height: 2),
        buildValidationRow('At least 1 number', hasNumber),
        SizedBox(height: 2),
        buildValidationRow('At least 8 characters long', hasMinLength),
      ],
    );
  }


}
  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        CircleAvatar(radius: 2.5, backgroundColor: Colors.grey),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? Colors.grey : Colors.blueAccent[700],
          ),
        ),
      ],
    );
  }