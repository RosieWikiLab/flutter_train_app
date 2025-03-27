import 'package:flutter/material.dart';
import 'package:flutter_train_app/homepage.dart';


class StationListPage extends StatelessWidget {
  const StationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            Homepage();
          },
        ),
        title: const Text('출발역'),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: const [
          StationItem(name: '수서'),
          StationItem(name: '동탄'),
          StationItem(name: '평택지제'),
          StationItem(name: '천안아산'),
          StationItem(name: '오송'),
          StationItem(name: '대전'),
          StationItem(name: '김천구미'),
          StationItem(name: '동대구'),
          StationItem(name: '경주'),
          StationItem(name: '울산'),
          StationItem(name: '부산'),
        ],
      ),
    );
  }
}

class StationItem extends StatelessWidget {
  final String name;

  const StationItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}