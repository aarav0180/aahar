import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge/utils/app_colors.dart';
import 'package:solution_challenge/widgets/snack_bar.dart';

class AssignAgentPage extends StatefulWidget {
  final String orderId;
  final String itemName;
  final String quantity;
  final String status;
  final String imageUrl;

  const AssignAgentPage({
    super.key,
    required this.orderId,
    required this.itemName,
    required this.quantity,
    required this.status,
    required this.imageUrl,
  });

  @override
  _AssignAgentPageState createState() => _AssignAgentPageState();
}

class _AssignAgentPageState extends State<AssignAgentPage> {
  String? selectedAgent;

  final List<String> agents = [
    "Amit Sharma",
    "Priya Verma",
    "Rahul Mehta",
    "Neha Kapoor",
    "Vikram Singh",
    "Anjali Nair",
    "Suresh Rao",
    "Divya Patel"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Agent"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Order Details at the Top
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.itemName,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text("Quantity: ${widget.quantity}", style: const TextStyle(fontSize: 16)),
                    Text("Status: ${widget.status}", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Agent Selection List
            const Text(
              "Select an Agent",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: agents.length,
                itemBuilder: (context, index) {
                  String agent = agents[index];
                  bool isSelected = agent == selectedAgent;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAgent = agent;
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: isSelected ? 6 : 2,
                      color: isSelected ? Colors.yellowAccent.withOpacity(0.9) : Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Text(
                            agent[0], // First letter of agent's name
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          agent,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: isSelected
                            ? const Icon(CupertinoIcons.checkmark_alt_circle, color: Colors.black)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 Assign Button at the Bottom
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedAgent != null
                      ? () {
                    // Handle assignment logic here
                    showCustomSnackBar(context, "Assigned to $selectedAgent", true);
                  }
                      : null, // Disabled if no agent is selected
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text("Assign Agent"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
