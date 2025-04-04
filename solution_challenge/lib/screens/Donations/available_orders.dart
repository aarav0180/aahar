import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'donation_detail.dart';

class DonationsPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const DonationsPage({super.key, required this.longitude, required this.latitude});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('donations').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Orders"),
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching orders"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders available"));
          }

          List<Map<String, dynamic>> orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> order = orders[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(
                        orderId: order['id'] ?? '0',
                        itemName: order['name'] ?? '0',
                        imageUrl: order['foodImage'] ?? '0',
                        quantity: order['quantity'] ?? '0',
                        status: order['status'] ?? 'pending',
                        orderLatitude: order['latitude'] ?? 0,
                        orderLongitude: order['longitude'] ?? 0,
                        ngoLatitude: latitude,
                        ngoLongitude: longitude,// Ensure this is passed correctly
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      order['itemName'] ?? "Unknown Item",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity: ${order['quantity'] ?? 'N/A'}"),
                        Text("Status: ${order['status'] ?? 'Pending'}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
