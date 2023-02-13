import 'package:flutter/material.dart';
import '../../modal/covid.dart';
import 'api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selectedCountry;
  List country = [];
  List flag = [];
  dynamic i;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Covid - 19",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
        future: ApiHelper.apiHelper.fetchCovidData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<COVIDData> data = snapshot.data as List<COVIDData>;
            country = data.map((e) => e.countryname).toList();
            return Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        iconSize: 25,
                        hint: const Text("Select The Country"),
                        value: selectedCountry,
                        onChanged: (val) {
                          setState(() {
                            selectedCountry = val;
                            i = country.indexOf(val);
                          });
                        },
                        items: country.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text("$e"),
                          );
                        }).toList(),
                      ),
                    ),
                    if (i != null)
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(data[i].flagImage),
                                            fit: BoxFit.fill),
                                        border: Border.all(
                                          color: Colors.black26,
                                          width: 2,
                                        )),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "country: ${data[i].countryname}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            card1(
                                title: "Country Data",
                                totalCount: data[i].countryname,
                                todayCount: data[i].population,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            card(
                                title: "Population",
                                totalCount: data[i].countryname,
                                todayCount: data[i].population,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            card(
                              title: "Confirmed",
                              totalCount: data[i].totalCases,
                              todayCount: data[i].todayCases,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            card(
                                title: "COVID Test",
                                totalCount: data[i].test,
                                todayCount: data[i].todayCases,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            card(
                                title: "Recovered",
                                totalCount: data[i].totalRecovered,
                                todayCount: data[i].todayRecovered,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            card(
                                title: "Deaths",
                                totalCount: data[i].totalDeaths,
                                todayCount: data[i].todayDeaths,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            card(
                              title: "Active",
                              totalCount: data[i].activeCases,
                              todayCount: "0",
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Image(
              image: AssetImage("assets/gif/corona.gif"),
              height: 500,
              width: 500,
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  card(
      {required title,
      required totalCount,
      required todayCount,
      required color}) {
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: const BoxDecoration(
          color: Colors.lightBlue,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$totalCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$todayCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            )
          ],
        ),
      ),
    );
  }

  card1({
    required title,
    required totalCount,
    required todayCount,
    required color,
  }) {
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Population",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "$todayCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            )
          ],
        ),
      ),
    );
  }
}
