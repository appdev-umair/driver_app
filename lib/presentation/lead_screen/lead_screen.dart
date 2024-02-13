import 'package:animate_gradient/animate_gradient.dart';
import 'package:driver_app/core/app_export.dart';
import 'package:driver_app/core/utils/lottie_constants.dart';
import 'package:lottie/lottie.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({Key? key}) : super(key: key);

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  late Future<List<Lead>> _leadsFuture;
  late String status = ""; // Update to late

  @override
  void initState() {
    super.initState();
    _leadsFuture = LeadsService.getAllLeads(status);
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
          forceMaterialTransparency: true,
          title: const Text("Leads",
              style: TextStyle(fontWeight: FontWeight.bold)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
        body: SafeArea(
          child: FutureBuilder<List<Lead>>(
            future: _leadsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white,));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      const Text(
                        'No leads available!',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      Lottie.asset(LottieConstant.carAnimation, height: 300, width: 300),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(snapshot.data![index].name),
                        trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
                        subtitle: Text("Items ${snapshot.data![index].items}"
                            .split(".")[0]
                            .replaceAll(" ", ": ")),
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF2394C1),
          unselectedItemColor: const Color.fromARGB(131, 0, 0, 0),
          enableFeedback: false,
          currentIndex: _currentIndex(status),
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  status = "";
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
      ),
    );
  }

  int _currentIndex(String status) {
    switch (status) {
      case '':
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
