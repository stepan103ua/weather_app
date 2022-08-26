import 'package:flutter/material.dart';

import '../../constants.dart';

class FilterListItem extends StatelessWidget {
  const FilterListItem({
    Key? key,
    required this.isSelected,
    required this.isLast,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final bool? isLast;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: isSelected ? Colors.pink : Constants.containerBackgroundColor,
        ),
        margin:
            isLast != null && isLast! ? null : const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
