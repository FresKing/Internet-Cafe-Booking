import 'package:flutter/material.dart';
import 'login.dart';
import 'createAccount.dart';

class NewLoginPage extends StatelessWidget {
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
            SizedBox(height: 170), // Memberikan ruang di antara judul dan tombol
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