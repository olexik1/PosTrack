import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/authentication_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';

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

  bool _obscurePassword = true;

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
                    color: Color(0xFF171C20)
                ),
              ),
              const Text(
                  "Введіть дані для доступу до ваших посилок",
                  style: TextStyle(
                      color: Color(0xFF171C20)
                  )
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Email ',
                  children: [
                    TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              TextFormField(
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
                decoration: InputDecoration(
                    labelText: "oleg@example.com",
                    labelStyle: TextStyle(color: const Color(0xFF5B5F64)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: const Color(0xFFC1C6D6))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC1C6D6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1A73E8),
                        width: 1.5,
                      ),
                    ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Пароль ',
                      children: [
                        TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Забули пароль?",
                      style: TextStyle(
                        color: Color(0xFF005BBF),
                      ),
                    ),
                  )
                ],
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введіть пароль';
                  }

                  return null;
                },
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                    labelText: "······",
                    labelStyle: TextStyle(color: const Color(0xFF5B5F64)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: const Color(0xFFC1C6D6))
                    ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFC1C6D6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF1A73E8),
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {

              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1A73E8),
              foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
            ),
            child: const Text("Увійти"),
          ),
          const Divider(
            color: Color(0x4DC1C6D6),
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
                  color: Color(0xFF414754)
                ),
              ),
              TextButton(
                onPressed: () {

                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Реєстрація",
                  style: TextStyle(
                    color: Color(0xFF005BBF),
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
