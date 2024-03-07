


String getFormattedDate(DateTime dateTime){
  int day = dateTime.day;
  int month = dateTime.month;
  int year = dateTime.year;
  String dayStr = "$day";
  if(day < 10){
    dayStr = dayStr.padLeft(2, "0");
  }
  String date = "";

    date = "le $dayStr ${getMonth(dateTime)} $year";

  return date;
}
String getFormattedDateWithDayName(DateTime dateTime){
  int day = dateTime.day;
  int month = dateTime.month;
  int year = dateTime.year;
  String dayStr = "$day";
  if(day < 10){
    dayStr = dayStr.padLeft(2, "0");
  }
  String date = "";

  date = "${getDayName(dateTime)} $dayStr ${getMonth(dateTime)} $year";

  return date;
}

String getMonth(DateTime dateTime){
  int day = dateTime.day;
  int month = dateTime.month;
  int year = dateTime.year;
  String monthName = "";
  switch (month){
    case 1:
      monthName = "Jan.";
      break;
    case 2:
      monthName = "Fév.";
      break;
    case 3:
      monthName = "Mar.";
      break;
    case 4:
      monthName = "Avr.";
      break;
    case 5:
      monthName = "Mai";
      break;
    case 6:
      monthName = "Jun.";
      break;
    case 7:
      monthName = "Jul.";
      break;
    case 8:
      monthName = "Aoû.";
      break;
    case 9:
      monthName = "Sep.";
      break;
    case 10:
      monthName = "Oct.";
      break;
    case 11:
      monthName = "Nov.";
      break;
    case 12:
      monthName = "Déc.";
      break;
    default:
      monthName = "...";
      break;
  }
  return monthName;
}

String getDayName(DateTime dateTime){
  int day = dateTime.day;
  int month = dateTime.month;
  int year = dateTime.year;
  String dayName = "";
  int dayInt = day;
  int monthInt = month;
  int yearInt = year;
  dayInt = (dayInt += monthInt<3 ?yearInt--:  yearInt -2);
  double wd = 0;
  if(monthInt < 3){
    wd = ((23 * monthInt / 9) + dayInt + 4 +yearInt + ((yearInt - 1)/4) - ((yearInt -1) /100) + ((yearInt - 1)/400))%7;
  }else {
    wd = ((23 * monthInt / 9 )+ dayInt + 2+ yearInt + (yearInt/4) - (yearInt/100) + (yearInt)/400) % 7;
  }
  switch(wd){
    case 1:
      dayName = "Lun.";
      break;
    case 2:
      dayName = "Mar.";
      break;
    case 3:
      dayName = "Mer.";
      break;
    case 4:
      dayName = "Jeu.";
      break;
    case 5:
      dayName = "Ven.";
      break;
    case 6:
      dayName = "Sam.";
      break;
    case 7:
      dayName = "Dim.";
      break;
    default:
      dayName = "...";
      break;
  }
  return dayName;
}

String getFormattedDuration(Duration duration){
  String hours = duration.inHours.remainder(60).toString().padLeft(2,'0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2,'0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');

  if(duration.inHours < 1){
    return "$minutes:$seconds";
  }
  return "$hours:$minutes:$seconds";
}