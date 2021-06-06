enum AssignType {
  father,
  mother,
  none,
}

extension Assign on AssignType {
  // ここの日本語は要検討
  static const Map<AssignType, String> jpnValues = <AssignType, String>{
    AssignType.father: 'パパ',
    AssignType.mother: 'ママ',
    AssignType.none: 'なし'
  };
  String get value => toString().split('.').last;
  String get jpnValue => jpnValues[this];
  static AssignType from(String value) =>
      AssignType.values.firstWhere((AssignType type) => type.value == value,
          orElse: () => AssignType.none);
}
