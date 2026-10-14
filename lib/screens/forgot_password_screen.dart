import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/authentication_scaffold.dart';
import 'package:mail_tracking_service/widgets/form_title.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/utils/validators.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationScaffold(child: const PasswordRecoveryForm());
  }
}

class PasswordRecoveryForm extends StatefulWidget {
  const PasswordRecoveryForm({super.key});

  @override
  State<PasswordRecoveryForm> createState() => _PasswordRecoveryFormState();
}

class _PasswordRecoveryFormState extends State<PasswordRecoveryForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
            mainText: "Відновлення пароля",
            subText: "Введіть ваш email і ми надішлемо посилання для відновлення",
          ),
          FormInputField(
            label: "Email",
            hint: "oleg@example.com",
            type: FieldType.email,
            controller: _emailController,
            validator: (value) => Validators.validateEmail(value),
            labelTrailing: null,
          ),
          FormActionButton(
            label: 'Надіслати лист',
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              //   final email = _emailController.text.trim();
              //
              // }

              context.push('/letter-sent');
            },

          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: NavTextButton(
              destination: '/login',
              label: 'Повернутися до входу',
              icon: Icons.arrow_back,
              centered: true,
              bold: true,
            ),
          )
        ],
      ),
    );
  }
}