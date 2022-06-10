class JusoList{
  late final int totalCount;
  late final List<Juso> jusoList;

  JusoList.fromJson(Map<String, dynamic> aMap)
  {
    totalCount = aMap["common"] == null ? 0 : (int.tryParse(aMap["common"]["totalCount"]) ?? 0);
    List<dynamic> tempList = aMap["juso"];
    jusoList = [];
    tempList.forEach((val)
    {
      jusoList.add(Juso.fromJson(val));
    });
  }

  JusoList()
  {
    totalCount = 0;
    jusoList = [];
  }
}

class Juso{
  static const ADMCD = "admCd";
  static const RNMGTSN = "rnMgtSn";
  static const UDRTYN = "udrtYn";
  static const BULDMNNM = "buldMnnm";
  static const BULDSLNO = "buldSlno";
  static const JIBUN_ADDR = "jibunAddr";
  static const ROAD_ADDR_PART_1 = "roadAddrPart1";
  static const ZIP_NO = "zipNo";
  static const DETAIL_ADDR = "detailAddress";


  late final String jibunAddr;
  late final String roadAddrPart1;
  late final String zipNo;
  late final String admCd;
  late final String rnMgtSn;
  late final String udrtYn;
  late final String buldMnnm;
  late final String buildSlno;
  String? detailAddress;

  Juso.fromJson(Map<String, dynamic> aMap)
  {
    jibunAddr = aMap[JIBUN_ADDR] ?? "";
    roadAddrPart1 = aMap[ROAD_ADDR_PART_1] ?? "";
    zipNo = aMap[ZIP_NO] ?? "";
    admCd = aMap[ADMCD] ?? "";
    rnMgtSn = aMap[RNMGTSN]?? "";
    udrtYn = aMap[UDRTYN] ?? "";
    buldMnnm = aMap[BULDMNNM] ?? "";
    buildSlno = aMap[BULDSLNO] ?? "";
    detailAddress = aMap[DETAIL_ADDR];
  }

  void setDetailAddress(String detailAddress)
  {
    this.detailAddress = detailAddress;
  }

  Map<String, dynamic> toJson()
  {
    return {
      JIBUN_ADDR: jibunAddr,
      ROAD_ADDR_PART_1: roadAddrPart1,
      ZIP_NO : zipNo,
      ADMCD : admCd,
      RNMGTSN : rnMgtSn,
      UDRTYN : udrtYn,
      BULDMNNM: buldMnnm,
      BULDSLNO : buildSlno,
      DETAIL_ADDR: detailAddress
    };
  }


}