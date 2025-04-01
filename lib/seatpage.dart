import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> with SingleTickerProviderStateMixin {
  final Set<int> selectedSeats = {};
  late AnimationController _controller;
  static const int maxSeats = 4; // 최대 선택 가능 좌석 수

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleSeat(int seatNumber) {
    setState(() {
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
        _controller.reverse();
      } else {
        if (selectedSeats.length < maxSeats) {
          selectedSeats.add(seatNumber);
          _controller.forward();
        } else {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('좌석 선택 제한'),
              content: Text('최대 ${maxSeats}개의 좌석만 선택할 수 있습니다.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('확인'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('좌석 선택'),
        backgroundColor: isDark ? Colors.purple[900] : Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('수서', 
                    style: TextStyle(
                      fontSize: 40, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.purple
                    )
                  ), 
                  Icon(Icons.arrow_circle_right_outlined, 
                    size: 30, 
                    color: isDark ? Colors.white70 : Colors.grey
                  ),
                  Text('부산', 
                    style: TextStyle(
                      fontSize: 40, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.purple
                    )
                  ),               
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
                Text('선택됨', 
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                  )
                ),
                SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[700] : Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 4),
                Text('선택안됨', 
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                  )
                ),
              ]
            ),
            if (selectedSeats.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.purple[900] : Colors.purple[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, 
                      color: isDark ? Colors.white70 : Colors.purple[900],
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '선택된 좌석: ${selectedSeats.join(', ')}',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.purple[900],
                      ),
                    ),
                  ],
                ),
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
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 1.0, end: 1.1).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.purple : (isDark ? Colors.grey[700] : Colors.grey[300]),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ] : null,
                        ),
                        child: Center(
                          child: Text(
                            seatNumber.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : textColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
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
              child: Column(
                children: [
                  Text(
                    '선택된 좌석: ${selectedSeats.length} / $maxSeats',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
