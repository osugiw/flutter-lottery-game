import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataLogic{
  static String keyDataPerson = "data_participants";

  Future<void> saveDataPerson(List<Map<String, dynamic>> dataPerson, String keyData) async {
    final spreferences = await SharedPreferences.getInstance();

    // Konversi List<Map<String, dynamic>> menjadi List<String>
    final jsonStringList = dataPerson.map((map) => jsonEncode(map)).toList();

    // Simpan List<String> JSON ke SharedPreferences
    await spreferences.setStringList(keyData, jsonStringList);
  }

  Future<List<Map<String, dynamic>>> getDataPerson(String keyData) async {
    final spreferences = await SharedPreferences.getInstance();

    // Ambil List<String> JSON dari SharedPreferences
    final jsonStringList = spreferences.getStringList(keyData);

    // Konversi List<String> JSON menjadi List<Map<String, dynamic>>
    final myList =
        jsonStringList?.map((jsonString) => jsonDecode(jsonString)).toList() ??
            [];
    return List<Map<String, dynamic>>.from(myList);
  }
}