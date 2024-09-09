import 'dart:math';

import 'package:final_project/models/arisan_bloc.dart';
import 'package:final_project/models/data_logic.dart';
import 'package:final_project/widget_theme/card_widget.dart';
import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'widget_theme/text_theme.dart';

class ShuffleScreen extends StatefulWidget {
  const ShuffleScreen({super.key});

  @override
  State<ShuffleScreen> createState() => _ShuffleScreenState();
}

class _ShuffleScreenState extends State<ShuffleScreen> {
  DataLogic activeParticipantData = DataLogic();
  WinnerBloc winnerBloc = WinnerBloc();
  bool btnUndian = false;

  List<Map<String, dynamic>> dataActiveParticipant = [];

  void initDataActive() async {
    dataActiveParticipant =
        await activeParticipantData.getDataPerson("allDataActiveParticipant");
  }

  @override
  void initState() {
    initDataActive();
    super.initState();
  }

  @override
  void dispose() {
    winnerBloc.dispose();
    super.dispose();
  }

  String resultArisan() {
    Random random = Random();
    int randomNumber = 0;
    int lengthList = dataActiveParticipant.length;
    if(!btnUndian){
      if (lengthList == 0) {
        return "No Candidates!";
      } 
      else {
        btnUndian = true;
        winnerBloc.initDataWinner();
        randomNumber = random.nextInt(lengthList);
        String winnerName = dataActiveParticipant[randomNumber]['nama'];

        winnerBloc.addDataWinner(
          dataActiveParticipant[randomNumber]['nama'],
          dataActiveParticipant[randomNumber]['nik']
        );
        dataActiveParticipant.removeAt(randomNumber);
        debugPrint(dataActiveParticipant.toString());
        debugPrint(activeParticipantData.getDataPerson("allDataWinner").toString());
        activeParticipantData.saveDataPerson(dataActiveParticipant, "allDataActiveParticipant");
        
        return "Congratulation $winnerName!";
      }
    }
    else{
      return "You already shuffled today, shuffle again next week!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: "Back to home",
                backgroundColor: const Color.fromARGB(255, 184, 10, 10),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ScreenHome()));
                }, 
                child: const Icon(color: Colors.white, Icons.arrow_back),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100.0),
                    width: 500,
                    height: 200,
                    child: FloatingActionButton(
                      heroTag: "Shuffle the lottery",
                      backgroundColor: const Color.fromARGB(200, 184, 10, 10),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              scrollable: true,
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(resultArisan(), style: emptyTextStyle, textAlign: TextAlign.center),
                              ),
                            );
                          });
                      },
                      child: Text(
                        'Shuffle', 
                        style: shuffleTextStyle, 
                        textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
