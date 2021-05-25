//import 'package:day_night_time_picker/lib/constants.dart';
// import 'dntp/day_night_time_picker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state.dart';

class TimePage extends StatefulWidget {
  Function prev;

  Function next;

  TimePage(this.prev, this.next);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  String paddedNumber(int n) {
    if (n < 10) return "0" + n.toString();
    return n.toString();
  }

  String formatTOD(TimeOfDay tod) {
    return paddedNumber(tod.hour) + ":" + paddedNumber(tod.minute);
  }

  TimeOfDay _awakeTime;
  TimeOfDay _sleepTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = Provider.of<ApplicationState>(context, listen: false);
    setState(() {
      _awakeTime = state.awakeTime;
      _sleepTime = state.sleepTime;
    });
  }

  void onAwakeTimeChanged(TimeOfDay newAwakeTime) {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.awakeTime = newAwakeTime;

    setState(() {
      _awakeTime = newAwakeTime;
    });
  }

  void onSleepTimeChanged(TimeOfDay newSleepTime) {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.sleepTime = newSleepTime;

    setState(() {
      _sleepTime = newSleepTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                  'Введите, пожалуйста, примерное время, в которое вы регулярно просыпаетесь и засыпаете.'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: Row(children: [
                Text(
                  'Время пробуждения',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.right,
                ),
              ]),
            ),
            if (_awakeTime != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("${formatTOD(_awakeTime)}"),
              ),
            OutlinedButton(
              onPressed: () => Navigator.of(context).push(showPicker(
                blurredBackground: true,
                value: _awakeTime ?? TimeOfDay(hour: 8, minute: 0),
                onChange: onAwakeTimeChanged,
                context: context,
                is24HrFormat: true,
                cancelText: ' Отмена',
                okText: 'Ок',
                hourLabel: 'часы',
                minuteLabel: 'минуты',
              )),
              child: Text('Выбрать время пробуждения'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: Row(children: [
                Text(
                  'Время засыпания',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ]),
            ),
            if (_sleepTime != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("${formatTOD(_sleepTime)}"),
              ),
            OutlinedButton(
              onPressed: () => Navigator.of(context).push(showPicker(
                blurredBackground: true,
                value: _sleepTime ?? TimeOfDay(hour: 23, minute: 0),
                onChange: onSleepTimeChanged,
                context: context,
                is24HrFormat: true,
                cancelText: 'Отмена',
                okText: 'Ок',
                hourLabel: 'часы',
                minuteLabel: 'минуты',
              )),
              child: Text('Выбрать время засыпания'),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Назад'),
                  ),
                  onPressed: widget.prev,
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                Consumer<ApplicationState>(builder: (context, state, child) {
                  var correct = state.sleepTime!=null && state.awakeTime!=null;
                  return OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Далее', style: TextStyle(color: correct ? Theme.of(context).primaryColor : Colors.grey),),
                    ),
                    onPressed: widget.next,
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: correct
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            width: correct ? 2 : 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30))),
                  );
                }),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
