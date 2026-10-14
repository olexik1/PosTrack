import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/authentication_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationScaffold(child: const LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              const Text(
                "Вхід у PosTrack",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                ),
              ),
              const Text(
                  "Введіть дані для доступу до ваших посилок",
                  style: TextStyle(
                      color: AppColors.textPrimary,
                  )
              ),
            ],
          ),
          FormInputField(
            label: "Email",
            hint: "oleg@example.com",
            type: FieldType.email,
            controller: _emailController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Введіть email';
              }

              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                  .hasMatch(value.trim())) {
                return 'Введіть коректний email';
              }

              return null;
            },
            labelTrailing: null,
          ),
          FormInputField(
            label: "Пароль",
            hint: "······",
            type: FieldType.password,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Введіть пароль';
              }

              return null;
            },
            labelTrailing: TextButton(
              onPressed: () {
                context.push('/forgot-pass');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Забули пароль?",
                style: TextStyle(
                  color: AppColors.link,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {

              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
            ),
            child: const Text("Увійти"),
          ),
          const Divider(
            color: AppColors.border,
            thickness: 1,
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Text(
                "Ще немає акаунту?",
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/register');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Реєстрація",
                  style: TextStyle(
                    color: AppColors.link,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
