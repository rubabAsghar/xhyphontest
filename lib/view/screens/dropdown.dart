import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/surah-controller.dart';

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final surahController = Get.put(SurahController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Al Quran'),
      ),
      body: Center(
        child: Obx(() {
          if (surahController.isLoading.value) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [
                DropdownButton<String>(
                  hint: Text('Select a Surah'),
                  items: surahController.surahNames.map((String surahName) {
                    return DropdownMenuItem<String>(
                      value: surahName,
                      child: Text(surahName),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      surahController.fetchAyahs(newValue);
                    }
                  },
                ),

                if (surahController.selectedSurah.value != '' &&
                    surahController.ayahs.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: surahController.ayahs.length,
                      itemBuilder: (context, index) {
                        final ayah = surahController.ayahs[index];
                        return Text('Ayah ${ayah['number']}: ${ayah['text']}');
                      },
                    ),
                  ),
              ],
            );
          }
        }),
      ),
    );
  }
}