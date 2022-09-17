import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;