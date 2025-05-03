import 'package:flutter/material.dart';
import 'newPW.dart';

class VerificationCodePage extends StatelessWidget {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  VerificationCodePage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
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
                // Header Section
                Stack(
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bgLogin.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            size: 30, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 80,
                      right: 80,
                      child: Text(
                        "Verification Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'franklin gothic',
                        ),
                      ),
                    ),
                  ],
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(
                        'Enter the 6-digit verification code sent to your email:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      
                      // 6-Digit Input Boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 40,
                            child: TextField(
                              controller: controllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 30),
                      
                      // Verify Button
                      ClipPath(
                        clipper: _ParallelogramClipper(),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPasswordPage(),
                              ),
                            );
                            // Handle verification logic here
                            String code = controllers.map((c) => c.text).join();
                            print("Verification code: $code");
                          },
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParallelogramClipper extends CustomClipper<Path> {
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