import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';

class _FaqItem {
  final String question;
  final String answer;
  const _FaqItem(this.question, this.answer);
}

const _faq = [
  _FaqItem(
    'Як додати посилку?',
    "Перейдіть у розділ «Мої посилки» або на «Головну» та натисніть «Додати посилку». Заповніть обов'язкові поля: назву посилки, трек-номер (ТТН) та оберіть службу доставки. За потреби вкажіть відправника, одержувача, дату та прикріпіть фото квитанції.",
  ),
  _FaqItem(
    'Як змінити статус?',
    'Відкрийте посилку та натисніть «Змінити статус». Оберіть новий статус, за потреби додайте коментар (наприклад, номер відділення) і підтвердьте. Дата й час зміни збережуться в історії статусів.',
  ),
  _FaqItem(
    'Що означає кожен статус?',
    'Короткий опис кожного етапу доставки наведено нижче, у блоці «Статуси доставки».',
  ),
  _FaqItem(
    'Як відновити пароль?',
    'На сторінці входу натисніть «Забули пароль?», введіть email, і ми надішлемо лист із посиланням для відновлення. Перейдіть за ним і задайте новий пароль.',
  ),
  _FaqItem(
    'Які фото можна завантажити?',
    'До посилки можна додати зображення JPG або PNG розміром до 5 МБ, наприклад фото квитанції. Для профілю обирається один із готових аватарів.',
  ),
];

const _statusDescriptions = {
  ParcelStatus.created: 'ТТН згенеровано або додано в систему, очікується фактична відправка.',
  ParcelStatus.accepted: 'Вантаж оформлено та прийнято у відділенні перевізника.',
  ParcelStatus.onTheRoad: 'Посилка транспортується між містами чи сортувальними центрами.',
  ParcelStatus.arrived: 'Відправлення прибуло до пункту видачі або поштомату і готове до отримання.',
  ParcelStatus.delivered: 'Вантаж успішно отримано одержувачем.',
  ParcelStatus.returned: 'Термін зберігання вичерпано або посилку відхилено та повернуто відправнику.',
};

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Довідка',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Відповіді на поширені запитання та довідник статусів відправлень',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
              ],
            ),
            _SectionCard(
              icon: Icons.help_outline,
              title: 'Часті питання',
              child: Column(
                children: [
                  for (var i = 0; i < _faq.length; i++) ...[
                    ExpansionTile(
                      initiallyExpanded: i == 0,
                      shape: const Border(),
                      collapsedShape: const Border(),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: const EdgeInsets.only(bottom: 16),
                      expandedAlignment: Alignment.centerLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Text(
                        _faq[i].question,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        Text(
                          _faq[i].answer,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    if (i < _faq.length - 1) const Divider(height: 1),
                  ],
                ],
              ),
            ),
            _SectionCard(
              icon: Icons.local_shipping_outlined,
              title: 'Статуси доставки',
              subtitle: 'Короткий опис усіх етапів переміщення вантажу',
              child: Column(
                spacing: 8,
                children: [
                  for (final s in ParcelStatus.values)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.photoButton,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: StatusChip(status: s),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _statusDescriptions[s]!,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(icon, color: AppColors.link),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            child,
          ],
        ),
      ),
    );
  }
}