import 'package:flutter/cupertino.dart';

import '../Services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading=false;
  FirebaseService service = FirebaseService();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> createAccount() async {
     isLoading=true;
    notifyListeners();
    try{ var user = await service.createAccount(
      name: nameController.text,
      password: passwordController.text,
      email: emailController.text,

    );}
    catch(e){
      print(e);
    }
    isLoading=false;
    notifyListeners();

  }
}
