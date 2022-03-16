

class JusoList{
  late final int totalCount;
  late final List<Juso> jusoList;

  JusoList.fromJson(Map<String, dynamic> aMap)
  {
    totalCount = aMap["common"] == null ? 0 : (aMap["common"]["totalCount"] ?? 0);
    jusoList = aMap["juso"].map((val) => Juso.fromJson(val)).toList() ?? [];
  }
}

class Juso{
  late final String jibunAddr;
  late final String roadAddrPart1;
  late final String zipNo;

  Juso.fromJson(Map<String, dynamic> aMap)
  {
    jibunAddr = aMap["jibunAddr"] ?? "";
    roadAddrPart1 = aMap["roadAddrPart1"] ?? "";
    zipNo = aMap["zipNo"] ?? "";
  }


}