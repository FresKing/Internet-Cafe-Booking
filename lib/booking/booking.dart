import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import '../AccountManajement/login.dart'; // Import halaman login
import 'payment.dart'; // Import halaman pembayaran
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

  void _checkUserAndProceed() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Jika user belum login, tampilkan pop-up peringatan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Diperlukan"),
          content: Text("Silakan login terlebih dahulu untuk melanjutkan."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup pop-up
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()), // Arahkan ke halaman login
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      // Jika user sudah login, lanjut ke halaman pembayaran
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            dataPC: widget.dataPC,
            selectedDay: _selectedDay,
            selectedHours: selectedHours,
            totalHarga: totalHarga,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      // appBar: AppBar(title: Text("Booking Time")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        size: 30, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text("Booking Time",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ],
              ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TableCalendar(
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
            ),
            SizedBox(height: 20),
            // Text("Pilih Jam:", style: TextStyle(fontSize: 18)),
            // SizedBox(height: 10),
            Wrap(
              spacing: 16,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color.fromARGB(255, 140, 255, 144),
                ),
                Text("Tersedia", style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.yellow,
                ),
                Text("Dipilih", style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                ),
                Text("Terbooking", style: TextStyle(fontSize: 16)),
              ],
            ),
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
            SizedBox(height: 15),
            ClipPath(
              clipper: ParallelogramClipper(),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedHours.isEmpty ? Colors.grey.withOpacity(0.3) : Colors.black,
                  
                ),
                child: TextButton(
                  onPressed:
                      selectedHours.isEmpty ? null : _checkUserAndProceed,
                  child: Text(
                    "Konfirmasi Booking",
                    style: TextStyle(
                      color: selectedHours.isEmpty ? Colors.black26 : Colors.white,
                      
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                  ? Colors.yellow
                  : const Color.fromARGB(255, 140, 255, 144),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "${hour}:00 - ${hour + 1}:00",
            style: TextStyle(
              color: isDisabled ? Colors.black26 : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 45; // Kemiringan jajar genjang
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

