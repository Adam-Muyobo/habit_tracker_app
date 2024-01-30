// Return todays date as yyyymmdd
String todaysDateFormated(){
  // today
  var dateTimeObject = DateTime.now();

  // Year format
  String yyyy = dateTimeObject.year.toString();
  // Month format
  String mm = dateTimeObject.month.toString();
  if(mm.length == 1){
    mm = "0$mm";
  }
  // day format
  String dd = dateTimeObject.day.toString();
  if(dd.length == 1){
    dd = "0$dd";
  }
  // final format and return date
  return yyyy + mm + dd;
}
// Convert String yyyymmdd to DateTime object
DateTime createDateTimeObject(String yyyymmdd){
  int yyyy = int.parse(yyyymmdd.substring(0,4));
  int mm = int.parse(yyyymmdd.substring(4,6));
  int dd = int.parse(yyyymmdd.substring(6,8));

  return DateTime(yyyy, mm, dd);
}
// Convert DateTime object to string yyyymmdd
String convertDateTimeToString (DateTime dateTime){
  // Year format
  String yyyy = dateTime.year.toString();
  // Month format
  String mm = dateTime.month.toString();
  if(mm.length == 1){
    mm = "0$mm";
  }
  // day format
  String dd = dateTime.day.toString();
  if(dd.length == 1){
    dd = "0$dd";
  }
  // final format and r eturn date
  return yyyy + mm + dd;
}