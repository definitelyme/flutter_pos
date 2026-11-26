abstract class UseCase<R, P> {
  const UseCase();

  Future<R> execute(P param);
}

abstract class OpenUseCase<R> {
  const OpenUseCase();

  Future<R> execute();
}
