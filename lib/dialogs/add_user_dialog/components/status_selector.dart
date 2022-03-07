import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/user_dialog_provider.dart';

enum SoldierStatus { onDuty, free, none }

class StatusSelector extends StatefulWidget {
  const StatusSelector({
    Key? key,
  }) : super(key: key);

  @override
  _StatusSelectorState createState() {
    return _StatusSelectorState();
  }
}

class _StatusSelectorState extends State<StatusSelector> {
  SoldierStatus? _character = SoldierStatus.none;
  late UserDialogProvider userProvider;

  @override
  void initState() {
    userProvider = context.read<UserDialogProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('На чергуванні'),
          leading: Radio<SoldierStatus>(
            value: SoldierStatus.onDuty,
            groupValue: _character,
            onChanged: (SoldierStatus? value) {
              setState(() {
                _character = value;
                userProvider.changeSoldierStatus(value);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Вільний'),
          leading: Radio<SoldierStatus>(
            value: SoldierStatus.free,
            groupValue: _character,
            onChanged: (SoldierStatus? value) {
              setState(() {
                _character = value;
                userProvider.changeSoldierStatus(value);
              });
            },
          ),
        ),
      ],
    );
  }
}
