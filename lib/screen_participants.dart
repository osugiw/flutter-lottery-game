import 'package:final_project/models/arisan_bloc.dart';
import 'package:final_project/screen_home.dart';
import 'package:final_project/widget_theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'widget_theme/card_widget.dart';

class ParticipantScreen extends StatefulWidget {
  const ParticipantScreen({super.key});

  @override
  State<ParticipantScreen> createState() => _ParticipantScreenState();
}

class _ParticipantScreenState extends State<ParticipantScreen> {
  ArisanBloc arisanBloc = ArisanBloc();
  ActiveParticipantBloc activeParticipantBloc = ActiveParticipantBloc();

  String _name = '';
  String _nik = '';
  final nameController = TextEditingController();
  final nikController = TextEditingController();
  bool emptyData = false;


  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    nameController.dispose();
    nikController.dispose();
    arisanBloc.dispose();
    super.dispose();
  }

  void initData() async {
    arisanBloc.initDataParticipant();
    activeParticipantBloc.initDataActiveParticipant();
    setState(() {});
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
                        const PageTitleStyle(textValue: "Participants List"),
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
                          width: 500,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text("NIK", style: headerTextStyle, textAlign: TextAlign.center),
                                  ),
                                ),
                                const VerticalDivider(
                                  width: 10,
                                  thickness: 2,
                                  indent: 15,
                                  endIndent: 15,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text("Name", style: headerTextStyle, textAlign: TextAlign.center),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<List<Map<String, dynamic>>>(
                            initialData: arisanBloc.allDataPerson,
                            stream: arisanBloc.arisan,
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
                              return  const EmptyDataCard(text: 'Data Peserta tidak tersedia!');
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
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  scrollable: true,
                  title: const Center(child: Text('Input Data Peserta')),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  labelText: 'Full Name', 
                                  hintText: 'Ganjar Pranowo'),
                              keyboardType: TextInputType.name,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: nikController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  labelText: 'NIK',
                                  hintText: '01014189'),
                              keyboardType: TextInputType.number,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your NIK';
                                }
                                else if (value.length < 8) {
                                  return 'NIK is too short';
                                } else if (value.length > 8) {
                                  return 'NIK is too long';
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              width: 150,
                              child: FloatingActionButton(
                                heroTag: "Submit new participant",
                                backgroundColor: const Color.fromARGB(255, 184, 10, 10),
                                onPressed: () {
                                  if(nameController.text.isNotEmpty && nikController.text.isNotEmpty && (nikController.text.length == 8)){
                                    _name = nameController.text;
                                    _nik = nikController.text;
                                    arisanBloc.addDataParticipant(_name, _nik);
                                    activeParticipantBloc.addDataActiveParticipant(_name, _nik);
                                  }
                                  else{
                                    emptyData = true;
                                  }
                                  nameController.clear();
                                  nikController.clear();
                                  Navigator.of(context).pop(); 
                                  
                                  // Pop-up error message
                                  if(emptyData){
                                    emptyData = false;
                                    showDialog(
                                      context: context, 
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Center(
                                            child: SizedBox(
                                              height: 120,
                                              width: 500,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    height: 50,
                                                    width: 500,
                                                    color: const Color.fromARGB(255, 184, 10, 10),
                                                    child: Text(
                                                      "Error",
                                                      style: headerTextStyle,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                    child: Text(
                                                      "Name and NIK cannot be null!", 
                                                      style: errorTextStyle, 
                                                      textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                ],
                                              )
                                            )
                                          ),
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Text('Submit', style: submitButtonTextStyle)
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  );
                }
            );
          },
        child: const Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}