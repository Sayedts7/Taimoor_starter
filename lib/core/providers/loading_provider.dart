import 'package:flutter/foundation.dart';

class LoadingProvider with ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;
  void loginLoading(bool value){
    _loading = value;
    notifyListeners();
  }


}