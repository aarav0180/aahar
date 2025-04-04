import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge/screens/Donations/assign_agent.dart';
import '../../utils/app_colors.dart';
import '../../utils/functions/map_distance.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;
  final String itemName;
  final String imageUrl;
  final String quantity;
  final double orderLatitude;
  final double orderLongitude;
  final double ngoLongitude;
  final double ngoLatitude;
  final String status;

  const OrderDetailsPage({
    super.key,
    required this.orderId,
    required this.itemName,
    required this.imageUrl,
    required this.quantity,
    required this.status,
    required this.orderLatitude, required this.orderLongitude, required this.ngoLongitude, required this.ngoLatitude,
  });

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool _isLoading = false;

  // Future<void> updateOrderStatus(String newStatus) async {
  //   setState(() => _isLoading = true);
  //
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('Orders')
  //         .doc(widget.orderId)
  //         .update({'status': newStatus});
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Order marked as $newStatus"))
  //     );
  //
  //     Navigator.pop(context); // Go back after updating
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error updating order: $e"))
  //     );
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ Order Image
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🖼️ Order Image with Rounded Corners
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.imageUrl,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 📌 Item Name (Highlighted with a card)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          widget.itemName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 📦 Order Details (Using a more structured layout)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.shopping_cart, color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              Text(
                                "Quantity: ",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${widget.quantity}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.info_outline, color: Colors.orangeAccent),
                              const SizedBox(width: 8),
                              Text(
                                "Status: ",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.status,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.status == "Accepted" ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 🗺️ Map Section
              SizedBox(
                height: 350, // Adjust as needed
                child: buildMapWithRoute(
                  orderLatitude: widget.orderLatitude,
                  orderLongitude: widget.orderLongitude,
                  ngoLatitude: widget.ngoLatitude,
                  ngoLongitude: widget.ngoLongitude,
                ),
              ),
              const SizedBox(height: 36),

              // ✅ Accept & ❌ Reject Buttons (Improved UI)
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if(widget.status == "pending") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => AssignAgentPage(orderId: widget.orderId, itemName: widget.itemName, quantity: widget.quantity, status: widget.status, imageUrl: widget.imageUrl)));
                        }

                      },//=> //updateOrderStatus("Accepted"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.status == "pending" ? Colors.green : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Accept",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Reject",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
