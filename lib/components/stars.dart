import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import '../timeline.dart';

class ScrollableStars extends StatefulWidget {
  int step;

  ScrollableStars(this.step, {Key key}): super(key: key);

  @override
  _ScrollableStarsState createState() => _ScrollableStarsState();
}

class _ScrollableStarsState extends State<ScrollableStars> {
  ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Step for stars is ${widget.step}");
    var appState = Provider.of<ApplicationState>(context, listen: false);
    scrollController = ScrollController(initialScrollOffset: appState.scrollPositions[appState.step]);
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    var appState = Provider.of<ApplicationState>(context, listen: false);
    appState.scrollPositions[appState.step] = scrollController.offset;
  }

  var titles = [
    {
      "name": "Интеллектуальная сложность",
      "choices": ["Тяжело", "Сложно", "Средне", "Несложно", "Просто"]
    },
    {
      "name": "Физическая нагрузка",
      "choices": ["Тяжело", "Сложно", "Средне", "Несложно", "Просто"]
    },
    {
      "name": "Стресс",
      "choices": [
        "Сильный стресс",
        "Страх",
        "Тревога",
        "Волнение",
        "Спокойствие"
      ]
    },
    {
      "name": "Удовольствие",
      "choices": [
        "Не нравится",
        "Безразлично",
        "Нормально",
        "Нравится",
        "Очень нравится"
      ]
    },
    {
      "name": "Креативность",
      "choices": [
        "Рутинно",
        "Низкая креативность",
        "Средне",
        "Креативно",
        "Очень креативно"
      ]
    },
    {
      "name": "Важность для профессионального роста",
      "choices": [
        "Совсем не важно",
        "Не важно",
        "Средне",
        "Важно",
        "Очень важно"
      ]
    },
    {
      "name": "Важность для здоровья",
      "choices": [
        "Совсем не важно",
        "Не важно",
        "Средне",
        "Важно",
        "Очень важно"
      ]
    },
    {
      "name": "Важность для саморазвития",
      "choices": [
        "Совсем не важно",
        "Не важно",
        "Средне",
        "Важно",
        "Очень важно"
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var height = mq.size.height;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4.0,
          child: SizedBox(
            width: double.infinity,
            height: height - 388 - 64,
            child: ListView.builder(
                controller: scrollController,
                itemCount: titles.length,
                itemBuilder: (BuildContext context, int id) => StarsLine(
                    key: UniqueKey(),
                    stars: 5,
                    choices: titles[id]["choices"],
                    size: 24,
                    title: titles[id]["name"],
                    grade: id)),
          ),
        ));
  }
}

class StarsLine extends StatefulWidget {
  int stars;

  int grade;

  List<String> choices;

  double padding;

  double height;

  double size;

  String title;

  Color activeColor;
  Color inactiveColor;

  StarsLine(
      {this.stars = 5,
      this.choices,
      this.padding = 16,
      this.height = 80,
      this.size = 32,
      this.activeColor = Colors.deepPurple,
      this.inactiveColor = Colors.black26,
      this.title,
      @required this.grade,
      Key key})
      : super(key: key);

  @override
  _StarsLineState createState() => _StarsLineState();
}

class _StarsLineState extends State<StarsLine> {
  _StarsLineState();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var screenWidth = mq.size.width;
    var width = (screenWidth - 2 * widget.padding) / widget.stars;
    var appState = Provider.of<ApplicationState>(context);
    // print("Building...");
    var star = appState.getScore(widget.grade);
    return Container(
        padding: EdgeInsets.only(top: 16),
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(left: widget.padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.black87, fontSize: 18),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (var displayStar
                in List<int>.generate(widget.stars, (int n) => n + 1))
              SizedBox(
                width: width,
                height: widget.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: IconButton(
                          icon: Icon(
                            displayStar == star
                                ? Icons.star
                                : Icons.star_border,
                            size: widget.size,
                            color: displayStar == star
                                ? widget.activeColor
                                : widget.inactiveColor,
                          ),
                          onPressed: () {
                            setState(() {
                              var state = Provider.of<ApplicationState>(context,
                                  listen: false);
                              state.setScore(this.widget.grade, displayStar);
                            });
                          }),
                    ),
                    Text(
                      widget.choices[displayStar - 1],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
          ])
        ]));
  }
}
