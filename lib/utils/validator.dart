bool validEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validPassword(String password) {
  return password.length > 5;
}

bool validJob(String jobtitle) {
  return jobtitle.length > 3;
}

bool validLocation(String location) {
  return location.length > 3;
}

bool validDescription(String description) {
  return description.length > 3;
}


bool validDate(String date) {
  return date.length != 0;
}

bool validTimefrom(String dateFrom) {
  return dateFrom.length != 0;
}

                        /// Profile Edit ///

bool validgender(String gender) {
  return gender.length > 3;
}

bool validadress(String address) {
  return address.length > 3;
}

bool validphonenumber(String phnnumber) {
  return phnnumber.length >= 10;
}

bool validppsnumber(String number) {
  return number.length > 3;
}


bool validbankdetails(String bankdetails){
  return bankdetails.length>3;
}

bool validfirstname(String firstname){
  return firstname.length>3;
}

bool validlastname(String lastname){
  return lastname.length>3;
}


bool validbankiban(String bank){
  return bank.length>3;
}

bool validbankbic(String bic){
  return bic.length>3;
}


bool vaidpermission_to_work_in_ireland(String permission){
  return permission.length>3;
}
