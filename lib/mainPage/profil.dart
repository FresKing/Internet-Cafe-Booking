import 'package:flutter/material.dart';
import '../AccountManajement/auth_service.dart';
import '../AccountManajement/login.dart';
import '../AccountManajement/createAccount.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? userData; // Data user dari API
  bool isLoading = true; // Untuk menampilkan loading state

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

 Future<void> _getUserData() async {
  //final data = await _authService.getCurrentUser();
  final data = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '1234567890',
    'address': '123 Main St, Anytown, USA',
  };
  
  if (mounted) {
    setState(() {
      userData = data;
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // Tampilkan loading jika masih memuat data
            : userData != null
                ? _buildUserProfile() // Tampilkan profil jika login
                : _buildLoginButton(), // Tampilkan tombol login jika belum login
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
                backgroundImage: AssetImage('assets/images/face.jpg'),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userData?['name'] ?? 'No Name',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      userData?['email'] ?? 'No Email',
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
                      Icons.phone, userData?['phone'] ?? 'No Phone'),
                  Divider(),
                  _buildProfileItem(
                      Icons.location_on, userData?['address'] ?? 'No Address'),
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
                //await _authService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
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

  // Widget untuk menampilkan tombol login jika belum login
  Widget _buildLoginButton() {
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Container untuk Judul
            Container(
              padding: const EdgeInsets.only(top: 150),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Text(
                    'Frex Game Station',
                    style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Franklin Gothic',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
                height: 170), // Memberikan ruang di antara judul dan tombol

            // Container untuk Tombol
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipPath(
                      clipper: ParallelogramClipper(),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 100),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'cabin',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'montserrat',
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipPath(
                      clipper: ParallelogramClipper(),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccountPage()),
                          );
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'cabin',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(), // Memberikan ruang antara tombol dan bagian bawah layar
          ],
        ),
      ),
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
