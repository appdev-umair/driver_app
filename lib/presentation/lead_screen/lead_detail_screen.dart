import 'package:driver_app/model/leads_model.dart';
import 'package:driver_app/services/lead_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen(this.lead, {super.key});
  final Lead lead;
  @override
  State<LeadDetailScreen> createState() => LeadDetailScreenState();
}

class LeadDetailScreenState extends State<LeadDetailScreen> {
  var _visibility = true;

  Future<String?> _isFABDisplay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    print(widget.lead.driver);
    print(widget.lead.driver.contains(prefs.getString('userId')));

    if (!widget.lead.driver.contains(prefs.getString('userId'))) {
      setState(() {
        _visibility = true;
      });
    } else {
      setState(() {
        _visibility = false;
      });
    }
    return prefs.getString('userId');
  }

  @override
  void initState() {
    super.initState();
    _isFABDisplay();
  }

  _requestLead() {
    LeadsService.requestLead(widget.lead.id);
    _isFABDisplay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      floatingActionButton: Visibility(
        visible: _visibility,
        child: FloatingActionButton.extended(
          onPressed: () => _requestLead(),
          label: const Text("Request Lead"),
        ),
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
              'Driver(s): ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  widget.lead.driver.map((driver) => Text(driver)).toList(),
            ),
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
              'Created at:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${widget.lead.createdAt}".split(" ")[0]),
            Text("${widget.lead.createdAt}".split(" ")[1].split(".")[0]),
            const Divider(),
            const SizedBox(height: 8.0),
            const Text(
              'Updated at:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${widget.lead.updatedAt}".split(" ")[0]),
            Text("${widget.lead.updatedAt}".split(" ")[1].split(".")[0]),
            const Divider(),
            const SizedBox(height: 8.0),
            const Text(
              'Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.lead.status),
          ],
        ),
      ),
    );
  }
}
