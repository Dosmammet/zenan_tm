import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstagramStyleSearchBar extends StatelessWidget {
  void Function()? onTap;
  InstagramStyleSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .dialogBackgroundColor, // Light gray background
              borderRadius: BorderRadius.circular(12), // Rounded edges
            ),
            child: TextField(
              onTap: onTap,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: 'Fasons'.tr,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Add more UI elements below to resemble Instagram Explore
          // like grids, recommendations, etc.
        ],
      ),
    );
  }
}
