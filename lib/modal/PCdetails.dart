import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/booking/booking.dart';
// Removed backend config import
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final DataPC dataPC;

  DetailsScreen({required this.dataPC});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // Using local asset images; no backend URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.dataPC.imgurl,
                      child: Image.asset(widget.dataPC.imgurl, fit: BoxFit.cover),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.dataPC.title,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(widget.dataPC.status).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(widget.dataPC.status),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    widget.dataPC.status,
                                    style: TextStyle(
                                      color: _getStatusColor(widget.dataPC.status),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(widget.dataPC.description),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Harga per Jam",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rp. ${NumberFormat('#,##0', 'id_ID').format(widget.dataPC.price)}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.dataPC.status != 'Maintenance'
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingPage(dataPC: widget.dataPC),
                              ),
                            );
                          }
                        : null,
                    child: ClipPath(
                      clipper: ParallelogramClipper(),
                      child: Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: widget.dataPC.status == 'Maintenance'
                              ? LinearGradient(colors: [Colors.grey, Colors.grey[600]!])
                              : LinearGradient(
                                  colors: [Colors.black, Colors.grey[900]!],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                          boxShadow: [
                            if (widget.dataPC.status != 'Maintenance')
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.calendar_today,
                              //   color: Colors.white,
                              //   size: 20,
                              // ),
                              SizedBox(width: 10),
                              Text(
                                "BOOK NOW",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Maintenance':
        return Colors.red;
      case 'Sedang Dipakai':
        return const Color.fromARGB(255, 255, 230, 0);
      case 'Tersedia':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 30;
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

