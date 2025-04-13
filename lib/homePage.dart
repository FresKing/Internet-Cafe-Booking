import 'package:flutter/material.dart';
import 'package:panthabash/hotelPackage.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/modal/PCdetails.dart';
import 'dipesan.dart';
import 'profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  User? user = FirebaseAuth.instance.currentUser; // Dapatkan user saat ini
  Map<String, dynamic>? userData;
  final List<Widget> _pages = [
    HomeScreen(),  // Home
    DipesanPage(),  // Booking
    ProfilPage(),  // Profil
  ];

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    if (user != null) {
      // Ambil data dari Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() as Map<String, dynamic>;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: _pages[_selectedIndex], // Menampilkan halaman yang sesuai
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.black, // Warna background navbar menjadi hitam
      selectedItemColor: Colors.white, // Warna teks & icon saat dipilih
      unselectedItemColor: const Color.fromARGB(255, 133, 132, 132), // Warna teks & icon saat tidak dipilih
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    ),
  );
}

}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userData = (user != null) ? FirebaseFirestore.instance.collection("users").doc(user.uid).get() : null;

    return Scaffold(
      body: ListView(
        children: [
          userData != null
              ? FutureBuilder<DocumentSnapshot>(
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData && snapshot.data!.exists) {
                      final data = snapshot.data!.data() as Map<String, dynamic>;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hello ${data['name']}!",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                SizedBox(
                                  height: 5,
                                ),
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
                      );
                    }
                    return SizedBox.shrink();
                  },
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("VIP's",
              style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 19.0
              ),),
          ),
          SizedBox(height: 20,),
          Container(
            height: 204,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: DataPC.VIPlist().length,
              itemBuilder: (context, index) {
                DataPC hotelscreen = DataPC.VIPlist()[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DetailsScreen(
                          dataPC: hotelscreen,),));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    height: 200,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0
                        )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag:hotelscreen.imgurl ,
                          child: Container(
                            height: 140,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)
                                ),
                                image: DecorationImage(
                                    image: AssetImage(hotelscreen.imgurl),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(hotelscreen.title,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 7, top: 5, right: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rp. ${hotelscreen.price} / hour',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text("Regular PC's",
                style: TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
          SizedBox(height: 20,),
          HotelPackage(),
        ],
      ),
    );
  }
}


