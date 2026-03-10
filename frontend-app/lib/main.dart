import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TigerairApp());
}

class TigerairApp extends StatelessWidget {
  const TigerairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tigerair App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF6B000)),
        useMaterial3: true,
      ),
      home: const FlightListScreen(),
    );
  }
}

class FlightListScreen extends StatefulWidget {
  const FlightListScreen({super.key});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  List flights = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
    try {
      // 10.0.2.2 是 Android 模擬器連向本機的位址。如果是 iOS 模擬器請改為 localhost 或 127.0.0.1
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/flights'));
      if (response.statusCode == 200) {
        setState(() {
          flights = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      // 為了展示目的，如果後端沒開，採用假資料
      setState(() {
        flights = [
          {"id": 1, "flight_number": "IT201", "origin": "TPE", "destination": "NRT", "price": 4500, "status": "On Time"},
          {"id": 2, "flight_number": "IT212", "origin": "TPE", "destination": "KIX", "price": 3800, "status": "Delayed"}
        ];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6B000),
        title: const Text('🐯 Tigerair 航班預訂', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(flight['flight_number'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: flight['status'] == 'On Time' ? Colors.green.shade100 : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(flight['status'], style: TextStyle(
                                color: flight['status'] == 'On Time' ? Colors.green.shade800 : Colors.red.shade800,
                                fontWeight: FontWeight.bold
                              )),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(flight['origin'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.flight_takeoff, size: 30, color: Colors.black54),
                            ),
                            Text(flight['destination'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('NT\$ ${flight['price']}', style: const TextStyle(fontSize: 22, color: Colors.redAccent, fontWeight: FontWeight.w900)),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('啟動預訂流程: ${flight['flight_number']}')),
                                );
                              },
                              child: const Text('立即訂票', style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
