

import 'package:api_learn/modules/repository.dart';

class AppBloc {
 final _repository = Repository();

 Repository repository(){
   return _repository;
 }
}