import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/back_wrap.dart';
import '../../components/color_button.dart';
import '../../components/dialog_wrap.dart';
import '../../components/text_input.dart';
import '../../core/state/user_dialog_provider.dart';
import '../../models/user.dart';

class AddDutyDialog extends StatefulWidget {
  const AddDutyDialog({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  _AddDutyDialogState createState() {
    return _AddDutyDialogState();
  }
}

class _AddDutyDialogState extends State<AddDutyDialog> {
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
      height: 300,
      child: BackWrap(
        voidCallback: () {
          userProvider.clearVariables();
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserDialogProvider>(
                builder: (_, notifier, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Нове чергування бійця",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                  );
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
                        function: notifier.validateNewDutyFields()
                            ? () {
                                notifier
                                    .addNewDutyToUserAndSaveToDb(widget.user);
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
