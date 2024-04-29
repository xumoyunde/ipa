part of 'color_cubit.dart';

abstract class ColorState extends Equatable {
  final Color backColor;

  const ColorState(this.backColor);

  @override
  List<Object?> get props => [];
}

class ColorInitialState extends ColorState {
  const ColorInitialState() : super(MyColors.background);
}

class ColorChangeState extends ColorState {
  const ColorChangeState(super.backColor);
}
