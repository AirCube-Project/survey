import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/main_bye.dart';
import 'package:sampleapp/main_choice.dart';
import 'package:sampleapp/timeline.dart';
import 'package:sampleapp/welcome.dart';

import 'main_rule.dart';
import 'main_timepage.dart';
import 'state.dart';

const routeWelcome = '/';
const routeTiming = '/timing';
const routeRules = '/rules';
const routeTimeline = "/timeline";
const routeTimelineNew = "/timeline/new";
const routeChoice = "/choice";
const routeBye = "/bye";

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData.from(
            colorScheme: ColorScheme.light(primary: Colors.deepPurple,
                secondary: Colors.deepPurpleAccent)),
        home: ChangeNotifierProvider<ApplicationState>(
            create: (context) => ApplicationState(), child: NavigatorPage()));
  }
}

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

final _navigatorKey = GlobalKey<NavigatorState>();

class _NavigatorPageState extends State<NavigatorPage> {

  void gotoTiming() {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.save();
    _navigatorKey.currentState.pushNamed(routeTiming);
  }

  void gotoRules() {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.save();
    _navigatorKey.currentState.pushNamed(routeRules);
  }

  void gotoWelcome() {
    _navigatorKey.currentState.pushNamed(routeWelcome);
  }

  void gotoTimeline() {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.save();
    _navigatorKey.currentState.pushNamed(routeTimeline);
  }

  void gotoTimelineNew() {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.save();
    _navigatorKey.currentState.pushNamed(routeTimelineNew);
  }

  void gotoChoice() {
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.save();
    _navigatorKey.currentState.pushNamed(routeChoice);
  }

  void gotoBye(){
    var state = Provider.of<ApplicationState>(context, listen: false);
    state.save();
    _navigatorKey.currentState.pushNamed(routeBye);
  }

  void goBack() {
    _navigatorKey.currentState.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          initialRoute: routeWelcome,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    Widget page;
    // print("Generating route: ${settings.name}");
    switch (settings.name) {
      case routeWelcome:
        page = WelcomeScreen(gotoTiming); //func -> prev, next
        break;
      case routeTiming:
        page = TimePage(goBack, gotoRules);
        break;
      case routeRules:
        page = RulePage(goBack, gotoTimeline);
        break;
      case routeTimeline:
        page = TimeLinePage(goBack, gotoChoice);
        break;
      case routeTimelineNew:
        page = TimeLinePageNew(goBack, gotoChoice);
        break;
      case routeChoice:
        page = ChoicePageHome(gotoBye, gotoTimelineNew);
        break;
      case routeBye:
        page = ByePageHome();
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}
