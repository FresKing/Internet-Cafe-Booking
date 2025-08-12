import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'homePage.dart';

class DipesanPage extends StatefulWidget {
  const DipesanPage({Key? key}) : super(key: key);

  @override
  DipesanPageState createState() => DipesanPageState();
}

class DipesanPageState extends State<DipesanPage> {
  Future<List<DataBooking>>? _bookingFuture;

  Future<List<DataBooking>> _loadUserBookings() async {
    // backend removed; use static sample
    await Future.delayed(Duration(milliseconds: 200));
    return DataBooking.dipesanList();
  }

  @override
  void initState() {
    super.initState();
    _bookingFuture = _loadUserBookings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _bookingFuture = _loadUserBookings();
    });
  }

  void refreshBookingData() {
    _refreshData();
  }

  void clearBookingData() {
    setState(() {
      _bookingFuture = Future.value([]);
    });
  }

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
          children: [
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
            Expanded(
              
               child: FutureBuilder<List<DataBooking>>(
                future: _bookingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingWidget();
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildEmptyBookingsWidget();
                  }
                  return _buildBookingsList(snapshot.data!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 5,
          ),
          SizedBox(height: 16),
          Text('Loading your bookings...',
              style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 50, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text("Failed to load data",
              style: TextStyle(fontSize: 18, color: Colors.red.shade700)),
          const SizedBox(height: 8),
          Text("Please try again later",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _refreshData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Retry", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBookingsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today,
              size: 50, color: const Color.fromARGB(255, 255, 255, 255)),
          const SizedBox(height: 16),
          const Text("No bookings yet",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Your bookings will appear here",
              style: TextStyle(
                  fontSize: 14, color: const Color.fromARGB(255, 153, 153, 153))),
          const SizedBox(height: 16),
          ClipPath(
            clipper: ParallelogramClipper(),
            child: Container(
              width: 175,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Text(
                  "BOOK NOW",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: const Color.fromARGB(255, 0, 0, 0),
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

  Widget _buildBookingsList(List<DataBooking> bookings) {
  return RefreshIndicator(
    color: Colors.blue.shade700,
    backgroundColor: Colors.white,
    onRefresh: _refreshData,
    child: ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 12), // Added top padding
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        // Add extra margin only for the first item
        return Container(
          margin: EdgeInsets.only(bottom: 25, top: index == 0 ? 10 : 0), // Added top margin for first item
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
                        Transform.translate(
                          offset: const Offset(30, 0),
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
                        Transform.translate(
                          offset: const Offset(15, 0),
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
                        Transform.translate(
                          offset: const Offset(-15, 0),
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
                        Transform.translate(
                          offset: const Offset(-30, 0),
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
      },
    ),
  );
}
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 35; // Kemiringan jajar genjang
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