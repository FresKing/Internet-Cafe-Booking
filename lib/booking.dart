import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  final DataPC dataPC;

  BookingPage({required this.dataPC});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<int> selectedHours = [];
  int currentHour = DateTime.now().hour;
  int totalHarga = 0;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  void _updateTotalHarga() {
    setState(() {
      totalHarga = selectedHours.length * widget.dataPC.price;
    });
  }

  void _toggleHour(int hour) {
    if (selectedHours.contains(hour)) {
      if (hour == selectedHours.first || hour == selectedHours.last) {
        selectedHours.remove(hour);
      } else {
        _showWarning(
            "Anda hanya bisa menghapus jam di bagian waktu awal atau akhir.");
      }
    } else {
      if (selectedHours.isEmpty ||
          hour == selectedHours.last + 1 ||
          hour == selectedHours.first - 1) {
        selectedHours.add(hour);
        selectedHours.sort();
      } else {
        _showWarning("Harus memilih jam secara berurutan.");
      }
    }
    _updateTotalHarga();
  }

  void _showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Peringatan"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildHourButton(int hour) {
    final now = DateTime.now();
    final bool isToday = _selectedDay.year == now.year &&
        _selectedDay.month == now.month &&
        _selectedDay.day == now.day;

    int minimumSelectableHour = now.minute > 0 ? currentHour + 1 : currentHour;
    bool isDisabled = isToday && hour < minimumSelectableHour;

    return GestureDetector(
      onTap: isDisabled ? null : () => _toggleHour(hour),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.withOpacity(0.3)
              : selectedHours.contains(hour)
                  ? Colors.red
                  : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "${hour}:00 - ${hour + 1}:00",
            style: TextStyle(
              color: isDisabled
                  ? Colors.black26
                  : selectedHours.contains(hour)
                      ? Colors.black
                      : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Time")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 30)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  selectedHours.clear();
                });
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              availableCalendarFormats: const {
                CalendarFormat.twoWeeks: '1 bulan',
                CalendarFormat.week: '2 Minggu',
                CalendarFormat.month: '1 Minggu',
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonTextStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Pilih Jam:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 2.5,
                ),
                itemCount: 24,
                itemBuilder: (context, index) {
                  return _buildHourButton(index);
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Waktu Dipilih: ${selectedHours.length} Jam",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total Harga: Rp. $totalHarga",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                clipper: ParallelogramClipper(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: Color.fromARGB(255, 58, 58, 58)),
                      
                  onPressed: selectedHours.isEmpty
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Konfirmasi Booking"),
                              content: Text(
                                  "Anda telah memilih ${selectedHours.length} jam."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                  child: Text(
                    "Konfirmasi Booking",
                    style: TextStyle(color: Colors.white),
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

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 20; // Kemiringan jajar genjang
    Path path = Path();
    path.moveTo(skewAmount, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - skewAmount, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
