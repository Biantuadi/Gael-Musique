class Preference{
  late String theme;
  late String language;
  late bool notifications;
  Preference({

    required this.theme,
    required this.language,
    required this.notifications,

  });

  Preference.fromJson(Map<String, dynamic> json){
    theme = json["theme"];
    language = json["language"];
    notifications = json["notifications"];

  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["notifications"] = notifications;
    json["theme"] = theme;
    json["language"] = language;

    return json;
  }

}