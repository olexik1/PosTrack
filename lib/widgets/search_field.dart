import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class SearchField extends StatefulWidget {
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? color;
  final Color? hintColor;

  const SearchField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onSubmitted,
    this.hint = 'Пошук за ТТН або назвою',
    required this.color,
    required this.hintColor
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(SearchField old) {
    super.didUpdateWidget(old);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.color,
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.hintColor,
          fontSize: 14,
        ),
        border: _border(AppColors.parcelInputBorder),
        enabledBorder: _border(AppColors.parcelInputBorder),
        focusedBorder: _border(AppColors.primary, 1.5),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: Icon(
            Icons.search_outlined,
            color: widget.hintColor,
            size: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 24,
        ),
        constraints: const BoxConstraints.tightFor(height: 48),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      controller: _controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}