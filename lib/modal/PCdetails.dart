import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/booking/booking.dart';

class DetailsScreen extends StatefulWidget {
  final DataPC dataPC;

  DetailsScreen({required this.dataPC});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.8,
                          width: 500,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Hero(
                            tag: widget.dataPC.imgurl,
                            child: Image(
                              image: AssetImage(widget.dataPC.imgurl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 30,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        widget.dataPC.title,
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.dataPC.description),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bottom section with price, status, and button
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -2),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price and Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Rp. ${widget.dataPC.price}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    // Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: widget.dataPC.status == 'Maintenance'
                                    ? Colors.red
                                    : widget.dataPC.status == 'Sedang Dipakai'
                                        ? const Color.fromARGB(255, 255, 230, 0)
                                        : Colors.green,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.dataPC.status == 'Maintenance'
                                  ? 'Maintenance'
                                  : widget.dataPC.status == 'Sedang Dipakai'
                                      ? 'Sedang Dipakai'
                                      : 'Tersedia',
                              style: TextStyle(
                                color: widget.dataPC.status == 'Maintenance'
                                    ? Colors.red
                                    : widget.dataPC.status == 'Sedang Dipakai'
                                        ?  const Color.fromARGB(255, 255, 230, 0)
                                        : Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Book Now Button
                ClipPath(
                  clipper: ParallelogramClipper(),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.dataPC.status != 'Maintenance') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(dataPC: widget.dataPC),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: widget.dataPC.status == 'Maintenance'
                            ? Colors.grey
                            : const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: Center(
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 15),
        ],
      ),
    );
  }
}

// Custom Clipper untuk membuat bentuk jajar genjang
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

