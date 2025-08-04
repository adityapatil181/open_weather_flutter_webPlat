import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class WeatherController extends GetxController {
  var isLoading = false.obs;
  var weather = Rxn<WeatherModel>();
  var recentSearches = <String>[].obs;

  final String apiKey = '0efc7646d167cfb750b0e5affdc17b39';

  @override
  void onInit() {
    loadRecentSearches();
    super.onInit();
  }

  Future<void> fetchWeather(String city) async {
    if (city.trim().isEmpty) return;
    isLoading.value = true;
print('${isLoading.value} loaing valueeeeee');
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        weather.value = WeatherModel.fromJson(json.decode(response.body));
        print('${ weather.value} waether response dataaaa');
        addRecentSearch(city);
      } else {
        Get.snackbar('Error', 'City not found!');
      }
    } catch (e) {
      print('$e erorrrrrr');
      Get.snackbar('Error', 'Failed to fetch weather');
    } finally {
      isLoading.value = false;
    }
  }

  void addRecentSearch(String city) async {
    print('addRecentSearch');
    if (!recentSearches.contains(city)) {
      recentSearches.insert(0, city);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('recent_searches', recentSearches);
    }
  }

  void loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('recent_searches') ?? [];
    recentSearches.value = stored;
  }
}
