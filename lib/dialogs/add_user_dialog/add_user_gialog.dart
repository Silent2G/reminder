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

  void _setStartTime(UserDialogProvider notifier) async {
    final now = DateTime.now();
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: now.hour,
        minute: now.minute,
      ),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      notifier.setStartHour(newTime);
    }
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
        voidCallback: () {
          userProvider.clearVariables();
        },
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
                onChanged: userProvider.getOnChangedFunctionNumber(),
                decoration: const InputDecoration(
                    focusedBorder: border,
                    enabledBorder: border,
                    hintText: "Додайте номер бійця"),
                textStyle: const TextStyle(
                  fontSize: 18,
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
              const StatusSelector(),
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
                              onChanged: notifier.getOnChangedFunctionHours(),
                              decoration: const InputDecoration(
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  hintText: "Кількість годин чергування"),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            notifier.startDutyTime == null
                                ? InkWell(
                                    onTap: () async {
                                      _setStartTime(notifier);
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
                                : InkWell(
                                    onTap: () async {
                                      _setStartTime(notifier);
                                    },
                                    child: Text(
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(notifier.startDutyTime!),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                          ],
                        )
                      : Container();
                },
              ),
              Consumer<UserDialogProvider>(builder: (_, notifier, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ColorButton(
                        title: "Додати",
                        color: Colors.blue,
                        function: notifier.validateFields()
                            ? () {
                                notifier.createUserAndSaveToDb();
                                notifier.clearVariables();

                                Navigator.of(context).pop();
                              }
                            : null,
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
