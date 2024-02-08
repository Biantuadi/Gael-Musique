/*
import 'package:countries_info/countries_info.dart';

void main() {
  /// Initialize the main object


  /// Get all countries
  print(countries
      .all()
      .length);

  /// Get common names of all countries
  /// sorted alphabetically ascending
  print(countries.getCommonNames(sort: 'asc'));

  /// Get official names of all countries
  /// sorted alphabetically descending
  print(countries.getOfficialNames(sort: 'desc'));
}


void main() {
  /// Initialize the main object
  Countries countries = Countries();

  /// Search countries by common or official names
  ///
  /// Case insensitive, returns partial matches.
  countries.name(query: 'indo').forEach((country) {
    print(country['name']['official']);
  });
}

void main2() {
  /// Initialize the main object
  Countries countries = Countries();

  /// Initialize a cascade search
  ///
  /// Add multiple cascade search filters as required. Each cascade filters the previous results.
  countries
    ..filter()
    ..byCodes(queryList: ['IND', 'IDN', 'USA', 'AUS'])
    ..byLanguage(query: 'english')

  /// Apply the filters and do stuff with the results
    ..apply().forEach((country) {
      print(country['name']['official']);
    });
}
 */