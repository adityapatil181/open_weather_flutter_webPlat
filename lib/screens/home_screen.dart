import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import '../widgets/weather_card_details.dart';

class HomeScreen extends StatelessWidget {
  final WeatherController controller = Get.put(WeatherController());
  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      controller.fetchWeather(searchCtrl.text);
                      searchCtrl.clear();
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Recent Searches
            Obx(() => controller.recentSearches.isEmpty
                ? const SizedBox.shrink()
                : Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.recentSearches
                              .map((city) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: ActionChip(
                                      label: Text(city),
                                      backgroundColor: Colors.blue[100],
                                      onPressed: () => controller.fetchWeather(city),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  )),

            const SizedBox(height: 24),

            // Weather Display
            Expanded(
              child: Center(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else if (controller.weather.value != null) {
                    return WeatherCard(weather: controller.weather.value!);
                  } else {
                    return Text(
                      "Search for a city to view weather.",
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
