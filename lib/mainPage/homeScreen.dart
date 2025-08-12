import 'package:flutter/material.dart';
import 'package:panthabash/mainPage/hotelPackage.dart';
import 'package:panthabash/modal/dataPC.dart';
import 'package:panthabash/modal/PCdetails.dart';
// Removed backend auth dependency
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _user;
  bool _isLoading = true;
  CancelableOperation? _operation;

  List<DataPC>? _vipList;
  List<DataPC>? _regularList;

  @override
  void initState() {
    super.initState();
    _operation = CancelableOperation.fromFuture(_fetchAllData());
  }

  Future<void> _fetchAllData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = null; // no backend user
      final vipList = DataPC.VIPlist();
      final regularList = DataPC.regularList();

      setState(() {
        _user = user;
        _vipList = vipList;
        _regularList = regularList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error preparing local data: $e');
    }
  }

  @override
  void dispose() {
    _operation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // No backend URL needed

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchAllData,
              child: ListView(
                children: [
                  _user != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello ${_user!['name']}!",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Welcome to Frex Game Station",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Text(
                            "Welcome to Frex Game Station",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              //color: Colors.red,
                            ),
                          ),
                        ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "VIP's",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 204,
                    child: _vipList == null || _vipList!.isEmpty
                        ? const Center(child: Text('Tidak ada data VIP'))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _vipList!.length,
                            itemBuilder: (context, index) {
                              final pc = _vipList![index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DetailsScreen(dataPC: pc)));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 10.0),
                                  height: 200,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0.0, 4.0),
                                          blurRadius: 10.0)
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: pc.imgurl,
                                        child: Container(
                                          height: 140,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(pc.imgurl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          pc.title,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7, top: 5, right: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rp. ${NumberFormat('#,##0', 'id_ID').format(pc.price)} / hour',
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "Regular PC's",
                          style:
                              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _regularList == null || _regularList!.isEmpty
                      ? const Center(child: Text('Tidak ada data Reguler'))
                      : HotelPackage(dataPCList: _regularList!),
                ],
              ),
            ),
    );
  }
}




