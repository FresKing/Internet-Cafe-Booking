class Booking {
  final String namaPC;
  final String tanggal;
  final String jamMulai;
  final String jamSelesai;
  final int totalHarga;

  Booking({
    required this.namaPC,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.totalHarga,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    String namaPC = '';
    if (json['pc'] != null) {
      if (json['pc'] is Map<String, dynamic> && json['pc']['name'] != null) {
        namaPC = json['pc']['name'] as String;
      } else if (json['pc'] is String) {
        namaPC = json['pc'];
      }
    }
    return Booking(
      namaPC: namaPC,
      tanggal: json['tanggal'] != null ? json['tanggal'] as String : '',
      jamMulai: json['jam_mulai'] != null ? json['jam_mulai'] as String : '',
      jamSelesai: json['jam_selesai'] != null ? json['jam_selesai'] as String : '',
      totalHarga: json['total_harga'] != null ? json['total_harga'] as int : 0,
    );
  }
}
