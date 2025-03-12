import 'dart:math';
import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/modal/PCdetails.dart';

class HotelPackage extends StatelessWidget {
  final dataPC = DataPC.regularList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: ListView.separated(
        separatorBuilder: (_, index) => SizedBox(height: 10),
        itemCount: dataPC.length,
        itemBuilder: (context, index) {
          DataPC hotelscreen = dataPC[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(dataPC: hotelscreen),
                  ),
                );
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 8.0,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // Gambar Hotel
                    Positioned(
                      child: Hero(
                        tag: hotelscreen.imgurl,
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(dataPC[index].imgurl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Nama Hotel & Harga
                    Positioned(
                      top: 15,
                      right: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataPC[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rp. ${dataPC[index].price} / Hour',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tombol BOOK NOW berbentuk jajar genjang
                    Positioned(
                      bottom: 10,
                      left: 180,
                      child: ClipPath(
                        clipper: ParallelogramClipper(),
                        child: Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 58, 58, 58),
                          ),
                          child: Center(
                            child: Text(
                              'BOOK NOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Custom Clipper untuk bentuk jajar genjang
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
