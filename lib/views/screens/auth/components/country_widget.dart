import 'package:Gael/data/providers/auth_provider.dart';
import 'package:countries_info/countries_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountriesWidget extends StatefulWidget{
  const CountriesWidget({super.key});

  @override
  State<StatefulWidget> createState() {
   return CountriesWidgetState();
  }


}
class CountriesWidgetState extends State<CountriesWidget>{
  Countries allCountries = Countries();
  List<Map<String, dynamic>> countries = [];

  @override
  void initState() {
    countries = allCountries.all();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, provider, child){
      countries = allCountries.name(query: provider.countrySearchKey);
      return ListView.separated(
        itemCount: countries.length,
        itemBuilder: (ctx, i){
          String code = countries[i]["idd"]["root"]??"- ";
          code +=  countries[i]["idd"]["suffixes"] != null? countries[i]["idd"]["suffixes"][0] :"-";
          return ListTile(
            title: Text(countries[i]["name"]['official'], style: Theme.of(context).textTheme.bodySmall,),
            subtitle: Text(code, style: Theme.of(context).textTheme.bodySmall,),
            leading: Text(countries[i]["flag"]),
            onTap: (){
              provider.setCountryFlagNCode(code: code, flag: countries[i]["flag"]);
              Navigator.pop(context);
            },

          );
        }, separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey, thickness: .1, height: .1,);
      },);
    });
  }
}