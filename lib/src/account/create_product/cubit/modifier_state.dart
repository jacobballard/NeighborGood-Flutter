part of 'modifier_cubit.dart';

class ModifierState {
  final List<Modifier> modifiers;
  final FormzStatus status;

  ModifierState({
    this.modifiers = const [],
    this.status = FormzStatus.valid,
  });

  ModifierState copyWith({
    List<Modifier>? modifiers,
    FormzStatus? status,
  }) {
    return ModifierState(
      modifiers: modifiers ?? this.modifiers,
      status: status ?? this.status,
    );
  }
}
