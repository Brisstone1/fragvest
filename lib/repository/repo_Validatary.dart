abstract class RepoValidator {}

class RepoSucess extends RepoValidator {}

class RepoFailure extends RepoValidator {
  final String errorMessage;
  RepoFailure(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

abstract class LogValidator {}

class LogSucess extends LogValidator {
  final String message;
  LogSucess(this.message);

  @override
  String toString() {
    return message;
  }
}

class LogFailure extends LogValidator {
  final String errorMessage;
  LogFailure(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
