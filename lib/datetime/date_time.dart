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
// Convert DateTime object to string yyyymmdd