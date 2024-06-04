import 'package:covid_tracker_app/Services/state_services.dart';
import 'package:covid_tracker_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountiresListScreen extends StatefulWidget {
  const CountiresListScreen({Key? key});

  @override
  State<CountiresListScreen> createState() => _CountiresListScreenState();
}

class _CountiresListScreenState extends State<CountiresListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search with country name',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListTile(
                          title: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          leading: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var countryData = snapshot.data![index];
                      String name = countryData['country'] ?? 'Unknown';
                      if (searchController.text.isEmpty ||
                          name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  image: countryData['countryInfo']?['flag'],
                                  name: name,
                                  totalCases: countryData['cases'] ?? 0,
                                  totalRecovered: countryData['Recovered'] ?? 0,
                                  totalDeaths: countryData['deaths'] ?? 0,
                                  active: countryData['active'] ?? 0,
                                  todayRecovered:
                                      countryData['todayRecovered'] ?? 0,
                                  critical: countryData['critical'] ?? 0,
                                  test: countryData['test'] ?? 0,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(countryData['country']),
                            subtitle: Text(countryData['cases'].toString()),
                            leading: countryData['countryInfo'] != null
                                ? Image.network(
                                    countryData['countryInfo']['flag'],
                                    height: 50,
                                    width: 50,
                                  )
                                : Placeholder(), // Placeholder for flag image
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
