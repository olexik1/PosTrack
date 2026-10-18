import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String password = "676767";
  String newPassword = "767676";
  String confPassword = "767676";

  late TextEditingController _passwordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confPasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: password);
    _newPasswordController = TextEditingController(text: newPassword);
    _confPasswordController = TextEditingController(text: confPassword);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 48,
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: NavTextButton(
              destination: '/profile',
              label: 'Назад до профілю',
              icon: Icons.arrow_back,
              centered: false,
              bold: true,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              const Text(
                "Зміна пароля",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text(
                "Введіть поточний та новий пароль для захисту акаунта",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormInputField(
                      hint: "******",
                      label: "Поточний пароль",
                      type: FieldType.password,
                      controller: _passwordController,
                      fillColor: AppColors.photoButton,
                      fieldHeight: 56,
                      isRequired: true,
                    ),
                    FormInputField(
                      hint: "******",
                      label: "Новий пароль (мін. 6 символів)",
                      type: FieldType.password,
                      controller: _newPasswordController,
                      fillColor: AppColors.photoButton,
                      fieldHeight: 56,
                      isRequired: true,
                    ),
                    FormInputField(
                      hint: "******",
                      label: "Підтвердіть новий пароль",
                      type: FieldType.password,
                      controller: _confPasswordController,
                      fillColor: AppColors.photoButton,
                      fieldHeight: 56,
                      isRequired: true,
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        FormActionButton(
                          label: "Змінити пароль",
                          onPressed: () {},
                          fullWidth: false,
                        ),
                        SizedBox(
                          height: 48,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Скасувати",
                              style: TextStyle(color: AppColors.hint),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}