import 'package:flutter/material.dart';
import '../homePage.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _name, _email, _password, _confirmPassword;
  bool _obscureText = true;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password dan Confirm Password harus sama")),
        );
        return;
      }

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Simpan nama ke Firebase Authentication
        await userCredential.user!.updateDisplayName(_name);
        await userCredential.user!.reload();

        // Simpan data pengguna ke Firestore
        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          "name": _name,
          "email": _email,
          "createdAt": FieldValue.serverTimestamp(),
        });

        // Tampilkan loading dan navigasi ke HomePage
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );

        await Future.delayed(Duration(seconds: 2)); // Simulasi loading
        Navigator.of(context).pop(); // Tutup dialog loading

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.toString()}")),
          );
        }
      }
    }
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
            child: Form(
              key: _formKey,
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 90,
                        left: 100,
                        child: Text(
                          "Create Account",
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

                  // Form Login

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onChanged: (value) => _name = value,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Full Name is required';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) => _email = value,
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
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            if (!value.contains('@')) {
                              return 'Email is not valid';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value!,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) => _password = value,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? Icon(Icons.remove_red_eye,
                                        color: Colors.grey)
                                    : Icon(Icons.visibility_off,
                                        color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value!,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) => _confirmPassword = value,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm Password is required';
                            }
                            if (value != _password) {
                              return 'Password and Confirm Password must match';
                            }
                            return null;
                          },
                          onSaved: (value) => _confirmPassword = value!,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  // Tombol Login
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
                      onPressed: () {
                        _signUp();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(height: 10),
                  // Forgot Password
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(width: 70),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
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
      ),
    );
  }
}

// Custom Clipper untuk bentuk jajar genjang
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

