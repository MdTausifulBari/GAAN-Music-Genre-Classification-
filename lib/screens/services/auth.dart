import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaan/screens/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromCredUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }


  // auth change user stream
  //Firebase User is now User?
  //onAuthStateChanged is now authStateChanges()

  Stream<Users?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromCredUser(user));
  }

  //sign in Anonymously
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromCredUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromCredUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromCredUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}