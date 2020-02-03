//Mark McMurtury
//This is a class file that will be the entry the user creates.
class Entry {
  String patientID;
  DateTime date;
  String timeDay;
  bool injuried;
  int severity;
  String location;
  String description;

  Entry(){
    this.patientID = null;
    this.date = null;
    this.timeDay = null;
    this.injuried = null;
    this.severity = null;
    this.location = null;
    this.description = null;
  }

//Functions to set the class variables.
  void setpatientID(String ID){
    this.patientID = ID;
  }

  void setDate(DateTime data){
    this.date = data;
  }

  void setTimeDay(String time){
    this.timeDay = time;
  }

  void setInjuried(bool I){
    this.injuried = I;
  }

  void setSeverity(int S){
    this.severity = S;
  }

  void setLocation(String L){
    this.location = L;
  }

  void setDescription(String D){
    this.description = D;
  }

//Functions to return the class variable information.
  String getpatientID(){
    return this.patientID;
  }
  DateTime getDate(){
    return this.date;
  }

  String getTimeDay(){
    return this.timeDay;
  }

  bool getInjuried(){
    return this.injuried;
  }

  int getSeverity(){
    return this.severity;
  }

  String getLocation(){
    return this.location;
  }

  String getDescription() {
    return description;
  }
}