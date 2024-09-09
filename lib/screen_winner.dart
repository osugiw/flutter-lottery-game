import 'package:final_project/models/arisan_bloc.dart';
import 'package:flutter/material.dart';
import 'widget_theme/card_widget.dart';
import 'screen_home.dart';
import 'widget_theme/text_theme.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  WinnerBloc winnerBloc = WinnerBloc();
  ArisanBloc arisanBloc = ArisanBloc();
  ActiveParticipantBloc activeParticipantBloc = ActiveParticipantBloc();

  void initData() async {
    arisanBloc.initDataParticipant();
    activeParticipantBloc.initDataActiveParticipant();
    winnerBloc.initDataWinner();
    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    winnerBloc.dispose();
    arisanBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    width: 600,
                    color: Colors.black54,
                    child: Column(
                      children: [
                        const PageTitleStyle(textValue: 'Winner List'),
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
                        Expanded(
                          child: StreamBuilder<List<Map<String, dynamic>>>(
                            initialData: winnerBloc.allDataWinner,
                            stream: winnerBloc.arisan,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error : ${snapshot.error}');
                              }
                              else if (snapshot.hasData) {
                                final dataParticipants = snapshot.data;
                                if( dataParticipants!.isNotEmpty){
                                  return ListView.builder(
                                    itemCount: dataParticipants.length,
                                    itemBuilder: (context, index) {
                                        return ParticipantCard(
                                            participantName:
                                                dataParticipants[index]['nama'] ?? 'undefined',
                                            nik: dataParticipants[index]['nik'] ?? 'undefined');
                                    },
                                  );
                                }
                              } 
                              return const EmptyDataCard(text: 'Empty Winner!');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 184, 10, 10),
        onPressed: () {
          // arisanBloc.removeDataPerson();
          winnerBloc.removeDataWinner();
          activeParticipantBloc.reinitDataActiveParticipant();
          // activeParticipantBloc.removeDataActive();
        },
        child: const Icon(color: Colors.white, Icons.delete_forever),
      ),
    );
  }
}