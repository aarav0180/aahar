import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../widgets/snack_bar.dart';

class DonationScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const DonationScreen({super.key, required this.latitude, required this.longitude});

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  XFile? _foodImage;
  String? _quantity;
  String? _name;
  String? _items;
  String? _vehicleSize;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _foodImage = image;
    });
  }

  Future<void> _submitToFirebase() async {
    try {
      String? imageUrl;

      if (_foodImage != null) {
        imageUrl = await _uploadImageToImgBB(_foodImage!);
      }

      await FirebaseFirestore.instance.collection('donations').add({
        'foodImage': imageUrl ?? 'No Image', // Save URL instead of file path
        'quantity': _quantity,
        'name': _name,
        'items': _items,
        'vehicleSize': _vehicleSize,
        'latitude': widget.latitude, // Uploading latitude
        'longitude': widget.longitude, // Uploading longitude
        'timestamp': Timestamp.now(),
      });

      showCustomSnackBar(context, 'Donation successfully submitted!', true);
    } catch (e) {

      showCustomSnackBar(context, 'Error: ${e.toString()}', true);
    }
  }

  Future<String?> _uploadImageToImgBB(XFile imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.imgbb.com/1/upload?key=4d4101b9a1570ecccdfc197edcf972a2'),
    );

    request.files.add(await http.MultipartFile.fromPath('image', File(imageFile.path).path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      return jsonResponse['data']['url']; // Return the uploaded image URL
    } else {
      //print("Failed to upload image");
      showCustomSnackBar(context, 'Failed to upload image', true);
      return null;
    }
  }

  void _continueStep() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _currentStep = (_currentStep + 1).clamp(0, 2);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _foodImage != null) {
      _submitToFirebase();
    } else if (_foodImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a food image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Donation')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _continueStep,
        onStepCancel: () => setState(() => _currentStep = (_currentStep - 1).clamp(0, 2)),
        steps: [
          Step(
            title: const Text('Food Details'),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: _foodImage != null
                        ? Image.file(File(_foodImage!.path), height: 250)
                        : Container(
                      height: 250,
                      width: 200,
                      color: Colors.yellowAccent[300],
                      child: const Icon(CupertinoIcons.camera),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name for the food'),
                    keyboardType: TextInputType.name,
                    onChanged: (value) => _name = value,
                    validator: (value) => value!.isEmpty ? 'Please enter the name' : null,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Approx Quantity (kg)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _quantity = value,
                    validator: (value) => value!.isEmpty ? 'Please enter the quantity' : null,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Number of Items'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _items = value,
                    validator: (value) => value!.isEmpty ? 'Please enter the number of items' : null,
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Vehicle Requirement'),
            content: DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Select Vehicle Size'),
              items: const [
                DropdownMenuItem(value: 'Small', child: Text('Small (Bike/Scooter)')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium (Car)')),
                DropdownMenuItem(value: 'Large', child: Text('Large (Truck)')),
              ],
              onChanged: (value) => _vehicleSize = value,
              validator: (value) => value == null ? 'Please select a vehicle size' : null,
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Confirm Submission'),
            content: Column(
              children: [
                const Text('Please review your donation details before submitting.',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Submit Donation'),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }
}
