enum ModifierType { input, picker }

class Modifier {
  final String title;
  final ModifierType modifierType;
  final List<ModifierOption> options;
  final int maxOptions;
  final bool allowDuplicates;
  final bool hasDefaultOption;
  final int? characterLimit;

  Modifier({
    required this.title,
    required this.modifierType,
    required this.options,
    required this.maxOptions,
    required this.allowDuplicates,
    required this.hasDefaultOption,
    this.characterLimit,
  });
}

class ModifierOption {
  final String name;
  final double? price;

  ModifierOption({required this.name, this.price});
}
