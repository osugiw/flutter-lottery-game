import 'dart:async';
import 'dart:developer';
import 'data_logic.dart';

class ArisanBloc{
  DataLogic dataLogic = DataLogic();

  List<Map<String, dynamic>> allDataPerson = [];

  final _arisanController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get arisan => _arisanController.stream;
  StreamSink<List<Map<String, dynamic>>> get _arisanSink => _arisanController.sink;

  void addDataParticipant(String nama, String nik){
    allDataPerson.add({
      "nama": nama,
      "nik": nik,
    });

    dataLogic.saveDataPerson(allDataPerson, "allDataParticipants");

    _arisanSink.add(allDataPerson);
  }

  void removeDataPerson(){
    allDataPerson.removeRange(0, allDataPerson.length);
    dataLogic.saveDataPerson(allDataPerson, "allDataParticipants");

    log(allDataPerson.toString());
    _arisanSink.add(allDataPerson);
  }

  void initDataParticipant() async{
    allDataPerson.addAll(await dataLogic.getDataPerson("allDataParticipants"));
    _arisanSink.add(allDataPerson);
  }

  void dispose(){
    _arisanController.close();
  }
}

class WinnerBloc{
  DataLogic dataLogic = DataLogic();

  List<Map<String, dynamic>> allDataWinner = [];

  final _winnerController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get arisan => _winnerController.stream;
  StreamSink<List<Map<String, dynamic>>> get _winnerSink => _winnerController.sink;

  void addDataWinner(String nama, String nik){
    allDataWinner.add({
      "nama": nama,
      "nik": nik,
    });

    dataLogic.saveDataPerson(allDataWinner, "allDataWinner");

    _winnerSink.add(allDataWinner);
  }

  void removeDataWinner(){
    allDataWinner.removeRange(0, allDataWinner.length);
    dataLogic.saveDataPerson(allDataWinner, "allDataWinner");

    log(allDataWinner.toString());
    _winnerSink.add(allDataWinner);
  }

  void initDataWinner() async{
    allDataWinner.addAll(await dataLogic.getDataPerson("allDataWinner"));
    _winnerSink.add(allDataWinner);
  }

  void dispose(){
    _winnerController.close();
  }
}

class ActiveParticipantBloc{
  DataLogic dataLogic = DataLogic();

  List<Map<String, dynamic>> allDataActiveParticipant = [];

  void addDataActiveParticipant(String nama, String nik){
    allDataActiveParticipant.add({
      "nama": nama,
      "nik": nik,
    });

    dataLogic.saveDataPerson(allDataActiveParticipant, "allDataActiveParticipant");
  }

  void removeDataActive(){
    allDataActiveParticipant.removeRange(0, allDataActiveParticipant.length);
    log("before $allDataActiveParticipant.toString()");
    dataLogic.saveDataPerson(allDataActiveParticipant, "allDataActiveParticipant");
    log("after $allDataActiveParticipant.toString()");
  }

  Future<List<Map<String, dynamic>>> initDataActiveParticipant() async{
    allDataActiveParticipant.addAll(await dataLogic.getDataPerson("allDataActiveParticipant"));
    return List<Map<String, dynamic>>.from(allDataActiveParticipant);
  }

  Future<List<Map<String, dynamic>>> reinitDataActiveParticipant() async{
    allDataActiveParticipant.addAll(await dataLogic.getDataPerson("allDataParticipants"));
    dataLogic.saveDataPerson(allDataActiveParticipant, "allDataActiveParticipant");
    
    return List<Map<String, dynamic>>.from(allDataActiveParticipant);
  }
}