import 'package:driver_app/core/app_export.dart';
import 'package:driver_app/presentation/lead_screen/lead_data/lead_data.dart';
import 'package:driver_app/presentation/lead_screen/lead_detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LeadScreen extends StatefulWidget {
 const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  final Random random = Random();

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const LogInScreen(),
          ),
        );
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: leads.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(leads[index].name),
              subtitle: Text(leads[index].dateTime),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: LeadDetailScreen(leads[index]),
                      type: PageTransitionType.bottomToTop),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
