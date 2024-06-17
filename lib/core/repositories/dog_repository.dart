import 'package:flutter_application_demo/core/database/daos/dao_dog.dart';
import 'package:flutter_application_demo/core/models/dog.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';

class DogRepository {
  final DaoDog _daoDog = DaoDog();

  createDog(Dog dog, Resolve<int> resolve) =>
    _daoDog.createDog(dog, resolve);

  findAllDogs(Resolve<List<Dog>> resolve) => _daoDog.findAllDogs(resolve);

  findDog(int id, Resolve<Dog?> resolve) => _daoDog.findDog(id, resolve);

  updateDog(Dog dog, Resolve<int> resolve) => _daoDog.updateDog(dog, resolve);

  deleteDog(int id, Resolve<int> resolve) => _daoDog.deleteDog(id, resolve);
}