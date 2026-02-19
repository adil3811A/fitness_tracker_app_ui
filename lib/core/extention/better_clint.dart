

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

extension DebountAndCencelExtention on Ref{
  Future<http.Client> getBetterClint () async{
    final clint = http.Client();
    var dispose = false;
    onDispose(() {
      dispose = true;
      clint.close();
    },);
    if(dispose){
      throw Exception('Clint close');
    }
    await Future.delayed(const Duration(seconds: 1));
    
    return clint;
  }
}