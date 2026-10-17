import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/profile_action_card.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _savedName = "Олег";
  final _savedEmail = "oleg@example.com";

  late TextEditingController _nameEditingController;
  late TextEditingController _emailAccessController;

  String get _initial =>
      _savedName.isNotEmpty ? _savedName[0].toUpperCase() : '?';

  @override
  void initState() {
    _nameEditingController = TextEditingController(text: _savedName);
    _emailAccessController = TextEditingController(text: _savedEmail);
    super.initState();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailAccessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Профіль користувача",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.avatar,
                          child: Text(
                            _initial,
                            style: TextStyle(
                              color: AppColors.link,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 8,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.photo_camera_outlined),
                                        label: const Text("Змінити фото"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.photoButton,
                                          foregroundColor: AppColors.link,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Видалити",
                                          style: TextStyle(color: AppColors.hint),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "JPG або PNG до 5 МБ. Рекомендовано квадратний формат.",
                                  style: TextStyle(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    FormInputField(
                      hint: "Ваше ім'я",
                      label: "Ім'я",
                      type: FieldType.text,
                      controller: _nameEditingController,
                      fillColor: AppColors.photoButton,
                      fieldHeight: 56,
                    ),
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormInputField(
                          hint: "",
                          controller: _emailAccessController,
                          label: "Email",
                          type: FieldType.email,
                          fillColor: AppColors.disabledInput,
                          enabled: false,
                          fieldHeight: 56,
                          isRequired: false,
                        ),
                        const Text(
                          'Email змінити не можна',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.0,
                          ),
                          strutStyle: StrutStyle(
                            fontSize: 12,
                            height: 1.0,
                            forceStrutHeight: true,
                          ),
                        ),
                      ],
                    ),
                    FormActionButton(
                      label: "Зберегти зміни",
                      onPressed: () {},
                      fullWidth: false,
                    ),
                    const Divider(height: 1),
                    const Text(
                      "Безпека та сесія",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    ProfileActionCard(
                      icon: Icons.password_sharp,
                      title: "Пароль доступу",
                      actionLabel: "Змінити пароль",
                      onAction: () => context.go('/profile/change-password'),
                      btnTextColor: AppColors.link,
                      iconBackground: AppColors.passBackground,
                      iconColor: AppColors.textPrimary,
                    ),
                    ProfileActionCard(
                      icon: Icons.logout,
                      title: "Активна сесія",
                      subTitle: "Завершити роботу на цьому пристрої",
                      actionLabel: "Вийти з акаунту",
                      onAction: () => context.go('/login'),
                      btnTextColor: AppColors.exit,
                      iconBackground: AppColors.exitBackground,
                      iconColor: AppColors.exit,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}