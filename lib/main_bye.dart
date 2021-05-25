import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ByePageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Благодарим за участие в опросе!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              // print("Tapped");
              launch("mailto:aircube.project@gmail.com");
            },
            child: RichText(
              text: TextSpan(style: DefaultTextStyle.of(context).style,
                  // TextStyle(
                  //   fontFamily: 'Roboto',
                  //   fontWeight: FontWeight.normal,
                  //   fontSize: 16,
                  // ),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            'Если у Вас возникли вопросы или предложения, Вы можете написать на почту '),
                    TextSpan(
                        text: 'aircube.project@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.deepPurple)),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

// class ByePageState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       child: Column(
//
//       ),
//     );
// }
// }
