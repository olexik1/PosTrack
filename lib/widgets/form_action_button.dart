import 'package:flutter/material.dart';

class FormActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final IconData? icon;

  const FormActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: (icon == null) ? ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(fullWidth ? double.infinity : 0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(label),
      ) : ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(fullWidth ? double.infinity : 0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          label: Text(label),
          icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}