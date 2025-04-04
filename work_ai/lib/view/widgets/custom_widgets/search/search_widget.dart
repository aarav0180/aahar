import 'package:flutter/material.dart';
import '../../../../core/configs/text_configs/text_config.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController searchController;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final IconData? icon;

  const SearchInput({
    required this.searchController,
    required this.hintText,
    this.onChanged,
    this.icon = Icons.search, // Default search icon
    super.key,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      duration: const Duration(milliseconds: 300),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.98, // Responsive width
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 15),
            blurRadius: 30,
            spreadRadius: 0,
            color: isDarkMode ? Colors.blue.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: TextField(
        controller: widget.searchController,
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyles.smallBold.copyWith(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        cursorColor: isDarkMode ? Colors.blue[300] : Colors.blue[700],
        onTap: () => setState(() => isFocused = true),
        onEditingComplete: () => setState(() => isFocused = false),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              widget.icon,
              size: 23,
              color: isFocused
                  ? (isDarkMode ? Colors.blue[300] : Colors.blue[700])
                  : (isDarkMode ? Colors.white70 : Colors.black54),
            ),
          ),
          filled: true,
          fillColor: isDarkMode ? Colors.black54 : Colors.white,
          hintText: widget.hintText,
          hintStyle: AppTextStyles.small.copyWith(
            color: isDarkMode ? Colors.white60 : Colors.black54,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: isDarkMode ? Colors.blueGrey : Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? Colors.blue[300]! : Colors.blue[700]!,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
