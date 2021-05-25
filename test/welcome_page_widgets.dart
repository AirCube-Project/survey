import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/state.dart';
import 'package:sampleapp/welcome.dart';

buildWidget(WidgetTester tester, ApplicationState state, Widget widget) async {
  await tester.pumpWidget(ChangeNotifierProvider.value(
      value: state, child: MaterialApp(home: Material(child: widget))));
}

void main() {
  var pageChanged = false;
  //создать состояние для приложения
  var state = ApplicationState();

  //тест виджета выбора пола
  testWidgets("Test gender widget", (WidgetTester tester) async {
    await buildWidget(tester, state, GenderWidget());
//получить доступ к кнопкам выбора пола
    var female = find.byKey(Key("female_gender"));
    var femaleText = find.byKey(Key("female_gender_text"));
    var male = find.byKey(Key("male_gender"));
    var maleText = find.byKey(Key('male_gender_text'));
//убедиться, что виджет существует и только один
    expect(female, findsOneWidget);
    expect(femaleText, findsOneWidget);
    expect(male, findsOneWidget);
    expect(maleText, findsOneWidget);
//проверка взаимодействия с состоянием приложения
//первоначально пол не заполнен
    expect(state.gender, null);
//выбираем и проверяем выбор пола "Женский"
    await tester.tap(female);
    expect(state.gender, Gender.female);
//выбираем и проверяем выбор пола "Мужской"
    await tester.tap(male);
    expect(state.gender, Gender.male);
//выбираем по тексту и проверяем выбор пола "Женский"
    await tester.tap(femaleText);
    expect(state.gender, Gender.female);
//выбираем по текту и проверяем выбор пола "Мужской"
    await tester.tap(maleText);
    expect(state.gender, Gender.male);
  });

  testWidgets("Test age widget", (WidgetTester tester) async {
    await buildWidget(tester, state, AgeWidget());
    var age = find.byKey(Key("age"));
    var error = find.textContaining("Введите корректный возраст");
    //проверка начального значения и существования виджета
    expect(age, findsOneWidget);
    expect(state.age, null);
    //вводим допустимый возраст
    await tester.enterText(age, "40");
    await tester.pumpAndSettle();
    expect(state.age, 40);
    expect(error, findsNothing);
    //вводим возраст выше допустимого
    await tester.enterText(age, "100");
    await tester.pumpAndSettle();
    expect(state.age, null);
    //вводим возраст ниже допустимого
    expect(error, findsOneWidget);
    await tester.enterText(age, "0");
    await tester.pumpAndSettle();
    expect(state.age, null);
    //вводим отрицательный возраст
    expect(error, findsOneWidget);
    await tester.enterText(age, "-20");
    await tester.pumpAndSettle();
    expect(state.age, null);
    expect(error, findsOneWidget);
  });

  testWidgets("Test marital status widget", (WidgetTester tester) async {
    await buildWidget(tester, state, MaritalStatusWidget());
    var level = find.byKey(Key("marital_status"));
    expect(level, findsOneWidget);
    expect(state.maritalStatus, null);

    //открыть список и выбрать "в браке"
    await tester.tap(level);
    await tester.pumpAndSettle();
    var marriaged = find.text("в браке");
    await tester.tap(marriaged.last);
    await tester.pumpAndSettle();
    expect(state.maritalStatus, "в браке");

    //открыть список и выбрать "в разводе"
    await tester.tap(level);
    await tester.pumpAndSettle();
    var divorced = find.text("в разводе");
    await tester.tap(divorced.last);
    await tester.pumpAndSettle();
    expect(state.maritalStatus, "в разводе");
  });

  testWidgets("Test education level widget", (WidgetTester tester) async {
    await buildWidget(tester, state, EducationLevelWidget());
    var level = find.byKey(Key("education_level"));
    expect(level, findsOneWidget);

    expect(state.educationLevel, null);
    //открыть список и выбрать "Магистратура"
    await tester.tap(level);
    await tester.pumpAndSettle();
    var magLevel = find.text("Магистратура");
    await tester.tap(magLevel.last);
    await tester.pumpAndSettle();
    expect(state.educationLevel, "Магистратура");

    //открыть список и выбрать "Аспирантура"
    await tester.tap(level);
    await tester.pumpAndSettle();
    var aspLevel = find.text("Аспирантура");
    await tester.tap(aspLevel.last);
    await tester.pumpAndSettle();
    expect(state.educationLevel, "Аспирантура");
  });

  testWidgets("Test entire welcome page", (WidgetTester tester) async {
    await buildWidget(tester, state, WelcomeScreen(null));
    dynamic welcomeState = await tester.state(find.byType(WelcomeScreen));

    //получаем ссылки на все объекты страницы
    var gender = find.byKey(Key("female_gender"));
    var age = find.byKey(Key("age"));
    var marital_status = find.byKey(Key("marital_status"));
    var education_level = find.byKey(Key("education_level"));

    //изначально заполнение неполное
    expect(welcomeState.correct, false);

    //выбираем пол и проверяем корректность проверки полноты
    await tester.tap(gender);
    await tester.pumpAndSettle();
    expect(welcomeState.correct, false);

    //вводим корректный возраст и проверяем корректность проверки полноты
    await tester.enterText(age, "40");
    await tester.pumpAndSettle();
    expect(welcomeState.correct, false);

    //вводим уровень образования и проверяем корректность проверки полноты
    var magLabel = find.text("Магистратура");
    await tester.tap(education_level);
    await tester.pumpAndSettle();
    await tester.tap(magLabel.last);
    await tester.pumpAndSettle();
    expect(welcomeState.correct, false);

    //вводим семейное положение и проверяем корректность проверки полноты и сохраненные данные
    await tester.tap(marital_status);
    var married = find.text("в браке");
    await tester.pumpAndSettle();
    await tester.tap(married.last);
    await tester.pumpAndSettle();

    expect(state.gender, Gender.female);
    expect(state.age, 40);
    expect(state.educationLevel, "Магистратура");
    expect(state.maritalStatus, "в браке");
    expect(welcomeState.correct, true);
  });
}
