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
import 'package:mail_tracking_service/exceptions/auth_exception.dart';
import 'package:mail_tracking_service/services/auth_repository.dart';
import 'package:mail_tracking_service/widgets/app_snack_bar.dart';

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
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false;

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
          FormTitle(
            mainText: "Вхід у PosTrack",
            subText: "Введіть дані для доступу до ваших посилок",
          ),
          FormInputField(
            label: "Email",
            hint: "oleg@example.com",
            type: FieldType.email,
            controller: _emailController,
            validator: (value) => Validators.validateEmail(value),
            labelTrailing: null,
            enabled: !_isLoading,
          ),
          FormInputField(
            label: "Пароль",
            hint: "······",
            type: FieldType.password,
            controller: _passwordController,
            validator: (value) => Validators.validatePassword(value),
            labelTrailing: NavTextButton(
              destination: '/forgot-pass',
              label: 'Забули пароль?',
            ),
            enabled: !_isLoading,
          ),
          FormActionButton(
            label: 'Увійти',
              isLoading: _isLoading,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final email = _emailController.text.trim();
                final password = _passwordController.text;

                try {
                  setState(() {
                    _isLoading = true;
                  });

                  await _authRepository.signIn(email: email, password: password);

                  if (!context.mounted) return;
                  context.go('/home');
                } on AuthException catch(e) {
                  if(!context.mounted) return;

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar.error(e.translateFirebaseException()),
                  );
                } catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar.error('Не вдалося виконати операцію. Спробуйте ще раз'),
                  );
                } finally {
                  if (context.mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              }
            },
          ),
          const Divider(
            color: AppColors.border,
            thickness: 1,
            height: 24,
          ),
          BottomRedirection(
            textLabel: "Ще немає акаунту?",
            buttonLabel: "Реєстрація",
            onPressed: () => context.push('/register'),
          )
        ],
      ),
    );
  }
}
