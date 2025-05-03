import 'package:flutter/material.dart';
import 'AccountManajement/optionLogin.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildUserProfile(),
      ),
    );
  }

  // Widget untuk menampilkan data user
  Widget _buildUserProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
        children: <Widget>[
          SizedBox(height: 20),
          // Avatar + Nama + Email
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage('https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              // Tombol Edit
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  // Tambahkan navigasi ke halaman edit profil jika ada
                },
              ),
            ],
          ),
          SizedBox(height: 30),

          // Card untuk Informasi Tambahan
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildProfileItem(
                      Icons.phone, '081234567890'),
                  Divider(),
                  _buildProfileItem(
                      Icons.location_on, 'Jalan Jalan, No. 1, Jakarta, Indonesia'),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),

          // Tombol Logout
          ClipPath(
            clipper: ParallelogramClipper(),
            child: GestureDetector(
              onTap: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NewLoginPage()),
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                //padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.red,
                  //borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget untuk item profil (misalnya: nomor telepon, alamat)
  Widget _buildProfileItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 45;
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

