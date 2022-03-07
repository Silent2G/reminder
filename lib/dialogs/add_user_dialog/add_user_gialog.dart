import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/components/color_button.dart';

import '../../components/back_wrap.dart';
import '../../components/dialog_wrap.dart';
import '../../components/text_input.dart';
import '../../core/state/user_dialog_provider.dart';
import 'components/status_selector.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({
    Key? key,
  }) : super(key: key);

  @override
  _AddUserDialogState createState() {
    return _AddUserDialogState();
  }
}

class _AddUserDialogState extends State<AddUserDialog> {
  late UserDialogProvider userProvider;

  @override
  void initState() {
    userProvider = context.read<UserDialogProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2,
      ),
    );
    return DialogWrap(
      child: BackWrap(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Номер бійця",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextInput(
                controller: userProvider.numberController,
                enabled: true,
                decoration: const InputDecoration(
                    focusedBorder: border,
                    enabledBorder: border,
                    hintText: "Додайте номер бійця"),
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Статус бійця",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const StatusSelector(),
              const SizedBox(
                height: 10,
              ),
              Consumer<UserDialogProvider>(
                builder: (_, notifier, __) {
                  return notifier.soldierStatus == SoldierStatus.onDuty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextInput(
                              controller: userProvider.hoursController,
                              enabled: true,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  hintText: "Кількість годин чергування"),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            notifier.startDutyTime == null
                                ? InkWell(
                                    onTap: () async {
                                      final now = DateTime.now();
                                      final TimeOfDay? newTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                          hour: now.hour,
                                          minute: now.minute,
                                        ),
                                        initialEntryMode:
                                            TimePickerEntryMode.input,
                                      );
                                      if (newTime != null) {
                                        notifier.setStartHour(newTime);
                                      }
                                    },
                                    child: const Text(
                                      "Вкажіть годину початку чергування (натисніть тут)",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : Text(
                                    DateFormat('yyyy-MM-dd – kk:mm')
                                        .format(notifier.startDutyTime!),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        )
                      : Container();
                },
              ),
              const SizedBox(
                height: 45,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ColorButton(
                  title: "Додати",
                  color: Colors.blue,
                  function: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
