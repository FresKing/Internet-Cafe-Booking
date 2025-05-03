import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:intl/intl.dart';
import 'homePage.dart';

class DipesanPage extends StatefulWidget {
  const DipesanPage({Key? key}) : super(key: key);

  @override
  DipesanPageState createState() => DipesanPageState();
}

class DipesanPageState extends State<DipesanPage> {
  List<DataBooking> _bookings = DataBooking.dipesanList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF232526),
              Color(0xFF414345),
              Color(0xFF17191A),
            ],
            stops: [0.25, 0.60, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER FULL WIDTH
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgLogin.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Text(
                    "My Bookings",
                    style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'franklin gothic',
                    ),
                  ),
                ),
              ],
            ),

            // ISI BOOKING
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _bookings.isNotEmpty
                    ? ListView.builder(
                        itemCount: _bookings.length,
                        itemBuilder: (context, index) {
                          final booking = _bookings[index];
                          return bookingCard(booking);
                        },
                      )
                    : noBookingsPlaceholder(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingCard(DataBooking booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: ClipPath(
        clipper: ParallelogramClipper(),
        child: Container(
          color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title (geser ke kiri 24)
                      Transform.translate(
                        offset: const Offset(24, 0),
                        child: Row(
                          children: [
                            Icon(Icons.computer,
                                color: Colors.blue.shade700, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              booking.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Harga (geser ke kiri 10)
                      Transform.translate(
                        offset: const Offset(10, 0),
                        child: Text(
                          "Rp ${NumberFormat('#,##0', 'id_ID').format(booking.totalHarga)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // RIGHT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Tanggal (geser ke kanan 10)
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Row(
                          children: [
                            Text(
                              booking.tanggal,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade800),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Jam (geser ke kanan 24)
                      Transform.translate(
                        offset: const Offset(-24, 0),
                        child: Row(
                          children: [
                            Text(
                              "${booking.jamMulai} - ${booking.jamSelesai}",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade800),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
        ),
      ),
    );
  }

  Widget noBookingsPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today,
              size: 50, color: Color.fromARGB(255, 255, 255, 255)),
          const SizedBox(height: 16),
          const Text("No bookings yet",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Your bookings will appear here",
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 153, 153, 153))),
          const SizedBox(height: 16),
          ClipPath(
            clipper: ParallelogramClipper(),
            child: Container(
              width: 175,
              height: 40,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text(
                  "BOOK NOW",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 35;
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
