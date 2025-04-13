import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'success.dart'; // Halaman sukses setelah pembayaran

class PaymentPage extends StatefulWidget {
  final DataPC dataPC;
  final DateTime selectedDay;
  final List<int> selectedHours;
  final int totalHarga;

  PaymentPage({
    required this.dataPC,
    required this.selectedDay,
    required this.selectedHours,
    required this.totalHarga,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod; // Menyimpan metode pembayaran yang dipilih

  void _confirmPayment() {
    if (selectedPaymentMethod == null) {
      _showWarning("Pilih metode pembayaran terlebih dahulu.");
      return;
    }

    // Menampilkan popup konfirmasi pembayaran
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Pembayaran"),
        content: Text(
            "Anda akan membayar Rp. ${widget.totalHarga} melalui $selectedPaymentMethod."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Tutup pop-up
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SuccessPage()), // Arahkan ke halaman sukses
              );
            },
            child: Text("Bayar Sekarang"),
          ),
        ],
      ),
    );
  }

  void _showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Peringatan"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${widget.selectedDay.day}-${widget.selectedDay.month}-${widget.selectedDay.year}";

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Container(
        
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        size: 30, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text("Pembayaran",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Detail Pemesanan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                  // backgroundBlendMode: BlendMode.softLight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("PC:", style: TextStyle(fontSize: 16, color: Colors.black)),
                          Text(widget.dataPC.title, style: TextStyle(fontSize: 16, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tanggal:", style: TextStyle(fontSize: 16, color: Colors.black)),
                          Text(formattedDate, style: TextStyle(fontSize: 16, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jam Booking:", style: TextStyle(fontSize: 16, color: Colors.black)),
                          Text("${widget.selectedHours.first}:00 - ${widget.selectedHours.last + 1}:00", style: TextStyle(fontSize: 16, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Harga:", style: TextStyle(fontSize: 16, color: Colors.black)),
                          Text("Rp. ${widget.totalHarga}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Pilih Metode Pembayaran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  _buildPaymentOption("Transfer Bank"),
                  _buildPaymentOption("E-Wallet"),
                  _buildPaymentOption("QRIS"),
                ],
              ),
              Spacer(),
              ClipPath(
                clipper: ParallelogramClipper(),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _confirmPayment,
                      child: Center(
                        child: Text(
                          "Bayar Sekarang",
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
  }

  Widget _buildPaymentOption(String method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: selectedPaymentMethod == method
            ? Colors.blue.shade100
            : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                method == "Transfer Bank"
                    ? Icons.account_balance
                    : method == "E-Wallet"
                        ? Icons.phone_android
                        : Icons.qr_code,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                method,
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              if (selectedPaymentMethod == method)
                Icon(Icons.check_circle, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double skewAmount = 45; // Kemiringan jajar genjang
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
