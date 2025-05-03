import 'package:flutter/material.dart';
import 'package:panthabash/hotelPackage.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/modal/PCdetails.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello nama USER!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(height: 5),
                    Text(
                      "Welcome to Frex Game Station",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "VIP's",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 204,
            child: DataPC.VIPlist().isEmpty
                ? const Center(child: Text('Tidak ada data VIP'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: DataPC.VIPlist().length,
                    itemBuilder: (context, index) {
                      final pc = DataPC.VIPlist()[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailsScreen(dataPC: pc)));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 200,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 10.0)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: pc.imgurl,
                                child: Container(
                                  height: 140,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(pc.imgurl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  pc.title,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 7, top: 5, right: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rp. ${NumberFormat('#,##0', 'id_ID').format(pc.price)} / hour',
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "Regular PC's",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          DataPC.regularList().isEmpty
              ? const Center(child: Text('Tidak ada data Reguler'))
              : HotelPackage(dataPCList: DataPC.regularList()),
        ],
      ),
    );
  }
}

