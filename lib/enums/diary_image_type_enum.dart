enum DiaryImageTypeEnum{
  WAKE_UP("WAKE_UP", "기상"),
  ROUTINE_START("ROUTINE_START", "루틴 시작"),
  ROUTINE_END("ROUTINE_END", "루틴 끝"),
  ROUTINE("ROUTINE", "루틴");

  const DiaryImageTypeEnum(this.value, this.displayName);

  final String value;
  final String displayName;

  factory DiaryImageTypeEnum.getByValue(String value){
    return DiaryImageTypeEnum.values.firstWhere((it) => it.value == value);
  }
}