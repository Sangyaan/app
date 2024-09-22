import 'package:app/contants/colors.dart';
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
      backgroundColor: backgroundEel,
      body: FutureBuilder(
        future: dashboardController.getDisorders(), // Call getDisorders
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, show a loading spinner
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            // If the future is complete, show the actual UI
            List<Widget> disorderButtons = [];

            if (dashboardController.isDyslexic == true) {
              disorderButtons.add(const GridButton(
                imageUrl: "assets/images/dyslexic.png",
                text: "Dyslexic",
                route: "/dyslexic",
              ));
            }

            if (dashboardController.isDysgraphic == true) {
              disorderButtons.add(const GridButton(
                imageUrl: "assets/images/dysgraphic.png",
                text: "Dysgraphic",
                route: "/dysgraphic",
              ));
            }

            if (dashboardController.isDyscalculic == true) {
              print("ok3");
              disorderButtons.add(const GridButton(
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
                Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "🔥",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "2 days",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "XP",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: pinkButton,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "1200",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Lvl",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Intermediate",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: blueShadow,
                                offset: Offset(0, 3),
                                blurRadius: 0)
                          ], borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: shadowGreen,
                              backgroundColor: buttonBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/takeDyscalculiaTest");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.share),
                                const Text(
                                  'Share your progress',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Divider(
                        color: textGrey,
                      ),
                    ),
                    Text(
                      "Continue your learning journey",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textGrey),
                    ),
                    SizedBox(width: 50, child: Divider(color: textGrey))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                if (disorderButtons.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: disorderButtons,
                  ),
                if (disorderButtons.isEmpty)
                  const Center(
                    child: Text(
                      "No disorders available",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
              ],
            );
          }

          return const Center(
            child: Text('Error loading data'),
          ); // Error or other states
        },
      ),
    );
  }
}
