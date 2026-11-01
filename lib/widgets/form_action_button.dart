import 'package:flutter/material.dart';

class FormActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final IconData? icon;
  final bool isLoading;

  const FormActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: (icon == null) ? ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(fullWidth ? double.infinity : 0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading ? const CircularProgressIndicator() : Text(label),
      ) : ElevatedButton.icon(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(fullWidth ? double.infinity : 0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          label: isLoading ? const CircularProgressIndicator() : Text(label),
          icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}