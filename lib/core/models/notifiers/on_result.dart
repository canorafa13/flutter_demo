

sealed class Result<T> {
  
  const Result();

  factory Result.success(T data) => Success(data: data); 

  factory Result.error(String message) => Error(message: message);

  factory Result.loading() => const Loading();

  factory Result.none() => const None();

}

class Success<T> extends Result<T>{
  final T data;

  const Success({required this.data});
}

class Error<T> extends Result<T> {
  final String message;

  const Error({required this.message});
}

class Loading<T> extends Result<T>{

  const Loading();
}

class None<T> extends Result<T>{ const None(); }