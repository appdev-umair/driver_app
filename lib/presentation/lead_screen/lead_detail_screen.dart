import 'package:animate_gradient/animate_gradient.dart';
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
  var requestLeadVisibility = true;

  Future<String?> _isFABDisplay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    print(widget.lead.driver);
    print(widget.lead.driver.contains(prefs.getString('userId')));

    if (!widget.lead.driver.contains(prefs.getString('userId'))) {
      setState(() {
        requestLeadVisibility = true;
      });
    } else {
      setState(() {
        requestLeadVisibility = false;
      });
    }
    return prefs.getString('userId');
  }

  @override
  void initState() {
    super.initState();
    _isFABDisplay();
  }

  _markedAsCompleted() {
    print("Umair");
    LeadsService.markLeadAsCompleted(widget.lead.id);
  }

  _requestLead() {
    LeadsService.requestLead(widget.lead.id);
    _isFABDisplay();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      primaryColors: const [
        Color.fromARGB(255, 31, 76, 151),
        Color.fromARGB(255, 39, 153, 189),
      ],
      secondaryColors: const [
        Color.fromARGB(255, 140, 0, 206),
        Color.fromARGB(255, 138, 203, 255),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          forceMaterialTransparency: true,
        ),
        floatingActionButton: Visibility(
          visible: requestLeadVisibility,
          child: FloatingActionButton.extended(
            onPressed: () => _requestLead(),
            label: const Text("Request Lead"),
          ),
        ),
        body: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(height: 18.0),
                    Text(
                      widget.lead.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Items: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("${widget.lead.items}"),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Driver: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    widget.lead.driver.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.lead.driver
                                .map((driver) => Text(driver))
                                .toList(),
                          )
                        : const Text("No Driver"),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Pickup: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.lead.pickupLocation),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Dropoff: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.lead.dropoffLocation),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Created at:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("${widget.lead.createdAt}"
                            .split(" ")[1]
                            .split(".")[0]),
                        const Spacer(),
                        Text("${widget.lead.createdAt}".split(" ")[0]),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Updated at:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("${widget.lead.updatedAt}"
                            .split(" ")[1]
                            .split(".")[0]),
                        const Spacer(),
                        Text("${widget.lead.updatedAt}".split(" ")[0]),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Status:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.lead.status),
                    const SizedBox(height: 18.0),
                    Visibility(
                      visible: widget.lead.status == "ASSIGNED" ? true : false,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              LeadsService.markLeadAsCompleted(widget.lead.id);
                            },
                            child: const Text("Marked as Completed"),
                          ),
                          const SizedBox(height: 18.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
