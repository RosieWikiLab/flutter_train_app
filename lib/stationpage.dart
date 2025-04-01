import 'package:flutter/material.dart';

class StationPage extends StatelessWidget {
  final String? selectedStation; // 이미 선택된 역 정보

  const StationPage({
    super.key,
    this.selectedStation, // 선택된 역을 생성자로 받음
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // 모든 역 목록
    final List<String> allStations = [
      '수서', '동탄', '부산', '대구', '광주', '서울', '부전', '마산', '진주', '포항'
    ];

    // 선택된 역을 제외한 역 목록 생성
    final List<String> availableStations = allStations
        .where((station) => station != selectedStation)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(selectedStation == null ? '출발역 선택' : '도착역 선택'),
        backgroundColor: isDark ? Colors.purple[900] : Colors.purple,
      ),
      body: ListView.builder(
        itemCount: availableStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              availableStations[index],
              style: TextStyle(
                fontSize: 20,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pop(context, availableStations[index]);
            },
          );
        },
      ),
    );
  }
} 