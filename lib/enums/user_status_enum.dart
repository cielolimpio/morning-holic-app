enum UserStatusEnum {
  INITIAL("INITIAL"),
  REQUEST("REQUEST"),
  ACCEPT("ACCEPT"),
  REJECT("REJECT");

  const UserStatusEnum(this.value);

  final String value;

  factory UserStatusEnum.getByValue(String value){
    return UserStatusEnum.values.firstWhere((it) => it.value == value);
  }
}