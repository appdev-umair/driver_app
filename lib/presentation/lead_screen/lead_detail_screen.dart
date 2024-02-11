import 'package:driver_app/core/utils/lottie_constants.dart';
import 'package:driver_app/presentation/lead_screen/lead_model/lead_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen(this.lead, {super.key});
  final Lead lead;
  @override
  State<LeadDetailScreen> createState() => LeadDetailScreenState();
}

class LeadDetailScreenState extends State<LeadDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Request Lead"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text(
              widget.lead.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Items: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${widget.lead.items}"),
            const Divider(),
            const SizedBox(height: 8.0),
            const Text(
              'Pickup: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.lead.pickupLocation),
            const Divider(),
            const SizedBox(height: 8.0),
            const Text(
              'Dropoff: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.lead.dropoffLocation),
            const Divider(),
            const SizedBox(height: 8.0),
            const Text(
              'Date & Time:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.lead.dateTime),
            const SizedBox(height: 20.0),
            Lottie.asset(LottieConstant.carAnimation),
          ],
        ),
      ),
    );
  }
}
