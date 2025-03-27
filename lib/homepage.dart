import 'package:flutter/material.dart';
import 'package:flutter_train_app/stationlistpage.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  void onSelected(int row, int col) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  Column(
                    children: [
                      Text('출발역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                      Text('선택', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),                    
                    ]
                  ),
                  Expanded(
                    child: VerticalDivider(
                      color: Colors.grey[400],
                      thickness: 2,
                      width: 50,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Text('도착역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                      Text('선택', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),                    
                    ]
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationListPage(),
                  ),
                );
              },
              child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                '좌석 선택',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}