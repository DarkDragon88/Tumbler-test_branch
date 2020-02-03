import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_login/services/authentication.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockFireBaseUser extends Mock implements FirebaseUser{}
class MockAuthResult extends Mock implements AuthResult{}
 

void main()  {
TestWidgetsFlutterBinding.ensureInitialized();
 MockFirebaseAuth _firebaseAuth = MockFirebaseAuth();
 BehaviorSubject<MockFireBaseUser> _user = BehaviorSubject<MockFireBaseUser>();
 when(_firebaseAuth.onAuthStateChanged).thenAnswer((_){
   return _user;
 });
Auth _userAuth = new Auth();
String _email = "email@email.com";
String _password = "Password";


 when(_firebaseAuth.signInWithEmailAndPassword(email: "email@email.com", password: "Passw0rd")).thenAnswer((_)async{
   _user.add(MockFireBaseUser());
   return MockAuthResult();
 });
 
test("Sign in with email and password ", () async{
  String signedIn = await _userAuth.signIn(_email,_password);
  expect(signedIn,signedIn != null);
});

  }
  
