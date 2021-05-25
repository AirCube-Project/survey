import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state.dart';
import 'timeline.dart';

enum Gender { female, male }

class GenderWidget extends StatefulWidget {
  Function onChange;

  GenderWidget({this.onChange});

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  Gender _gender;

  @override
  void initState() {
    var state = Provider.of<ApplicationState>(context, listen: false);
    _gender = state.gender;
  }

  void changeGender(Gender value) {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.gender = value;
    setState(() {
      _gender = value;
    });
    widget.onChange();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 8),
          child: Align(
            child: Text("Пол",
                style: TextStyle(
                  fontSize: 16,
                )),
            alignment: Alignment.topLeft,
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: mq.size.width / 2,
              height: 32,
              child: ListTile(
                title: GestureDetector(
                  child: const Text("женский", key: Key("female_gender_text")),
                  onTap: () {
                    changeGender(Gender.female);
                  },
                ),
                leading: Radio<Gender>(
                  key: Key("female_gender"),
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (_) {
                    changeGender(Gender.female);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 8),
              child: SizedBox(
                width: (mq.size.width / 2) - 40,
                height: 40,
                child: ListTile(
                  title: GestureDetector(
                    child: const Text("мужской", key: Key("male_gender_text")),
                    onTap: () {
                      setState(() {
                        changeGender(Gender.male);
                      });
                    },
                  ),
                  leading: Radio<Gender>(
                    key: Key("male_gender"),
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (_) {
                      changeGender(Gender.male);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

GlobalKey<FormState> _ageForm = GlobalKey();

class AgeWidget extends StatefulWidget {
  Function onChange;

  AgeWidget({this.onChange});

  @override
  _AgeWidgetState createState() => _AgeWidgetState();
}

class _AgeWidgetState extends State<AgeWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    var state = Provider.of<ApplicationState>(context, listen: false);
    _controller = TextEditingController(
        text: state.age != null ? state.age.toString() : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 8),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text("Возраст",
                  style: TextStyle(
                    fontSize: 16,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _ageForm,
            child: TextFormField(
              key: Key("age"),
              controller: _controller,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Должно быть введено";
                if (int.tryParse(value) == null) return "Введите число";
                if (int.parse(value) < 3 || int.parse(value) > 95)
                  return "Введите корректный возраст";
                return null;
              },
              onChanged: (v) {
                var state =
                    Provider.of<ApplicationState>(context, listen: false);
                if (_ageForm.currentState.validate()) {
                  state.age = int.parse(_controller.value.text);
                } else {
                  state.age = null;
                }
                widget.onChange();
              },
              // onSubmitted: (String value) {
              //   print(value);
              // },
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MaritalStatusWidget extends StatefulWidget {
  Function onChange;

  MaritalStatusWidget({this.onChange});

  @override
  _MaritalStatusWidgetState createState() => _MaritalStatusWidgetState();
}

class _MaritalStatusWidgetState extends State<MaritalStatusWidget> {
  String _maritalStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = Provider.of<ApplicationState>(context, listen: false);
    _maritalStatus = state.maritalStatus;
    if (_maritalStatus != null && _maritalStatus.isEmpty) _maritalStatus = null;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 8),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text("Семейное положение",
                  style: TextStyle(
                    fontSize: 16,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            width: mq.size.width,
            child: DropdownButton<String>(
              key: Key("marital_status"),
              value: _maritalStatus,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String value) {
                var state =
                    Provider.of<ApplicationState>(context, listen: false);
                state.maritalStatus = value;
                // print(state.maritalStatus);
                setState(() {
                  _maritalStatus = value;
                });
                widget.onChange();
              },
              items: <String>[
                "одинок",
                "в отношениях",
                "в браке",
                "в разводе",
                "вдова/вдовец"
              ]
                  .map((String value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}

class EducationLevelWidget extends StatefulWidget {

  Function onChange;

  EducationLevelWidget({this.onChange});

  @override
  _EducationLevelWidgetState createState() => _EducationLevelWidgetState();
}

class _EducationLevelWidgetState extends State<EducationLevelWidget> {
  String _educationLevel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = Provider.of<ApplicationState>(context, listen: false);
    _educationLevel = state.educationLevel;
    if (_educationLevel != null && _educationLevel.isEmpty)
      _educationLevel = null;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 8),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Уровень образования",
                  style: TextStyle(
                    fontSize: 16,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          child: SizedBox(
            width: mq.size.width,
            child: DropdownButton<String>(
              key: Key("education_level"),
              value: _educationLevel,
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String value) {
                var state =
                    Provider.of<ApplicationState>(context, listen: false);
                state.educationLevel = value;
                setState(() {
                  _educationLevel = value;
                });
                widget.onChange();
              },
              items: <String>[
                "Без образования",
                "Основное общее образование (9 классов)",
                "Среднее общее образование (11 классов)",
                "Среднее профессиональное образование",
                "Бакалавриат",
                "Магистратура",
                "Аспирантура"
              ]
                  .map((String value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  Function next;

  WelcomeScreen(this.next);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool correct = false;

  updateState(ApplicationState state) {
    setState(() {
      correct = state.educationLevel != null &&
          state.educationLevel.isNotEmpty &&
          state.maritalStatus != null &&
          state.maritalStatus.isNotEmpty &&
          state.gender != null &&
          state.age != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Consumer<ApplicationState>(
            builder: (context, state, child) => Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 8),
                    child: Text("Здравствуйте!",
                        key: Key('welcome_title'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Text(
                      "Предлагаем Вам поучаствовать в опросе для исследования в рамках магистерской диссертации.",
                      softWrap: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Text(
                        "Сначала укажите, пожалуйста, Ваши данные. Опрос проходит анонимно, все полученные данные будут использоваться для обучения рекомендательной системы по эффективному планированию и здоровому образу жизни.",
                        softWrap: true),
                  ),
                  GenderWidget(
                    onChange: () {
                      updateState(state);
                    },
                  ),
                  AgeWidget(
                    onChange: () {
                      updateState(state);
                    },
                  ),
                  MaritalStatusWidget(
                    onChange: () {
                      updateState(state);
                    },
                  ),
                  EducationLevelWidget(
                    onChange: () {
                      updateState(state);
                    },
                  ),
                  ElevatedButton(
                      key: Key("welcome_next"),
                      onPressed: correct ? widget.next : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Text("Начать опрос"),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: correct
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          side: BorderSide(
                              color: correct
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              width: correct ? 2 : 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ])));
  }
}
