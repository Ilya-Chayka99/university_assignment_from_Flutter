
import 'dart:ffi';

class User {
   late Int id;
	 late String name;
	 late String lastName;
	 late String login;
	 late String password;
	 late DateTime birghtDay;
	 late String avatarHash;
  
  User(this.name,this.lastName,this.login,this.password,this.birghtDay,this.avatarHash);

}