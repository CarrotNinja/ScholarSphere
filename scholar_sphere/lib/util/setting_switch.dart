// setting_switch.dart
import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final bool value;
  final ValueChanged<bool> onTap;

  const SettingSwitch({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Switch(
            value: value,
            onChanged: onTap,
          ),
        ],
      ),
    );
  }
}
