import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import '../AccountManajement/login.dart'; // Import halaman login
import 'payment.dart'; // Import halaman pembayaran
import 'package:table_calendar/table_calendar.dart';
//import '../modal/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'package:shared_preferences/shared_preferences.dart';

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
  List<int> blockedHours = [];
  bool _isLoadingHours = false;
  int currentHour = DateTime.now().hour;
  int totalHarga = 0;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now(); // set default ke hari ini
    _loadBlockedHours(_selectedDay); // load static blocked hours
  }

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

  bool _isLoading = false;

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(
          "Login Diperlukan",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        content: Text("Silakan login terlebih dahulu untuk melanjutkan."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup pop-up
            },
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup pop-up
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _loadBlockedHours(DateTime date) async {
    // Provide static blocked hours for demo
    setState(() {
      _isLoadingHours = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      blockedHours = [10, 11, 12]; // example blocked hours
      _isLoadingHours = false;
    });
  }

  Future<void> _checkUserAndProceed() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    // Simulate user logged in always
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      // appBar: AppBar(title: Text("Booking Time")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
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
                      _loadBlockedHours(selectedDay);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              const Color.fromARGB(255, 140, 255, 144),
                        ),
                        SizedBox(width: 8),
                        Text("Tersedia", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.yellow,
                        ),
                        SizedBox(width: 8),
                        Text("Dipilih", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text("Terbooking", style: TextStyle(fontSize: 16)),
                      ],
                    ),
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
                  children: [
                    Text(
                      "Total Waktu Dipilih:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "${selectedHours.length} Jam",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Total Harga:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "Rp. $totalHarga",
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
                      color: selectedHours.isEmpty
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.black,
                    ),
                    child: TextButton(
                      onPressed:
                          selectedHours.isEmpty ? null : _checkUserAndProceed,
                      child: Text(
                        "Konfirmasi Booking",
                        style: TextStyle(
                          color: selectedHours.isEmpty
                              ? Colors.black26
                              : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
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

    // Calculate minimum selectable hour based on current time
    int minimumSelectableHour = now.minute > 0 ? currentHour + 1 : currentHour;

    // Determine if the hour should be disabled (greyed out)
    bool isDisabled = false;
    if (isToday) {
      if (hour < minimumSelectableHour) {
        isDisabled = true;
      }
    }

    // Determine if the hour is blocked (red)
    bool isBlocked = blockedHours.contains(hour);

    if (_isLoadingHours) {
      // Show loading indicator while fetching blocked hours
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.withOpacity(0.3)
              : const Color.fromARGB(255, 140, 255, 144),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    // Determine the background color based on state
    Color backgroundColor;
    if (isDisabled) {
      backgroundColor = Colors.grey.withOpacity(0.3);
    } else if (isBlocked) {
      backgroundColor = Colors.red;
    } else if (selectedHours.contains(hour)) {
      backgroundColor = Colors.yellow;
    } else {
      backgroundColor = const Color.fromARGB(255, 140, 255, 144);
    }

    // Determine the text color based on state
    Color textColor = (isBlocked || isDisabled) ? Colors.black26 : Colors.black;

    return GestureDetector(
      onTap: (isDisabled || isBlocked) ? null : () => _toggleHour(hour),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "${hour}:00 - ${hour + 1}:00",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
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

