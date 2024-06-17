import 'package:flutter/material.dart';
import 'package:flutter_application_demo/core/models/dog.dart';
import 'package:flutter_application_demo/core/models/notifiers/on_result.dart';
import 'package:flutter_application_demo/core/repositories/dog_repository.dart';
import 'package:flutter_application_demo/screens/common/loading_state.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';
import 'package:get/get.dart';

class DogState with ChangeNotifier {
  final _dogRepository = DogRepository();

  int? createDogObserver;

  List<Dog> listDogsObserver = [];

  Dog? dogObserver;

  int? updateDogObserver;

  int? deleteDogObserver;

  LoadingState loading = LoadingState.hide;

  String? error;

  bool refreshListObserver = false;

  void _result<T>(Result<T> data, Resolve<T> resolve) {
    switch (data) {
      case Error():
        loading = LoadingState.hide;
        error = data.message;
        notifyListeners();
        break;
      case Loading():
        error = null;
        loading = LoadingState.show;
        notifyListeners();
        break;
      default:
        break;
    }
  }

  void createDog(Dog dog) => _dogRepository.createDog(dog, (result) {
        switch (result) {
          case Success():
            createDogObserver = result.data;
            loading = LoadingState.hide;
            notifyListeners();
            break;
          case Error():
            loading = LoadingState.hide;
            error = result.message;
            notifyListeners();
            break;
          case Loading():
            error = null;
            createDogObserver = null;
            loading = LoadingState.show;
            notifyListeners();
            break;
          default:
            break;
        }
      });

  void findAllDogs() => _dogRepository.findAllDogs((result) {
        refreshListObserver = false;
        switch (result) {
          case Success():
            listDogsObserver = result.data;
            loading = LoadingState.hide;
            notifyListeners();
            break;
          case Error():
            loading = LoadingState.hide;
            error = result.message;
            notifyListeners();
            break;
          case Loading():
            error = null;
            listDogsObserver = [];
            loading = LoadingState.show;
            notifyListeners();
            break;
          default:
            notifyListeners();
            break;
        }
      });

  List<Dog> _validatePreviusList() {
    if (listDogsObserver is Success) {
      return (listDogsObserver as Success<List<Dog>>).data;
    }
    return [];
  }

  void findOneDog(int id) {
    final dog =
        _validatePreviusList().firstWhereOrNull((element) => element.id == id);
    if (dog != null) {
      dogObserver = dog;
      notifyListeners();
    } else {
      _findOneDog(id);
    }
  }

  void _findOneDog(int id) => _dogRepository.findDog(id, (result) {
        switch (result) {
          case Success():
            dogObserver = result.data;
            loading = LoadingState.hide;
            notifyListeners();
            break;
          case Error():
            loading = LoadingState.hide;
            error = result.message;
            notifyListeners();
            break;
          case Loading():
            error = null;
            dogObserver = null;
            loading = LoadingState.show;
            notifyListeners();
            break;
          default:
            break;
        }
      });

  void updateDog(Dog dog) => _dogRepository.updateDog(dog, (result) {
        switch (result) {
          case Success():
            updateDogObserver = result.data;
            loading = LoadingState.hide;
            notifyListeners();
            break;
          case Error():
            loading = LoadingState.hide;
            error = result.message;
            notifyListeners();
            break;
          case Loading():
            updateDogObserver = null;
            error = null;
            loading = LoadingState.show;
            notifyListeners();
            break;
          default:
            break;
        }
      });

  void deleteDog(int id) => _dogRepository.deleteDog(id, (result) {
        switch (result) {
          case Success():
            deleteDogObserver = result.data;
            loading = LoadingState.hide;
            notifyListeners();
            break;
          case Error():
            loading = LoadingState.hide;
            error = result.message;
            notifyListeners();
            break;
          case Loading():
            deleteDogObserver = null;
            error = null;
            loading = LoadingState.show;
            notifyListeners();
            break;
          default:
            break;
        }
      });

  void refreshListAfterUpdate() {
    updateDogObserver = null;
    createDogObserver = null;
    deleteDogObserver = null;
    loading = LoadingState.hide;
    refreshListObserver = true;
    notifyListeners();
  }
}
