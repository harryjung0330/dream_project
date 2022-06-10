class RealEstateData{
  static const PRICE = "PRICE";
  static const REG_CODE = "REGION_CD";
  static const REG_NM = "REGION_NM";
  static const RESEARCH_DATE = "RESEARCH_DATE";
  static const TYPE = "TR_GBN";

  static const PURCHASE_TYPE = "S";
  static const RENT_TYPE = "D";

  late final String price;
  late final String regCode;
  late final String regName;
  late final int researchMonth;
  late final int researchYear;
  late final String type;

  RealEstateData.fromJson(Map<String, dynamic> aMap)
  {
    this.price = aMap[PRICE] == null? "-1" : aMap[PRICE].toString();
    this.regCode = aMap[REG_CODE] == null? "-1": aMap[REG_CODE].toString();
    this.regName = aMap[REG_NM] == null ? "error" : aMap[REG_NM].toString();
    this.researchMonth = int.tryParse(aMap[RESEARCH_DATE] == null ? "-1": aMap[RESEARCH_DATE].toString().substring(4)) ?? -1;
    this.researchYear = int.tryParse(aMap[RESEARCH_DATE] == null ? "-1": aMap[RESEARCH_DATE].toString().substring(0, 4)) ?? -1;
    this.type = aMap[TYPE].toString() ?? "error";

  }

  bool isPurchase()
  {
    return type == PURCHASE_TYPE;
  }

  bool isRent()
  {
    return type == RENT_TYPE;
  }

  int isGreater(RealEstateData other)
  {
    int temp =  this.researchYear - other.researchYear;
    if(temp != 0 )
      {
        return temp;
      }

    temp = this.researchMonth - other.researchMonth;

    return temp;
  }

  String toString()
  {
    return price + "  " + regName + "  " + researchYear.toString() + "/" + researchMonth.toString();
  }
}