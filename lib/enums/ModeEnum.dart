enum ModeEnum {
  MILD('MILD', '마일드 모드'),
  CHALLENGE('CHALLENGE', '챌린지 모드');

  const ModeEnum(this.value, this.displayName);

  final String value;
  final String displayName;

  factory ModeEnum.getByDisplayName(String displayName){
    return ModeEnum.values.firstWhere((it) => it.displayName == displayName);
  }
}