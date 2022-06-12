# 부스터란?
- 부스터란 부동산 스터디의 줄임말로, 부동산 관련 정보를 제공하고, 유저들이 분석한 부동산을 공유하는 기능을 가진 어플리케이션입니다.
- 부스터는 3가지의 주요 기능이 있습니다:
1. 부동산관련 기사 추천
2. 부동산관련 지표 조회
3. 부동산 분석내용 작성 및 공유

### UI
- 부동기사 추천
![01_ui]()
- 부동산 관련 지표 조회
![02_ui]()
- 부동산 분석내요 작성 및 공유
![03_ui]()
- 자세한 내용은 위으 UI pdf 참고
  
### Frontend
- 기술 스택: Flutter, Dart
- 아키텍쳐: MVC architecture
![04_MVC]()
- Repository: Network나 Local Storage(Secure Shared Preference) 등등에서 데이터를 가져옴
- Service: Repository에서 가져온 데이터를 Model로 변환시켜서 앱에서 사용할수 있게함
- Controller: View와 소통하여 View에 필요하 데이터를 제공함

### Backend
![05_system_arch]()  
- 기술스택
- 데이터베이스: S3(사진 데이터 저장), DynamoDB(나머지 데이터 저장) 
- 서버: Lambda, Cloudwatch Event Rule, Google NLP, API Gateway
- 네트워크: VPC, NAT Gateway Instance(맨처음에는 NAT을 사용하여 구현했으나, 비용문제 때문에 NAT을 중간없앴습니다.)
- 기타: SAM
- SAM(Serverless Application Model을 사용하여 Code로 인프라를 관리하였습니다.)
- Google NLP는 기사를 추천하기 위해서, 기사에서 주요 키워드들을 추출하고, 이 키워드들을 사용해 유저에게 기사를 추천하기 위해서 사용을 했습니다.
- DynamoDB는 관계형 데이터베이스가 수평확장을 하기에는 적절하지 않고, 단순 Read와 write는 NoSQL 데이터베이스가 더 성능이 좋아서 선택을 했습니다. 
- 데이터를 비정규화 시켜서 read의 성능을 높이려고 노력했습니다. 
