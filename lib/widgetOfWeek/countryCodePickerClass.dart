import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CounterCodePickerClass extends StatefulWidget {
  const CounterCodePickerClass({Key? key}) : super(key: key);

  @override
  State<CounterCodePickerClass> createState() => _CounterCodePickerClassState();
}

String selectedCountry = ' ';

class _CounterCodePickerClassState extends State<CounterCodePickerClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country Selection"),
        leading: const Icon(Icons.south_america_outlined),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(selectedCountry),
          TextButton(
              onPressed: () {
                showCountryPicker(
                    context: context,
                    onSelect: (country) {
                      selectedCountry = country.name + country.phoneCode;
                      setState(() {});
                    },
                    countryListTheme: const CountryListThemeData(
                        flagSize: 30.0, bottomSheetHeight: 550),
                    showPhoneCode: true,
                    showWorldWide: true,
                    // countryFilter: ['PK'],

                );
              },
              child: const Text("Country")),
        ],
      )),
    );
  }
}
