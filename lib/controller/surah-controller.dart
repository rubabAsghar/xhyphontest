import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SurahController extends GetxController {
  var surahNames = <String>[].obs;
  var isLoading = true.obs;
  var selectedSurah = RxString('');
  var ayahs = RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    fetchSurahNames();
    super.onInit();
  }

  Future<void> fetchSurahNames() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.alquran.cloud/v1/quran/ur.jhaladhry'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        final List<dynamic> surahs = jsonData['data']['surahs'];
        surahNames.value = surahs.map<String>((item) => item['englishName'].toString()).toList();
        isLoading.value = false;
      } else {
        throw Exception('Failed to load surah names (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching surah names: $e');

    }
  }

  Future<void> fetchAyahs(String surahName) async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(
          'https://api.alquran.cloud/v1/quran/ur.jhaladhry'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);


        List<dynamic> ayahsData = <dynamic>[];
        if (jsonData['data']['surahs']['ayahs'] != null) {
          ayahsData = jsonData['data']['ayahs'];
        } else {
          print('Error: ayahs data is null in the API response');
        }

        final filteredAyahs = ayahsData.where((ayah) => ayah['surah']['englishName'] == surahName).toList();
        ayahs.value = filteredAyahs.cast<Map<String, dynamic>>().toList();
        selectedSurah.value = surahName;
      } else {
        throw Exception('Failed to load ayahs (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching ayahs: $e');

    } finally {
      isLoading.value = false;
    }
  }
}
