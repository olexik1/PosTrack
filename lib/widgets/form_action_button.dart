import 'package:flutter/material.dart';

class FormActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final IconData? icon;
  final bool isLoading;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  const FormActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      minimumSize: Size(fullWidth ? double.infinity : 0, 48),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: borderColor != null
          ? BorderSide(color: borderColor!)
          : null,
    );

    final child = isLoading ? const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2),
    ) : Text(label);

    return SizedBox(
        width: fullWidth ? double.infinity : null,
      child: (icon == null) ? ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: child,
      ) : ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        label: child,
        icon: Icon(icon),
      )
    );
  }
}