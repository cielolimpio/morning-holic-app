enum DiaryTypeEnum{
  INDOOR('INDOOR', '실내'),
  OUTDOOR('OUTDOOR', '야외');

  const DiaryTypeEnum(this.value, this.displayName);

  final String value;
  final String displayName;

  factory DiaryTypeEnum.getByDisplayName(String displayName){
    return DiaryTypeEnum.values.firstWhere((it) => it.displayName == displayName);
  }
}