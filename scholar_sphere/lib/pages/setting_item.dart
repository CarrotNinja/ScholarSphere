// setting_item.dart
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String? value;
  final VoidCallback onTap;

  const SettingItem({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 16),
                Text(title),
              ],
            ),
            if (value != null) Text(value!),
          ],
        ),
      ),
    );
  }
}
