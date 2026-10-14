import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/authentication_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_title.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/utils/validators.dart';
import 'package:mail_tracking_service/widgets/bottom_redirection.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationScaffold(child: const RegisterForm());
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
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
          FormTitle(
            mainText: "Створення акаунту",
          ),
          FormInputField(
            label: "Ім'я",
            hint: "Олег",
            type: FieldType.text,
            controller: _nameController,
            validator: (value) => Validators.validateRequired(value),
            labelTrailing: null,
          ),
          FormInputField(
            label: "Email",
            hint: "oleg@example.com",
            type: FieldType.email,
            controller: _emailController,
            validator: (value) => Validators.validateEmail(value),
            labelTrailing: null,
          ),
          FormInputField(
            label: "Пароль",
            hint: "······",
            type: FieldType.password,
            controller: _passwordController,
            validator: (value) => Validators.validatePassword(value),
            labelTrailing: null,
          ),
          FormInputField(
            label: "Підтвердіть пароль",
            hint: "······",
            type: FieldType.password,
            controller: _confirmPasswordController,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Паролі не збігаються';
              }
              return null;
            },
            labelTrailing: null,
          ),
          FormActionButton(
            label: 'Зареєструватися',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final email = _emailController.text.trim();
                final password = _passwordController.text;


              }
            },
          ),
          const Divider(
            color: AppColors.border,
            thickness: 1,
            height: 24,
          ),
          BottomRedirection(
            textLabel: "Вже маєте акаунт?",
            buttonLabel: "Вхід",
            onPressed: () => context.push('/login'),
          )
        ],
      ),
    );
  }
}
