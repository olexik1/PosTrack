import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

enum FieldType { text, email, password }

class FormInputField extends StatefulWidget {
  final String label;
  final String hint;
  final FieldType type;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isRequired;
  final Widget? labelTrailing;

  const FormInputField({
    super.key,
    required this.label,
    required this.hint,
    this.type = FieldType.text,
    this.controller,
    this.validator,
    this.isRequired = true,
    this.labelTrailing,
  });

  @override
  State<FormInputField> createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.type == FieldType.password;
  }

  OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = switch (widget.type) {
      FieldType.email => TextInputType.emailAddress,
      _ => TextInputType.text,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: widget.label,
                children: [
                  if (widget.isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.error),
                    ),
                ],
              ),
            ),
            if (widget.labelTrailing != null) widget.labelTrailing!,
          ],
        ),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: AppColors.hint),
            border: _border(AppColors.border),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary, 1.5),
            suffixIcon: widget.type == FieldType.password
                ? IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
}