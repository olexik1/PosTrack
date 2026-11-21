import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/form_input_field.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';

class StatusChangeResult {
  final ParcelStatus status;
  final String comment;
  const StatusChangeResult({required this.status, required this.comment});
}

Future<StatusChangeResult?> showChangeStatusDialog(
    BuildContext context, {
      required ParcelStatus currentStatus,
    }) {
  return showDialog<StatusChangeResult>(
    context: context,
    builder: (_) => _ChangeStatusDialog(currentStatus: currentStatus),
  );
}

class _ChangeStatusDialog extends StatefulWidget {
  final ParcelStatus currentStatus;
  const _ChangeStatusDialog({required this.currentStatus});

  @override
  State<_ChangeStatusDialog> createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<_ChangeStatusDialog> {
  late ParcelStatus _selected;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selected = widget.currentStatus;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Зміна статусу посилки',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  const Text(
                    'Поточний стан:',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  StatusChip(status: widget.currentStatus),
                ],
              ),
              const Text(
                'Оберіть новий статус',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.photoButton,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    for (final s in ParcelStatus.values)
                      _StatusOption(
                        status: s,
                        selected: s == _selected,
                        onTap: () => setState(() => _selected = s),
                      ),
                  ],
                ),
              ),
              FormInputField(
                label: 'Коментар або примітка до статусу',
                hint: 'Наприклад: Відділення №12',
                controller: _commentController,
                isRequired: false,
                fillColor: AppColors.photoButton,
                labelTrailing: const Text(
                  "(необов'язково)",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Скасувати'),
                  ),
                  FormActionButton(
                    label: 'Оновити статус',
                    fullWidth: false,
                    onPressed: _selected == widget.currentStatus
                        ? null
                        : () => Navigator.of(context).pop(
                      StatusChangeResult(
                        status: _selected,
                        comment: _commentController.text.trim(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  final ParcelStatus status;
  final bool selected;
  final VoidCallback onTap;

  const _StatusOption({
    required this.status,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.white : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected ? AppColors.primary : Colors.transparent,
        ),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            spacing: 12,
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                size: 20,
                color: selected ? AppColors.primary : AppColors.hint,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: status.textColor,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                status.label,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}