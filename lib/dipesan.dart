import 'package:flutter/material.dart';
import 'package:panthabash/modal/dataPC.dart';

class DipesanPage extends StatefulWidget {
  const DipesanPage({Key? key}) : super(key: key);

  @override
  _DipesanPageState createState() => _DipesanPageState();
}

class _DipesanPageState extends State<DipesanPage> {
  late Future<List<DataPC>> _futureDataPC;

  @override
  void initState() {
    super.initState();
    _futureDataPC = fetchDipesanList();
  }

  // Fungsi untuk mendapatkan data secara Future
  Future<List<DataPC>> fetchDipesanList() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulasi delay kecil
    return DataPC.dipesanList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking'), automaticallyImplyLeading: false,),
      body: FutureBuilder<List<DataPC>>(
        future: _futureDataPC,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data booking"));
          }

          final dataPC = snapshot.data!;
          return ListView.builder(
            itemCount: dataPC.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('${index+1}'),
                // leading: Image.network(dataPC[index].imgurl),
                title: Text(dataPC[index].title),
                trailing: Text('Rp ${dataPC[index].price}', textAlign: TextAlign.right),
              );
            },
          );
        },
      ),
    );
  }
}

