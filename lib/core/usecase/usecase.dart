import "package:cafe_app/core/either/either.dart";
import "package:cafe_app/core/error/failure.dart";

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
