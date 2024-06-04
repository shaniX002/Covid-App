class AppUrl {
  // this is base Url
  static const String baseUrl = "https://disease.sh/v3/covid-19";

  // fetch world cocid data
  static const String worldStateApi = "${baseUrl}all";
  static const String countriesList = "${baseUrl}countries";
}
