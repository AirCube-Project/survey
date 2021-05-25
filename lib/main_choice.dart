import 'package:flutter/material.dart';

class ChoicePageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: ChoicePageHome(null, null),
    );
  }
}

class ChoicePageHome extends StatelessWidget {
  Function next;

  Function newActivity;

  ChoicePageHome(this.next, this.newActivity);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('Вы оценили базовые активности!')),
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                  'Если Вы регулярно выполняете какую-то активность, Вы можете дополнительно указать её, установить на временной шкале и оценить по 8 параметрам.')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: 256,
              child: ElevatedButton(
                onPressed: newActivity,
                child: Text('Добавить свою активность'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
              ),
            ),
          ),
          SizedBox(
            width: 256,
            child: OutlinedButton(
              onPressed: next,
              child: Text('Завершить опрос'),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          )
        ]));
  }
}
