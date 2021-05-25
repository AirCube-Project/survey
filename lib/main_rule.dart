import 'package:flutter/material.dart';
import 'package:sampleapp/main_timepage.dart';

import 'state.dart';
import 'timeline.dart';

class RulePage extends StatelessWidget {
  Function prev;

  Function next;

  RulePage(this.prev, this.next);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8, left: 24),
                child: Text(
                    'В опросе Вам будет предложено выбрать временной промежуток, в который наиболее удобно для Вас было бы выполнить текущую активность, а также оценить ряд типичных активностей по 8 шкалам.')),
            Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 24),
                child: Text(
                    'Если активность не является типичной для Вас, пропустите её. Если в опросе не было указано свойственной для Вас активности, Вы можете добавить одну или несколько активностей после опроса и оценить их по тем же шкалам.')),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24, left: 24),
              child: Text(
                'Пример заполнения',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
          Container(
            width: mq.size.width,
            child: PhysicalModel(
                color: Colors.white,
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: mq.size.width / 100),
                  width: mq.size.width - 2 * mq.size.width / 100,
                  height: 128,
                  color: Colors.black26,
                  child: CustomPaint(
                      painter: TimeLinePainter(
                          (23 * 60 - 8 * 60) ~/ 15,
                          15,
                          8 * 60,
                          [
                            Event("Завтрак", 8 * 60 + 20, 20, Colors.green, 1),
                            Event("Просмотр Youtube", 8 * 60 + 35, 15,
                                Colors.redAccent, 2),
                            Event("Работа", 9*60, 3*60, Colors.deepPurpleAccent, 3),
                            Event("Обед", 12*60, 40, Colors.lightGreen, 4),
                            Event("Душ", 22 * 60 + 15, 15, Colors.lightBlue, 5)
                          ],
                          5,
                          mq.size.width / 100)),
                )),
          ),
          //тут пример заполнения
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(left: 24, top: 24, bottom: 8),
              child: Text(
                'Для размещения активности, нажмите на любое пустое место временной шкалы. Повторное нажатие дублирует активность на шкале.',
                style: TextStyle(height: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: Text(
                  'Для перемещения активности, выделите её и потяните, захватите за край активности, чтобы увеличить время. Для редактирования активности, выделите её. Для удаления активности, нажмите на неё правой кнопкой мыши или долгим нажатием. Активности можно размещать друг над другом, если события идут параллельно. Если активность следует одна за другой, при перемещении активности к соседней, она приклеивается справа или слева.',
                  style: TextStyle(height: 1.5)),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Назад'),
                    ),
                    onPressed: prev,
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (_) => Page2()));
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Далее',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onPressed: next,
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
