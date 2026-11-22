import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';
import 'package:mail_tracking_service/widgets/change_status_dialog.dart';
import 'package:mail_tracking_service/utils/validators.dart';
import 'package:mail_tracking_service/models/parcel_form_values.dart';
import 'package:mail_tracking_service/widgets/delete_parcel_dialog.dart';
import 'package:mail_tracking_service/widgets/parcel_photo_field.dart';
import 'package:mail_tracking_service/widgets/parcel_photo_upload.dart';


class ParcelFormScreen extends StatefulWidget {
  final Parcel? initial;
  final ValueChanged<ParcelFormValues> onSubmit;

  const ParcelFormScreen({super.key, this.initial, required this.onSubmit});

  @override
  State<ParcelFormScreen> createState() => _ParcelFormScreenState();
}

class _ParcelFormScreenState extends State<ParcelFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _tracking;
  late final TextEditingController _sender;
  late final TextEditingController _recipient;
  late final TextEditingController _note;
  late final TextEditingController _dateCtrl;
  late ParcelCarrier _carrier;
  late ParcelStatus _status;
  late DateTime _date;

  bool get _isEdit => widget.initial != null;
  String get _backPath =>
      _isEdit ? '/parcels/${widget.initial!.id}' : '/parcels';

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    _title = TextEditingController(text: p?.title ?? '');
    _tracking = TextEditingController(text: p?.trackingNumber ?? '');
    _sender = TextEditingController(text: p?.sender ?? '');
    _recipient = TextEditingController(text: p?.recipient ?? '');
    _note = TextEditingController(text: p?.note ?? '');
    _carrier = p?.carrier ?? ParcelCarrier.values.first;
    _status = p?.status ?? ParcelStatus.created;
    _date = p?.date ?? DateTime.now();
    _dateCtrl = TextEditingController(text: _fmt(_date));
  }

  @override
  void dispose() {
    for (final c in [_title, _tracking, _sender, _recipient, _note, _dateCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _date = picked;
      _dateCtrl.text = _fmt(picked);
    });
  }

  Future<void> _changeStatus() async {
    final result =
    await showChangeStatusDialog(context, currentStatus: _status);
    if (result == null || !mounted) return;
    context
        .read<ParcelProvider>()
        .changeStatus(widget.initial!.id, result.status, result.comment);
    setState(() => _status = result.status);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(ParcelFormValues(
      title: _title.text.trim(),
      trackingNumber: _tracking.text.trim(),
      carrier: _carrier,
      sender: _sender.text.trim(),
      recipient: _recipient.text.trim(),
      date: _date,
      status: _status,
      note: _note.text.trim(),
    ));
  }

  Widget _dropdown<T>({
    required String label,
    required T value,
    required Map<T, String> options,
    required ValueChanged<T> onChanged,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text.rich(TextSpan(text: label, children: [
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: AppColors.error)),
        ])),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.photoButton,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              items: [
                for (final e in options.entries)
                  DropdownMenuItem<T>(value: e.key, child: Text(e.value)),
              ],
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentStatusBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        const Text('Поточний статус'),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.photoButton,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              StatusChip(status: _status),
              const Spacer(),
              TextButton(onPressed: _changeStatus, child: const Text('Змінити')),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            NavTextButton(
              destination: _backPath,
              label: _isEdit ? 'Назад до посилки' : 'Назад до списку',
              icon: Icons.arrow_back,
              centered: false,
              bold: true,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  _isEdit ? 'Редагування посилки' : 'Нова посилка',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  _isEdit
                      ? 'Введіть актуальні дані про відправлення'
                      : 'Заповніть дані про відправлення',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormInputField(
                        label: 'Назва посилки',
                        hint: 'Наприклад: Книги, Навушники, Документи',
                        controller: _title,
                        fillColor: AppColors.photoButton,
                        validator: (v) =>
                            Validators.validateRequired(v, 'Введіть назву посилки'),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          Expanded(
                            child: FormInputField(
                              label: 'Трек-номер (ТТН)',
                              hint: 'Введіть номер ТТН',
                              controller: _tracking,
                              fillColor: AppColors.photoButton,
                              validator: (v) {
                                final base = Validators.validateRequired(
                                    v, 'Введіть трек-номер');
                                if (base != null) return base;
                                final taken = context
                                    .read<ParcelProvider>()
                                    .isTrackingNumberTaken(v!.trim(),
                                    excludeId: widget.initial?.id);
                                return taken
                                    ? 'Посилка з таким трек-номером вже існує'
                                    : null;
                                return null;
                              },
                            ),
                          ),
                          Expanded(
                            child: _dropdown<ParcelCarrier>(
                              label: 'Служба доставки',
                              required: true,
                              value: _carrier,
                              options: {
                                for (final c in ParcelCarrier.values) c: c.label,
                              },
                              onChanged: (v) => setState(() => _carrier = v),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          Expanded(
                            child: FormInputField(
                              label: 'Відправник',
                              hint: "Ім'я або компанія відправника",
                              controller: _sender,
                              isRequired: false,
                              fillColor: AppColors.photoButton,
                            ),
                          ),
                          Expanded(
                            child: FormInputField(
                              label: 'Одержувач',
                              hint: "Ім'я одержувача",
                              controller: _recipient,
                              isRequired: false,
                              fillColor: AppColors.photoButton,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          if(!_isEdit) Expanded(
                            child: FormInputField(
                              label: 'Дата відправлення',
                              hint: 'дд.мм.рррр',
                              controller: _dateCtrl,
                              readOnly: true,
                              onTap: _pickDate,
                              isRequired: false,
                              fillColor: AppColors.photoButton,
                            ),
                          ),
                          Expanded(
                            child: _isEdit
                                ? _currentStatusBlock()
                                : _dropdown<ParcelStatus>(
                              label: 'Початковий статус',
                              value: _status,
                              options: {
                                for (final s in ParcelStatus.values)
                                  s: s.label,
                              },
                              onChanged: (v) => setState(() => _status = v),
                            ),
                          ),
                        ],
                      ),
                      FormInputField(
                        label: 'Примітка',
                        hint: 'Додаткова інформація, опис вмісту чи номер замовлення...',
                        controller: _note,
                        maxLines: 4,
                        isRequired: false,
                        fillColor: AppColors.photoButton,
                      ),
                      if(_isEdit) const ParcelPhotoField(),
                      if(!_isEdit) const ParcelPhotoUpload(),
                      Row(
                        mainAxisAlignment: (!_isEdit) ? MainAxisAlignment.end :
                        MainAxisAlignment.start,
                        spacing: 8,
                        children: [
                          if(_isEdit) FormActionButton(
                            label: "Видалити",
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.error,
                            onPressed: () => showDeleteParcelDialog(context,
                                parcelTitle: widget.initial?.title ?? "Без назви"),
                            fullWidth: false,
                            icon: Icons.delete_outline,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.go(_backPath),
                            child: const Text('Скасувати'),
                          ),
                          FormActionButton(
                            label: 'Зберегти посилку',
                            fullWidth: false,
                            onPressed: _submit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}