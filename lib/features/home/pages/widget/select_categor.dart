import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class SelectedCategoryWidget extends StatelessWidget {
  final String title;
  final bool isSelected;

  const SelectedCategoryWidget(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.grey : null),
      child: Text(
        title,
        style: TextStyle(
            color: isSelected ? const Color(0xff12CDD9) : Colors.white,
            fontWeight: FontWeight.bold),
      ).animate().fade(),
    );
  }
}
