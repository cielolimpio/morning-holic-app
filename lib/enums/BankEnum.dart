enum BankEnum {
  KOOKMIN('KOOKMIN', '국민'),
  SHINHAN('SHINHAN', '신한'),
  KAKAO('KAKAO', '카카오뱅크'),
  WOORI('WOORI', '우리'),
  SC('SC', 'SC제일'),
  INDUSTRIAL('INDUSTRIAL', '기업'),
  NONGHYUP('NONGHYUP', '농협');

  const BankEnum(this.value, this.displayName);

  final String value;
  final String displayName;

  factory BankEnum.getByDisplayName(String displayName){
    return BankEnum.values.firstWhere((it) => it.displayName == displayName);
  }
}