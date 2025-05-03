import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/modal/PCdetails.dart';
import 'package:intl/intl.dart';

class HotelPackage extends StatelessWidget {
  final dataPC = DataPC.regularList();
  final List<DataPC> dataPCList;

  HotelPackage({Key? key, required this.dataPCList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (dataPCList.isEmpty) {
      return const Center(child: Text('Tidak ada data Reguler'));
    }

    return Container(
      width: double.infinity,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(), // because inside parent scroll
        shrinkWrap: true, // important to adjust height to content
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemCount: dataPCList.length,
        itemBuilder: (context, index) {
          final pc = dataPCList[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(dataPC: pc),
                  ),
                );
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 8.0,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // Image
                    Positioned(
                      child: Hero(
                        tag: pc.imgurl,
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
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

                    // Title & Price
                    Positioned(
                      top: 15,
                      right: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pc.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rp. ${NumberFormat('#,##0', 'id_ID').format(pc.price)} / Hour',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // BOOK NOW button
                    Positioned(
                      bottom: 10,
                      left: 180,
                      child: ClipPath(
                        clipper: ParallelogramClipper(),
                        child: Container(
                          height: 35,
                          width: 150,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 58, 58, 58),
                          ),
                          child: const Center(
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

// Custom Clipper for parallelogram shape
class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 20; // skew amount
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
