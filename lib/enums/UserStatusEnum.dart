enum UserStatusEnum {
  INITIAL("INITIAL"),
  REQUEST("REQUEST"),
  ACCEPT("ACCEPT"),
  REJECT("REJECT");

  const UserStatusEnum(this.value);

  final String value;

  factory UserStatusEnum.getByDisplayName(String value){
    return UserStatusEnum.values.firstWhere((it) => it.value == value);
  }
}