import 'package:flutter/material.dart';
import 'verificationCode.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPage createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  bool _emailError = false;

  void _sendPasswordResetLink() {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Email Terkirim"),
        content: Text("Silakan cek email kamu untuk mereset password."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationCodePage(email: email)),
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

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
                  // Header dengan background diagonal
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 100,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 36,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'franklin gothic',
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Please Enter Your Email Address To Receive a Verification Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Form Login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color:
                                      _emailError ? Colors.red : Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Tombol forgot password
                  ClipPath(
                    clipper: ParallelogramClipper(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 140, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      onPressed: _sendPasswordResetLink,
                      child: Text(
                        'Send Code',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
