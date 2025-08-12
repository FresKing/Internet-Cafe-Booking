import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'success.dart';
// Removed backend services
import 'package:intl/intl.dart';

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
  String? selectedPaymentMethod;

  void _confirmPayment(BuildContext parentContext) async {
    if (selectedPaymentMethod == null) {
      _showWarning("Pilih metode pembayaran terlebih dahulu.");
      return;
    }

    

    showDialog(
      context: parentContext,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text("Konfirmasi Pembayaran",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Anda akan membayar ",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextSpan(
                text: "Rp. ${NumberFormat('#,##0', 'id_ID').format(widget.totalHarga)}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              TextSpan(
                text: " melalui $selectedPaymentMethod.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () async {
              Navigator.pop(context);

              showDialog(
                context: parentContext,
                barrierDismissible: false,
                builder: (context) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              );

              // Backend removed: simulate success immediately
              await Future.delayed(Duration(milliseconds: 400));

              Navigator.pop(parentContext);

              if (mounted) {
                Navigator.pushReplacement(
                  parentContext,
                  MaterialPageRoute(builder: (context) => SuccessPage()),
                );
              }
            },
            child: Text("Bayar Sekarang", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title:
            Text("Peringatan", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message, style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.black)),
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
      appBar: AppBar(
        title: Text("Pembayaran"),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: Colors.black.withOpacity(0.1),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Detail Pemesanan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 15),
                      Divider(height: 1, color: Colors.grey[300]),
                      SizedBox(height: 15),
                      _buildDetailRow("PC:", widget.dataPC.title),
                      SizedBox(height: 12),
                      _buildDetailRow("Tanggal:", formattedDate),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        "Jam Booking:",
                        "${widget.selectedHours.first}:00 - ${widget.selectedHours.last + 1}:00",
                      ),
                      SizedBox(height: 15),
                      Divider(height: 1, color: Colors.grey[300]),
                      SizedBox(height: 15),
                      _buildDetailRow(
                        "Total Harga:",
                        "Rp. ${NumberFormat('#,##0', 'id_ID').format(widget.totalHarga)}",
                        bold: true,
                        color: Color(0xFF2E7D32),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Pilih Metode Pembayaran",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildPaymentOption(
                      "Transfer Bank",
                      Icons.account_balance,
                      Colors.blue,
                    ),
                    SizedBox(height: 12),
                    _buildPaymentOption(
                      "E-Wallet",
                      Icons.phone_iphone,
                      Colors.purple,
                    ),
                    SizedBox(height: 12),
                    _buildPaymentOption(
                      "QRIS",
                      Icons.qr_code,
                      Colors.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _confirmPayment(context),
                  child: ClipPath(
                    clipper: ParallelogramClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.grey[900]!],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Icon(Icons.payment, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Bayar Sekarang",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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

  Widget _buildDetailRow(String label, String value,
      {bool bold = false, Color color = Colors.black87}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String method, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedPaymentMethod == method
              ? color.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedPaymentMethod == method
                ? color
                : Colors.grey.withOpacity(0.3),
            width: selectedPaymentMethod == method ? 1.5 : 1,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              // decoration: BoxDecoration(
              //   color: color.withOpacity(0.2),
              //   shape: BoxShape.circle,
              // ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 15),
            Text(
              method,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            if (selectedPaymentMethod == method)
              Icon(Icons.check_circle, color: Colors.green, size: 24),
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

