import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/app_colors.dart';

class NgoFormPage extends StatefulWidget {
  final String title;
  final bool isAgentForm;
  final void Function(Map<String, String>) onSubmit;

  const NgoFormPage({
    super.key,
    required this.title,
    required this.isAgentForm,
    required this.onSubmit,
  });

  @override
  State<NgoFormPage> createState() => _NgoFormPageState();
}

class _NgoFormPageState extends State<NgoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Animate(
              effects: [FadeEffect(duration: 300.ms), MoveEffect(begin: const Offset(0, 20))],
              child: Text(
                widget.isAgentForm ? "👷 Agent Registration" : "🏢 NGO Registration",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("name", "Full Name"),
                  const SizedBox(height: 16),
                  _buildTextField("email", "Email", inputType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  _buildTextField("phone", "Phone Number", inputType: TextInputType.phone),
                  const SizedBox(height: 16),
                  if (!widget.isAgentForm)
                    _buildTextField("organization", "Organization Name"),
                  if (widget.isAgentForm)
                    _buildTextField("area", "Preferred Area"),
                  const SizedBox(height: 32),
                  Animate(
                    effects: [FadeEffect(duration: 400.ms)],
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.onSubmit(_formData);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String key, String label, {TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? "Please enter $label" : null,
      onSaved: (value) => _formData[key] = value ?? '',
    );
  }
}
