import 'package:flutter/material.dart';

class BuildNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final void Function()? onTap;

  const BuildNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration:
            isSelected
                ? BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(40),
                )
                : BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color:
                  isSelected
                      ? Theme.of(
                        context,
                      ).bottomNavigationBarTheme.selectedItemColor
                      : Theme.of(
                        context,
                      ).bottomNavigationBarTheme.unselectedItemColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(
                  context,
                ).bottomNavigationBarTheme.selectedItemColor : Theme.of(
                  context,
                ).bottomNavigationBarTheme.unselectedItemColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
