import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final Set<int> selectedSeats = {};

  void toggleSeat(int seatNumber) {
    setState(() {
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    });
  }

  void showBookingDialog() {
    if (selectedSeats.isEmpty) return;

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('예매 확인'),
        content: Text('선택하신 ${selectedSeats.length}개의 좌석을 예매하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pop(context); 
              Navigator.pop(context); 
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('좌석 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('수서', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.purple)), 
                  const Icon(Icons.arrow_circle_right_outlined, size: 30, color: Colors.grey),
                  Text('부산', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.purple)),               
                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 4),
                Text('선택됨', style: TextStyle(fontSize: 20)),
                SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 4),
                Text('선택안됨', style: TextStyle(fontSize: 20)),
              ]
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  final seatNumber = index + 1;
                  final isSelected = selectedSeats.contains(seatNumber);
                  
                  return GestureDetector(
                    onTap: () => toggleSeat(seatNumber),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          seatNumber.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: showBookingDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  '예매하기',
                  style: TextStyle(
                    fontSize: 20,
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
