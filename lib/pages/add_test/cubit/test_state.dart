part of 'test_cubit.dart';

abstract class TestState extends Equatable {
  const TestState();
}

class TestInitial extends TestState {
  final int value;

  const TestInitial(this.value);

  @override
  List<Object?> get props => [];
}

class TestLoading extends TestState {
  const TestLoading();

  @override
  List<Object?> get props => [];
}

class TestSaved extends TestState {
  TestSaved();

  @override
  List<Object?> get props => [];
}

class CorrectAnswerChanged extends TestState {
  final int value;

  CorrectAnswerChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class TestFailure extends TestState {
  final String error;

  TestFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
