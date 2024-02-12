import 'package:driver_app/core/app_export.dart';


class LeadScreen extends StatefulWidget {
  const LeadScreen({Key? key}) : super(key: key);

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  late Future<List<Lead>> _leadsFuture;
  late String status = "ASSIGNED"; // Update to late

  @override
  void initState() {
    super.initState();
    _leadsFuture = LeadsService.getAllLeads(status);
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
      body: FutureBuilder<List<Lead>>(
        future: _leadsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No leads available'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].name),
                    trailing: Text("Items ${snapshot.data![index].items}"),
                    subtitle: Text("${snapshot.data![index].createdAt}"
                        .split(".")[0]
                        .replaceAll(" ", ", ")),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: LeadDetailScreen(snapshot.data![index]),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color(0xFF2394C1),
        currentIndex: _currentIndex(status),
        onTap: (index) {
          setState(() {
            switch (index) {
              case 0:
                status = "ALL";
                break;
              case 1:
                status = "PENDING";
                break;
              case 2:
                status = "ASSIGNED";
                break;
              case 3:
                status = "COMPLETED";
                break;
            }
            _leadsFuture = LeadsService.getAllLeads(status);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Assigned',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
        ],
      ),
    );
  }

  int _currentIndex(String status) {
    switch (status) {
      case 'ALL':
        return 0;
      case 'PENDING':
        return 1;
      case 'ASSIGNED':
        return 2;
      case 'COMPLETED':
        return 3;
      default:
        return 2; // Default to Assigned
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        LogInService.logout();
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const LogInScreen(),
          ),
        );
        break;
      case 'Settings':
        // Handle settings
        break;
    }
  }
}
