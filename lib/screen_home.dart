import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project/widget_theme/text_theme.dart';
import 'screen_participants.dart';
import 'screen_winner.dart';
import 'screen_shuffle.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arisan Software',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 4, 242, 255)),
        useMaterial3: true,
      ),
      home: const MyHome(title: ''),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.title});
  final String title;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 100.0, bottom: 100.0),
            width: 600,
            color: Colors.black54,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        const PageTitleStyle(textValue: "Arisanku"),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 500,
                            child: Divider(
                              height: 20,
                              thickness: 5,
                              indent: 10,
                              endIndent: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 500.0,
                          height: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              heroTag: "btnParticipantScreen",
                              splashColor: const Color.fromARGB(255, 148, 145, 145),
                              backgroundColor:
                                  const Color.fromARGB(255, 184, 10, 10),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con0text) =>
                                            const ParticipantScreen()));
                              },
                              child: Text(
                                "Participants",
                                style: buttonTextOptionStyle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 500.0,
                          height: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              heroTag: "btnWeeklyWinnerScreen",
                              splashColor: const Color.fromARGB(255, 148, 145, 145),
                              backgroundColor:
                                  const Color.fromARGB(255, 184, 10, 10),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con0text) =>
                                            const WinnerScreen()));
                              },
                              child: Text(
                                "Weekly Winner",
                                style: buttonTextOptionStyle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 500.0,
                          height: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              heroTag: "btnShuffleParticipants",
                              backgroundColor:
                                  const Color.fromARGB(255, 184, 10, 10),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con0text) =>
                                            const ShuffleScreen()));
                              },
                              child: Text(
                                "Shuffle",
                                style: buttonTextOptionStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
