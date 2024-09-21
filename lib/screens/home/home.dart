import 'package:app/screens/home/controllers/dashboard.dart';
import 'package:app/screens/home/widgets/grid_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        Provider.of<DashboardController>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: dashboardController.getDisorders(), // Call getDisorders
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, show a loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            // If the future is complete, show the actual UI
            List<Widget> disorderButtons = [];

            if (dashboardController.isDyslexic == true) {
              print("ok1");
              disorderButtons.add(GridButton(
                imageUrl: "assets/images/dyslexic.png",
                text: "Dyslexic",
                route: "/dyslexic",
              ));
            }

            if (dashboardController.isDysgraphic == true) {
              print("ok2");
              disorderButtons.add(GridButton(
                imageUrl: "assets/images/dysgraphic.png",
                text: "Dysgraphic",
                route: "/dysgraphic",
              ));
            }

            if (dashboardController.isDyscalculic == true) {
              print("ok3");
              disorderButtons.add(GridButton(
                imageUrl: "assets/images/dyscalculic.png",
                text: "Dyscalculic",
                route: "/dyscalculic",
              ));
            }

            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const SizedBox(
                  height: 150,
                  child: Logo(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Text(
                      "Circular Dashboard here"), // TODO: use this place for dashboard
                ),
                Text(
                  "Select your Learning Disorder",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                if (disorderButtons.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: disorderButtons,
                  ),
                if (disorderButtons.isEmpty)
                  Center(
                    child: Text(
                      "No disorders available",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
              ],
            );
          }

          return Center(
            child: Text('Error loading data'),
          ); // Error or other states
        },
      ),
    );
  }
}
