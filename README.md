# 부스터란?
- 부스터란 부동산 스터디의 줄임말로, 부동산 관련 정보를 제공하고, 유저들이 분석한 부동산을 공유하는 기능을 가진 어플리케이션입니다.
- 부스터는 3가지의 주요 기능이 있습니다:
1. 부동산관련 기사 추천
2. 부동산관련 지표 조회
3. 부동산 분석내용 작성 및 공유

### UI
- 로그인
![로그인](https://github.com/harryjung0330/dream_project/blob/main/사진/로그인.png)
- 부동기사 추천
![기사추천](https://github.com/harryjung0330/dream_project/blob/main/사진/기사추천.png)  
![기사 상세 조회](https://github.com/harryjung0330/dream_project/blob/main/사진/기사%20상세조회.png)
- 부동산 관련 지표 조회
![지표조회](https://github.com/harryjung0330/dream_project/blob/main/사진/부동산_데이터_조회.png)
- 부동산 분석내용 작성 및 공유
![분석내용 조회](https://github.com/harryjung0330/dream_project/blob/main/사진/방분기%20리스트.png)
![분석내용 상세조회](https://github.com/harryjung0330/dream_project/blob/main/사진/임장기_상세조회.png)
![분석내용_추가](https://github.com/harryjung0330/dream_project/blob/main/사진/임장기%20추가.png)
  
### Frontend
- 기술 스택: Flutter, Dart
- 아키텍쳐: MVC architecture
![04_MVC](https://github.com/harryjung0330/dream_project/blob/main/사진/04_MVC.png)
- Repository: Network나 Local Storage(Secure Shared Preference) 등등에서 데이터를 가져옴
- Service: Repository에서 가져온 데이터를 Model로 변환시켜서 앱에서 사용할수 있게함
- Controller: View와 소통하여 View에 필요하 데이터를 제공함

### Backend
![05_system_arch](https://github.com/harryjung0330/dream_project/blob/main/사진/05_시스템아키텍쳐.png)
- 시스템 설계 디테일 링크: [링크](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=dream_architecture.drawio#R7V1pd6LK0%2F8081JOb2wvjSYZ8xcyiUZj3jwHkRBccxTH5dM%2FVY24ACbmzhhNhjk3V2jopruqevlVdVf94KXB%2FHrsvL5Yo47X%2F8FIZ%2F6Dl38wxjRG4AdTFqsUZhpRij8OOlEa3STUgqUXJerqKnUadLzJzovhaNQPg9fdRHc0HHpuuJPmjMej2e5rz6P%2B7ldfHd9LJdRcp59ObQad8CVKNQnZpP%2F0Av8l%2FjJlq4q3Hbfnj0fT4ep7Pxh%2Flv%2BixwMnLmtV0uTF6YxmW0n88gcvjUejMLoazEteH4kbky3Kd7Xn6breY28YHpJBo6ZgxPAKqqurBeG1nwuG6PCC6hlCVw2Ddzwelfnb6U%2B9uFGy6uEiJhe04hUvB3MfBUJxZhOu9J1Bu%2BP84BfPQb9fGvVHY%2Fkyv1INlQtIT9d1Vf3f3jj05ltJq7pfe6OBF44X8MrqqVBXdFwJGidadD%2FbcE3XlBVzXrZYZq6a5awkxV%2BXvaEWXKwIlk08LjwDiucFT%2BVuQQjGCqZn6IVnVYWaeA4HKh5OvGAghfJC%2FhYnr5FcE0hx4pvnYO514lfgvuOEQOBidMuuJr%2F9H%2BxiPoA6ln79tNnT4kK0m%2FOpuySB8%2FOeuOXR7yrv8M5C5dZC%2Fe0O3N9WtzizSuayM3CDys%2FO69PP%2B9GvWkXc1iq%2Bc914fWIvJL53%2Bb3avn4wK4On1%2Fb1TKtcqxR%2B9UpXGC3WX7TYvF%2B5tgW8T%2BySoJXgouvVSWCX76Y25u9uXSfL%2BnkzbA0uR1Zp5m%2F%2BenolABJe%2FLp2%2Fc7Pm5f20B60%2BU34q3ZD3MHV1GXzl871w8hezPj%2FahV88z%2B1%2B%2Bn16bFTanPfrHSL8N0it2v4J0u8vu8%2FDS15NX9tDxovbq%2BzaDXvX5%2BaKqlc93tQm9pT8%2F4n1KjnNBvTTqnie%2BVLsxKQuV0T1Mb7Otx3e7Nq94EAXYQFtLitF6d23YLv9xZAs9CqP0T315vyG031tfPTMivDxvLp8abuXl91nx7MaePR7iPdgY6%2F3dLF76fBEzy%2Fw%2FpDeTZp82LYYuakzStQDzt4KheFVW8F1WVWnsusPIOn7sPCrldknipLt%2F1Xd%2Fb76boxcOE50Pz1qUyCh0FjAPXstwer%2Bl1fEae0ftZ7JFu0Cy56rcf7l2pTfWk3QRb6N%2F2n0sUOHZNy0nm8mfyvZCfo3QOaQTt6ZFYpX4zsZYPBX8X6OZJ1j%2BtWa9q%2F233z4enRTn%2B71%2B%2B2mfAb140lfFdK0gXIlu9jznr9TgDn5pVya17tNl6sWhGupaTMq8Dh2xqZWvWen0gnVkCmt%2BUrVq3fsVb9Ep%2FP5PMacL7sh9WuTyvlnXTMN7Obs7m1KLJq16KpfPUWlNln1vJhai3vk3Vht3DfLhHMTyD%2FAvKv6ibmt%2BtyoL7LO9%2B6eg3hmoCULm8fW8Ri8N0aWVa7LdoJyNK%2BerWtbgt6bJFBfrq%2FrIpvXc9Agq0Qev7SGlzOZbtK%2BM4ltLMlqvWrJvQ6qPtunSswUtiSTv2JzB%2BIpd3cyS%2FbbZUf%2FEQ%2BYi%2BEsKHedup7dwugLfCqR%2FBvmz6y7o3XsFq%2FXFTrLd9C%2Bi4Eg3JCu2xPIB3KQtp2HJCSZednf%2FIEo9jToD9pl0dd6DWD1ai0KyEcJMS3uu7UbvqhxVuhNfCXzQGBFhVnToksgaILp2w77RphKKfVug2ScTOyKNYGanK9la9HsHUgHXcqSNzb7x72DdtaWlNsrV0GLtTvoaXW1F5CGQuxsJIUBwmC9izqZQukAe6X9gQot4RnIIE3lrXEX5CgZWdiBcCFoAgUv6NYb3hPhXrPkPJtWY4VovRYvRmBbxF4d2kzkBbMtyCYj2C51kJ%2BE%2Bot64VcWSSkf7b6%2FoGcScwZiza%2Fl%2FNFte5irRbwJeDanbgtQY2gZrf11uv%2Bki9wpLex5VYX%2BsAS%2BsWDjy3ine5NJUrva6salMyhHB9x7OQwJ8kx1I2e4KwDVzCTd4IxTO3BaAizuedMwr%2BzLCoYRCGEEWLCP2FqTOyskqjOiMJN3YQFLSEq4UZ60WQqGhGEQn7DNJlK0yuoPa%2F80YKKeh6lhlpoU5UVhM5ooa3r7QLhVH3uEE3zXCe1oCr%2BgtGaXDuhN3MWqdUVUAyJ2nfaXv%2FXaBKsaD2O2nGBNA1g3V9NPG%2BPwnA0wMXraBhuLV6J%2FLdKX%2BEWWPvzi%2FEodFZ58fHk1XGDoV%2F1npFaFJNeQliYwfVfYjGLIUfMVE3QeKH7JzwwGsaNVi3w%2F7lLt2U%2Bs0lXKxaoSJG9PPacQbHTaQRAtH1k32rzJByPel5MyuFo6CWgwSrJ6Qc%2BUtEF2njjLRYVVw8GQaeDn7mYvQShVwNC4zdnADwkGwB64RpZcuGvIAxDSVAalvyp%2FqKRdAfh5FjcUL8QJFMJjBOfCMqyKaZly2%2FpxXN7duD2hs7AK09f%2ByBoofedpXmXOUI1TyzK%2BhcSZS1WT51QkNMKhUiQ4X%2BhZ3uzX5PvLL2psVgTaZZ8rgCbZy3AKYIZ7OQyHOs%2BkzJc9kIn6P976wndPLEMr1vxRWTYPP04HFMoKcPXXlgNep4U4n9rJDZPPRKz8zZUpAi2MRqdUIz34DoQ43sPZa2IUtb3vrMo60LRE5whJx%2BRzxvhpWWZncGQvAfjgSw%2FTLxxZfg8%2BrekmJ18RE6DO8mRf2KGzGAIP%2Fmw8gFz9FkMK%2BIMpsgvBvComiFln0wzvgfhVUd%2BZfiN%2B7y2JvOaGdqJuzw%2Fb2y3q2CjRrzD6oSyuwfZ3XtO5x9YDWcMKLqeZsrnyvB5I7uEDJvq6WV4D6wDTDcaDLzhPyrIJju1IJ83rNsVZIDBpxfkPZhuLcjfHkaklhSMnHw4%2Fko2OzRAn1yK9xjtap4zdl%2F%2BybGYsZOPxV8M1zFx%2BuFY7MF1kSB%2F%2B7E4rdJh%2FNSDsThvfJcWY%2FX047HYA%2FFqsKCwnKD%2FrfdQpBcU6qmHYvGV8B3TM8j12QK8B9%2FFAlwDyZq%2BfmMhzhhXNPPUUnzW4E7Q1Nxlnl65LvbgOxTgh39MgI1TW4fEV8J1nJze4iz24LqHYf9fsHCmZZiTU5ucxXmjuoQMs9OPwOoeSNfwxsHzojTqeN96NZwhw%2FTU47B63pAuIcP89OOwugfPbWT4H1xPcH7qsVhPDy0pDqCvjNfDCbD2%2BOG04xLIm4QxBFEo3yGM0GjGgSQzU2RprF75%2BzL7iRPV29x5X8hiwmUcE%2F3cjq6lIVYEF1ygTzD0v5wq%2FU85s3rK12w4WV8%2FYM46dl8XB2sWKTva3P2Jqqy3GXFwt453aZ5w%2Ft6jzmo640FV0uWr9%2BjDmXKqDmzswQHFafgyGgdLoNRXYcHHz9JzkjxLr6c7xeey45wxQIEzmtzoqJOTDyNGGgakaCb3Po2lxzW370wmgbsrwQfKltfZ8R%2F3ZjdWM%2BQmTht7fScMfns7hWcRZvWFX6MAarLlBIKTBBs0tlvIZDQdu94q34bA6aKM90oKnbHvhamSJKvWLf%2Fv3KMxjtzmFpC5trodjWEg8kdDp3%2B5SU3wa%2FNOdTR6XbG064XhYuWqw5mGox%2BHueKICPdGhc3VCj6iy5stEwdKzcHi8Ef9xDwAeuzSNWsU3qJhxgj%2FF0YZnrRXZCjL1mk7gzInxxqWKfnrY4w3D8LH1RO8bmG6oq7uyvOt18qL%2BGYIjXncvolyCVWNEzYZ5d1Ozl%2FeOAB64Mz79jC33QcOd3b4boeIBfBMRtGkoFEtlqqPDqIidRZDT5R07EE0Y2tDSj6PrnNBOGrsECLLc8Zna1zoZ24zeIc7X0jnQvdtNih24m3kKSqeKzL4Y66cjb6FZljO9wrzWXmWZegNdcuzrLz%2FgGfZpRVU%2FBbvmRX03xdcLOK0M%2FcoS6O%2FyurbTvPOrPQ7kDN8bUOOX935rPV4P1r5MZ3bJenJE%2F3ocvvBp9WuNd%2F1hUjmkUdN9Ol4s%2BtRs3wZWk1fhTwi4T8Rnl0x9MJpd%2B1dz6H4nvSK6U%2BtpY9%2BJTnmb3QrpNq9XNTKLUi%2Fcur1CpTbQv%2BOkO5Sp0QyvhPXzUXvpx%2BrW%2F0BfVMeWjeBXj6hDvK%2B2Yv9R94x9Jlpl9FT6guzer5M99Cn5jZdm354i55Pr3e9h2L9oexZmuZQl%2B4dehFV8dpCz6Wb39mqviKqQ9FPtHtqw99tHelvwfVhbUR%2Fnuib0woEl9%2BMfmM6y3cq5Qvgyx3WXaB32lv0vVz2p1GdZP2xTuE6Hb6F11vl4HOZ1hyQGdSFtuqR11fp07QU1dMOMD96vbxkK2%2B4sqyIbkX0K4o%2BO2kzqzcyu2d1ZW%2F%2FvZb1nzbxmvM%2B9L2B05xPbgO7%2B1SuLOzuXezPl8g2I70HfmjXBLPR52nPX942WrJPOOUbBvVi1uNo5ad418dm7IfT5U%2FDXz6Oi%2FjfkfxuZpjhCjRLK50xgSdXin9xqkhvU4m0qqhfDYZ%2BzX3xOtO%2BN6apGeRcJ%2FK%2FsXe7QI00Zz55Ej8Aif83NLlBkK0tbPkemkQSbQPKd8DkXr68qztZL1%2FexYrqobqTz8GKGtlVk6kJ2TgUKWrJjMcGhhn7fE4hanCT1D5sid8nSV9spPtqioqvK3xnoJWgWmLn0uFe5Kih%2Fw3Pym6nbZIOpwXBO%2FC%2FNnMLBn92Cs%2BuyXVT9zZ%2Buj%2BsoWhP3R5KclJDcUlUJvgHsPCaUwdrKEyRgYWPqKPoPDOHc6%2BgPqu8IFRBC2ZbMwqk037Wzbarcj29jbnG961szt0v%2BB9z6e8vWjKcu3x6Z2aECcXc8mCv73RtyrhQeFosKdUVI6N%2FJ8fD%2F0IsYrhqxzTbBQOuCsIhWsGkHi94uu4K4rDnTsbpyb29%2B6xUNnkwoI8FAyq1fzb69%2Fzm5em6328PAcz%2B9Oc7AX5%2B9vBeRcWBtcBgQZU4ONAS6KRicCAE4av74TrQzVVj6jzeL%2BEb1GWNxQOMHi3W%2BNXuN5ZPcYsxjI%2FfZk8DeAO5NZMBLa7NWRXD31ybqDDrWoOHhc2uenG4jFSueVYuu17hW0E2SubEaar91uPNJhRPGSH4hkaxouum%2FzRoLIBG3bieUYAO%2BbR3M%2Bk0G887FLvGQB2XYXtwFWIgjrvBnD7VDgoNlKT%2B6zpwR6k4c8ou7XRdWitfaBtpimqBAYDU51UAIP%2Fp%2Boq0anTaalJUUNy0mDmtXN33XX63q6wbEAp8XICMEPgltyXCqt1WpBwZXM7tQCysRTH%2BjZVESxmiBsPpLHu%2BFQh6W8IAKg9iW2G0CrUjWsui%2FLUWGJrHFxgg5bZcQeUVs0sY5qe1bNUx5E1lWSnHv7FiCUPZoPLuZVStX3WlgkmGHrpU4fukWq9M7eUdyOZdaDcvV3WAtLq%2FFX4Hw%2F2gcu2lay3E3MZygYqoTLK6FtafY9gheCasGrbDVZ2SmFvNGYYrQmUWhgDirQWhkUKJoNKMyfaXexg2COp3KQPCSOVhtyiqNVR04TWGDrqU4ZIsGd4IA8Zc0kbXAjr3sT6zKPiMRSrlHtBMBo6hkDYHnixRGYf1iRRdks4zbJ%2B1fIA6FXkblXcLsoC6YUihmS2D0PQw6A3WR4W%2FOdIsogcG9MLvt5ayf9YbL2%2FwLox4V4mC2dSkkpBHtK1g2CHg4aWknX09w%2FBGQCcZPgnGJYJ0DSOaVyiGJKpieyWvWlgu1nNqd%2BU3WFTnOy7phGlQZ7vRWmD9Wxj0p9zC7yyBbyq0KwqwI0MfPUS0GiAfbyayXAwgJIP2VATQRKzahWMXlsswSA%2FQgLoY%2FgZkEBWgeN%2BqW1gu29BgRbMmKq%2Fv1BbKrmyzhYrIOfSTpZQ%2F4EG1LtMWUD9UPkY0KqNMur7Ngf%2FdIpR%2FJ9thlyS%2FZ2v5lorIyvQW2iKfybBXSGf5fCZpgkpKKOftMqwD8mOIHwxDJft7nH8GcrOwmkDnrotlLG%2BlwtXncgxYwvvYDuTzo4XjAPIX5RVodQltx3c6L9ifoj5VjBWqIJ%2BVeScgWG%2FfLsXfk0pukEkrbgfWl23yyfqGUaAolDPoKVI%2BUX4kz3zgF%2FYN6i7W8jxfyTOGKoNxC4M%2BYZkVGdoLxpk5Bm2SwevKlzSSn%2FullGEYN5AeluxvRL6TrQCGmSOQyt%2Bu83jThWd%2BS86xFSnj8fpABtCqV2COxDlR0jvIUBTDLBQFs0usNRYRb2IT0Z0MYrUyE8XfeStw1LX96g7sCcw1Xa%2BMtVnV4NpWoQSK4fyksQlm6PhLb7R026SzhLy4kqCQjyRNDqieh55JdoPBQQ8vy94%2Bt5szkI4WzhggWS6aPPA%2BEVQOg6jJEQHKn%2BHomgyfJZ%2FDt6hTvlymzS84G11N5CgDo4O9gNFW9t5W0gwCElvx5WjcnIVWF66T5iRs60JgALkwqndl4cigai%2FJ4G%2FQnrtkYDfsJQLagKMhzihzOZov0GRBYOQQS2g%2FyWj%2FPJpRbzAkGQaV4zh74GhmNUZvStHabLAxFuwG7%2FpxuNngHdh0MLLmTGEHQ5hN8t%2Ff25%2FW3qBD5X2Q%2BuyMBX%2FMj9VTUzG2Y6qdegfAIZ49j65UI4Iocd5YIWRwxUzLLSeKzrN0a8fbq%2FeB%2FT453s7xdo63c7yd4%2B0cb%2Bd4O8fbOd7O8XaOt7803v7wQWhhKkxTDc3gJtWIRtUMA6JEMWTzj2Ugmj3vHAHgpDf2vU7%2Bzxs4Qf%2F%2FIC3oRJbnL47TP7zXj2oKMXVu6BpXiQ5APa1FMQ1F5SpuC4RLocf78LbZKKUBBMEUTAWWMnq0%2FZmHhDc4NpA3E1uLqGakT55QJhSStT9GJ0dTPtGM0OM5is9RfI7icxSfo%2FgcxecoPkfxOYrPUXyO4r8niud7EM5%2BFK8putANrlJqMFXP8G4WwZgtgJ5lltzzzhHwTRrEO9Gx%2Bgqg5flXR%2B%2BH8y8%2BW08UVWiqJjQqiErNmPLb6J0rwBpOOGWaCqzOAO8gBCoxNV1wxLbsaOj0kIhux98MT1VF7BrhqRB6hpdTynSFZyg7qA4lHE3Cv6qrghzB5wg%2BR%2FA5gs8RfI7gcwSfI%2FgcwecIPkfwH0Xw6h6c84bPO4UQzVABlAiTU55liEQY8x6Cz37n7%2BMblrbfDgO3N3QGX90z3gd4t7G9A3JnpqrpyD81jkS%2F6%2FeRUF3XuMkM4FKW6R0EgKIICGbolHBdOxp8PwCaHn0PvSBU0fefZdcZAUHe%2BpfuDlQc7Vj7HpHPjfI5pM8hfQ7pc0ifQ%2Foc0ueQPof0OaTPIf2%2FAum1Pdhn%2F1F2NfMoezZs2SQfAbik7bW%2FMU5z3QGIAXBJcwYIl4ftyaskyGFJXxvkH87N%2BKmpaNsn4Uka5H%2FyUfgDIpcf37%2BkoSnbMH03AgYVGQ4DKGVKpjWexN3lCD0gt8bn0D2H7jl0z6F7Dt1z6J5D9xy659A9h%2B7%2FCnTX9%2BCdvdBd1RVmaoaqEVNlBjUz9tMjitkytGceit%2FzzhHwTRoL9oOe10CU%2F9WR%2BuHMi59yoDo1TF1lJlNNjaa1MIaqEInhTUGFQfQMjYxgiipMZujMhCI0frxQg%2Bfg0g7opGi7oYKyQkVQxhSaGSzCiDH9ETw%2BHHDcIAfvOXjPwXsO3nPwnoP3HLzn4D0H7zl4z8H7dwDv4sMu7TR5GF5DX2eEaaaehn8SxgjDNDnRdUH0LOye%2FcoRDgqnA2RNAExPX7%2BbT7sPMDJ%2BCihdEMNkmq5ppqZnBDczmUI0g1GhCU0jmprBSaEphAvTBAxPOCGaeTSfduoBG8SPj%2BSBaiD%2Bf7SxPqM7HG9b%2FSER4vZQ7R02%2FHdibkd1xH0fglDc3GCaLEv5ASQlW1tDjuc1g6UoNZ144%2F95i9lo3Jl89fHhq8emIAdsyMn1VLmeKtdT5XqqXE%2BV66lyPVWup8r1VLmeKtdTfQc91V7Uuf98SIarukzsTY%2FmpU49A09%2B0hVA4twAxVgFWUcHDIVmxtNTj3d6Rv3v7hLeIfp%2FJ92KTrqiU80gJqEmp5SJLIHaQzHdUIjBqUlMg2iGcTxvE2qOinNUnKPiHBXnqDhHxTkqzlFxjopzVJyj4n8FFX%2FYa4JqKqYKkERnnHCdmBm7NySm2TpWQbMwc%2FY7R8A36VAG3%2BHYxV6Q%2BgaOV1ShGiZVBeMqJRmx9AxTIdxgVIOXmKkbWbs1oBRGCPxxIQw9Ro9%2Fn2%2BaluKQ1%2FG92up2NA5fRv5o6PQvN6kJWm7eqY5Gryumdr0wXNSCJRbiTMPRLsv36lEmo%2BnY9d6ocNyTQmfse2%2ByLt4mgM15k3Fjr%2B%2BEwW9vpyJ%2FndJauoOcQMfEdg%2B3UDWO%2FbgtnprCtrfGZO71ONbujo%2FoSQZzH%2Fr2i%2BLMJlzpO4N2x0mMHD8Yv1IN9ER6cJdf8%2BlwBWaahLqmZFDNPBbRtPSOmPJi6AxGleEEmtFYebmZfC%2FvNR%2FgVBwtJSnZJ94ro5lnMCZopqokAsgwoStGVgTkzx0KDhgxjzsUmHuIfM5DQdohdTQUPLx2nNCzv4Vz6g8wZvU04xDn5%2B6KU8%2Bgq5ucK0RPbXpde6ky9PXh1%2B3lgFD0d5cDx7KbaH%2Fd6rRPdD5MTePduSS76x9vwNTSW4i3lwHFbxNaTvuw2zpg1olHgENszEedzfaL%2Fv7pLB1%2F75OnM6od4BbAG3aK4%2FFohkLYdyaTwN2V5F0Z8%2BZB%2BIjX0JDorrV6D6%2FL863Xyov4ZgiN2cqEt63tZ5ts8m6xV54Pxbk0Nle%2FC3RjKX4X525xUc2Q%2FDjtYDi8%2BsKvUQCN26wnqYY29d2pRWX62mFCXFREglXujZikC2Q0XaDQ0wVGlEoVKOVuTYY%2FEcU0yjqFKMLNL28cQHNwtE2Kp%2F5J8hkPZ99V6kydKHRr3ZMoWjP5eq30WfLHD5C%2Foy8hGUuRGeYJRaUmozo1dHWtCT5k%2B41GFIMT3WAGYE5DsOPFIU3Dor2zb779Jt9%2Bk2%2B%2Fybff5Ntv8u03%2BfabfPtNvv0m336Tb7%2F5yttv1sjp8O03QqGC6RrTBTEMbmYcKSCaohmqrhqGQVSq6RnwJvuVI6CbtNHciZS9KZBzrnreD3tFMTkQl2022rAEKKWaoqopn7Mf3IVDFEZ0wjCIjabp4nixSM%2FBZQo1MYjJXpcpjAuFb1E0HfgF5PCTY5HS3CdqDutzWJ%2FD%2BhzW57A%2Bh%2FU5rM9hfQ7rc1j%2Fr8D6j%2FuaYJmxSLNhyyb5CJFK0lu1xp7TKX4x1P7HfDlPF4baOcQUlR5ME8c19m3RZJC6dcorK67o8bZpfyCo6HE2tmkfDmx0Bvu00%2FvatvdqPnwfh6Yf4E58TCNbnE83HBgpFnzCGbmtTV3s0zYdrrrA%2B5sOV0WeyeE6Gp8IOBWLPok%2F8em49%2FnDzos%2FOjlxF%2FqsbZGHMmgdjf5sOJSxmfVMDgITw1U7ptkuGHBVEA7RCib1eMHTdVcQhz13xKF7oP90m6kRn5eNV2ScqYrYmqwS64Vj7wnV%2Bdly7c0zfe%2F3j7gnHZ2lanKRzTlXYIWxL1zl0Vl6gC1wl4NZa7UtbmWsA%2Fcy8AMnahJHyTPjJIrMQAHkeAZB%2FZ9ZqumHOkLQzm2iOYOTkBR3pCf29HOuKxln%2BAxFBr1InAPYhdZUUY9GrQ%2Bg67OycDO7tGPhlvcfsHAvUSccaZytWNss087csk2jv8qOrbYDOcPXNuRIaLDndgntb0W053P7ATXD1jytgb1qWl1ratVvdjW95cvQavoq5BFpzfMVg5pO7aQWGd9roB3Dn1pLH%2B2IHPM3uhVS7V4uamW0a1459XoFym2plfIdQRuKUyIZ34nr5k5vy1cfq1v9YXpbvz%2B0bmj7QQ29vG%2F2pL2GQd1YtdsY2VDn2%2FILs3q%2BTPd6hOzQtemjXXeZtBBg%2FaHsWZrmaL%2B6Q427ite4p8De%2FMY2KhHVoegn2j21y2jDQfpbcH1YGzsBWVjNyznaLuU3o9%2BYzvKdSvkC%2BHKHdYdvN15ucQ8I2gRrsU1Z1ilcp8O38HqrHHwu05oDgnY42kL7Va3IIhtyVE87wPyQ%2FnDJIjteK7LXrexlNpa1gDIybVJ2z%2BrK3r6x1qStBN2ncmVhd3FXguwHRLYZ6T3wQxvtr7wVAj%2BXt42W7BNO%2BYbZaCt9HO1aF7AfJu0MPo6Lf2pdWM9TB2sVhZY1gWSsgPTjTRdpzXXNhRVhMPRr7ovXmfa9cWr%2B%2BFr6xA%2FwZY3aEnN42gb0uQpF48TakE%2FShZiHYj0hzmuJatDT8kfBYO%2FbPFIASr3DJ3mXPBj8B%2FhCHHr%2BfA1Yj849uB2PRuE23kZrkjXqePjG%2FwM%3D)
#### 기술스택
- 데이터베이스: S3(사진 데이터 저장), DynamoDB(나머지 데이터 저장) 
- 서버: Lambda, Cloudwatch Event Rule, Google NLP, API Gateway
- 네트워크: VPC, NAT Gateway Instance(맨처음에는 NAT을 사용하여 구현했으나, 비용문제 때문에 NAT을 중간없앴습니다.)
- 기타: SAM

#### 서버
- SAM(Serverless Application Model을 사용하여 Code로 인프라를 관리하였습니다.)
- Google NLP는 기사를 추천하기 위해서, 기사에서 주요 키워드들을 추출하고, 이 키워드들을 사용해 유저에게 기사를 추천하기 위해서 사용을 했습니다. cloudwatch event rule을 사용하여 매일 하루에 한번씩 람다를 호출하여, 기사를 scraping 하였습니다.
![06_scraping](https://github.com/harryjung0330/dream_project/blob/main/사진/06_scraping.png)
- 람다와 api gateway를 사용해서 서버리스 아키텍쳐를 구현했습니다. 람다의 고질적인 cold start 문제를 해결하기 위해서 cloudwatch event rule을 사용하여 5분주기로 람다들을 호출하여 람다를 warm up 했습니다.
![07_lambda_warm](https://github.com/harryjung0330/dream_project/blob/main/사진/07_warm_lambda.png) 

#### 데이터베이스 
- DynamoDB는 관계형 데이터베이스가 수평확장을 하기에는 적절하지 않고, 단순 Read와 write는 NoSQL 데이터베이스가 더 성능이 좋아서 선택을 했습니다. 
- 데이터를 비정규화 시켜서 read의 성능을 높이려고 노력했습니다. 
- 중복된 데이터를 관리하기 위하여, 하나의 테이블에 데이터가 저장될시에 람다를 호출하여, 중복된 데이터가 저장된 테이블을 업데이트 하였습니다. 
![08_lambda_dupl](https://github.com/harryjung0330/dream_project/blob/main/사진/08_lambda_dupl.png)
- 자세한 내용은 아래링크의 ppt를 참조해주세요.
- 데이터베이스 설명: 
- 데이터베이스 스키마 링크: https://www.erdcloud.com/d/kPj4YF4hdSEpMDRaH
- 사진 파일은 제일 저렴한 S3 저장소에 저장하였습니다.
  
### 팀원
- 정상원: 기획, UI/UX, Mobile development, Backend Development, Database Modeling
