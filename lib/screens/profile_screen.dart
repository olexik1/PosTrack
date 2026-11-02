import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/profile_action_card.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/services/auth_repository.dart';
import 'package:mail_tracking_service/exceptions/auth_exception.dart';
import 'package:mail_tracking_service/widgets/app_snack_bar.dart';
import 'package:mail_tracking_service/utils/validators.dart';
import 'package:mail_tracking_service/widgets/avatar_picker_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthRepository _authRepository = AuthRepository();

  late String _savedName;
  late String _savedEmail;
  String? _photoUrl;

  late TextEditingController _nameEditingController;
  late TextEditingController _emailAccessController;

  bool _isLoading = false;

  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  String get _initial =>
      _savedName.isNotEmpty ? _savedName[0].toUpperCase() : '?';

  @override
  void initState() {
    super.initState();

    final user = _authRepository.currentUser;
    _savedName = user?.displayName ?? '';
    _savedEmail = user?.email ?? '';
    final photo = user?.photoURL;
    _photoUrl = (photo == null || photo.isEmpty) ? null : photo;

    _nameEditingController = TextEditingController(text: _savedName);
    _emailAccessController = TextEditingController(text: _savedEmail);
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailAccessController.dispose();
    super.dispose();
  }

  void _showSnack(SnackBar bar) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(bar);
  }

  Future<void> _changePhoto(String? url) async {
    try {
      setState(() => _isLoading = true);
      await _authRepository.updatePhoto(photoUrl: url);
      if (!mounted) return;
      setState(() => _photoUrl = url);
      _showSnack(AppSnackBar.success(url == null ? 'Фото видалено' : 'Фото оновлено'));
    } on AuthException catch (e) {
      if (!mounted) return;
      _showSnack(AppSnackBar.error(e.translateFirebaseException()));
    } catch (e) {
      if (!mounted) return;
      _showSnack(AppSnackBar.error('Не вдалося виконати операцію. Спробуйте ще раз'));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                          backgroundImage: _photoUrl != null ? NetworkImage(_photoUrl!) : null,
                          child: _photoUrl != null ? null : Text(
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
                                        onPressed: _isLoading
                                            ? null
                                            : () async {
                                          final url = await showAvatarPicker(context, selectedUrl: _photoUrl);
                                          if (url == null || !mounted) return;
                                          await _changePhoto(url);
                                        },
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
                                        onPressed: (_isLoading || _photoUrl == null) ? null : () => _changePhoto(null),
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
                    Form(
                      key: _nameFormKey,
                      child: FormInputField(
                        hint: "Введіть ім'я",
                        label: "Ім'я",
                        type: FieldType.text,
                        controller: _nameEditingController,
                        fillColor: AppColors.photoButton,
                        fieldHeight: 56,
                        enabled: !_isLoading,
                        validator: (value) => Validators.validateRequired(value, "Введіть ім'я"),
                      ),
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
                      onPressed: () async {
                        if (_nameFormKey.currentState!.validate()) {
                          final name = _nameEditingController.text.trim();

                          try {
                            setState(() {
                              _isLoading = true;
                            });

                            await _authRepository.updateName(name: name);

                            if (!context.mounted) return;

                            setState(() {
                              _savedName = name;
                            });

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              AppSnackBar.success('Зміни збережено'),
                            );

                            // context.go('/home');
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
                      fullWidth: false,
                      isLoading: _isLoading,
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
                      onAction: () =>  _authRepository.signOut(),
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