# sist2ndPrj
sist 쌍용교육센터 2차 프로젝트

모두쉼-고속도로 휴게소 정보 사이트


<p>
<img width="100%" src="https://github.com/user-attachments/assets/756394a1-1f1a-491f-9744-1b52c2ba3116">
</p>

<a id="목차"></a>
## 📌 목차
1. [💻 개요](#-개요)
2. [🚀 프로젝트 목표](#-프로젝트-목표)
3. [📅 개발 기간](#-개발-기간)
4. [🧑‍🤝‍🧑 멤버 구성](#-멤버-구성)
5. [🛠️ 기술 스택](#기술스택)
6. [🏛 아키텍처 구조](#-아키텍처-구조)
7. [🎬 사용자 시연 영상](#-사용자-시연-영상)
8. [🎬 관리자 시연 영상](#-관리자-시연-영상)
9. [ERD Diagram](#ERD-Diagram)

## 💻 개요
> 🔹 **프로젝트명** : 모두쉼
> 
> 🔹 **유형** : Servlet/JSP 기반 고속도로 휴게소 및 주유소 정보 사이트
>
> 🔹 **설명** :
> 
> 운전자와 여행객들이 전국 고속도로 휴게소·주유소의 실시간 정보(맛집/주유소/편의시설)를 제공
> 
> 카카오맵 API를 통한 위치 시각화를 지원
> 
> 운전자와 여행객의 편의를 높이는 것을 목표
> 

## 🚀 프로젝트 목표
> 🔹 실용적이고 직관적인 휴게소 정보 서비스 구현
> 
> 🔹 사용자 친화적인 UI와 안정적인 Java 기반 백엔드 서버 환경 구축
> 
> 🔹 전곡 고속도로 이용자들의 편의성 증대
>
> 🔹 카카오맵 API를 통한 위치 기반 시각화 기능 제공
>
> 🔹 javax.mail + SMTP 기반 이메일 인증
> 
<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>

## 📅 개발 기간
> 2025-4-28 ~ 2025-6-12(7주)
> 


## 🧑‍🤝‍🧑 멤버 구성
> ### 👩‍💻 이여진(조장)\[[GitHub : @yeojinhub\]](https://github.com/yeojinhub)
>
> 🔹 **관리자 계정 관리** : 회원/관리자 계정 CRUD
> 
> 🔹 **관리자 휴게소 관리** : 상세정보·먹거리·주유소 관리 CRUD
>
> ### 👨‍💻강태일(부조장)\[[@tgncosist2\]](https://github.com/tgncosist2)
>
> 🔹 **사용자 회원 기능** : 회원가입, 로그인
> 
> 🔹 **사용자 휴게소 편의시설 정보** : 상세페이지, 먹거리, 리뷰
>
> 🔹 **사용자 노선별 주유소** : 주유소 목록, 가격 조회 및 검색
> 
> ### 👩‍💻김민경\[[@min-7343\]](https://github.com/min-7343)
>
> 🔹 **관리자 로그인**
> 
> 🔹 **관리자 게시판 관리** : 공지사항, FAQ 관리 CRUD
>
> 🔹 **관리자 문의 관리**: 문의글 조회/답변
>
> 🔹 **관리자 리뷰 조회/신고 관리** : 리뷰 조회 및 신고 처리
>
> ### 👨‍💻장태규\[[@taegu825\]](https://github.com/taegu825)
> 
> 🔹 **관리자 대시보드** : 최근 30일 통계/현황 조회
>
> 🔹 **데이터 업데이트** : 한국도로공사 API 연동, 데이터 SQL/엑셀 변환 저장
>
> ### 👨‍💻유명규\[[@RyuMG\]](https://github.com/RyuMG)
>
> 🔹 **사용자 메인페이지** : UI 구현
> 
> 🔹 **사용자 노선별 주유소** : UI 구현
>
> 🔹 **사용자 게시판** : 공지사항, FAQ, 문의글 기능 구현
> 
> ### 👨‍💻이대웅\[[@bkj0517\]](https://github.com/bkj0517)
>
> 🔹 **사용자 마이페이지** : 내 정보, 나의 리뷰, 문의내역, 즐겨찾기 기능 구현
> 
<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>

<a id="기술스택"></a>
## 🛠️ 기술 스택
> ### Front-End
> 
> ![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
> ![CSS](https://img.shields.io/badge/css-%231572B6.svg?style=for-the-badge&logo=css&logoColor=white)
> ![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
> ![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
> 
> ### Back End
>
> ![Java17](https://img.shields.io/badge/java17-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
> ![JSP](https://img.shields.io/badge/jsp-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
> ![Servlet](https://img.shields.io/badge/servlet-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
> ![JSTL](https://img.shields.io/badge/jstl-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
> ![JDBC](https://img.shields.io/badge/jdbc-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
> ![DBCP](https://img.shields.io/badge/dbcp-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
> ![Apache Tomcat9](https://img.shields.io/badge/apache%20tomcat9-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)
> ![Lombok](https://img.shields.io/badge/Lombok-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
> 
> ### DataBase
> 
> ![Oracle DataBase 19c](https://img.shields.io/badge/Oracle%20DataBase%2019c-F80000?style=for-the-badge&logo=oracle&logoColor=white)
>
> ### Environment
> 
> #### IDE ![Eclipse](https://img.shields.io/badge/Eclipse-FE7A16.svg?style=for-the-badge&logo=Eclipse&logoColor=white)
> #### Build tools ![Gradle](https://img.shields.io/badge/Gradle-02303A.svg?style=for-the-badge&logo=Gradle&logoColor=white)
> #### Version control ![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
>
> ### Communication
> 
> ![Discord](https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)
> ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
> ![KakaoTalk](https://img.shields.io/badge/kakaotalk-ffcd00.svg?style=for-the-badge&logo=kakaotalk&logoColor=000000)
> ![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)
> 
<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>

## 🏛 아키텍처 구조
> 🔹 MVC 패턴
> 
> **View(JSP)** → **Controller(Servlet)** → **Service** → **DAO** → **DB**
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↕
>
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DTO** 
>
> 🔹 JDBC + DBCP(JNDI DataSource) 기반 데이터베이스 연동
>
> 🔹 JSTL/EL 기반 데이터 출력
>
<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>

## 🎬 사용자 시연 영상
> ### 사용자 회원가입, 로그인
>
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/fc587377-a7a1-48fb-b69f-7b4cadcce71f">
</p>

> ### 사용자 메인페이지
>
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/b4f0210d-8311-450e-a542-739f8ce46c34">
</p>

> ### 사용자 휴게소 편의시설 정보(상세페이지, 먹거리, 리뷰), 노선별 주유소
>
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/6fc0dc77-88e2-4448-9160-fb71629e1c72">
</p>

> ### 사용자 게시판(공지사항, FAQ)
>
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/2b548c14-1f3c-4313-bbbe-49e0da741f11">
</p>

> ### 사용자 마이페이지(내 정보, 나의 리뷰, 문의내역, 즐겨찾기)
>
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/5a35fa80-fb0c-4de8-8e0e-b3be17dec502">
</p>

<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>

## 🎬 관리자 시연 영상

> ### 관리자 로그인, 대시보드, 계정 관리(회원 계정 관리, 관리자 계정 관리)
>
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/028af59f-0db8-4813-99d0-c54d0e935a61">
</p>

> ### 관리자 게시판 관리(공지사항 관리, FAQ 관리), 문의 관리
>
> <p>
  <img width="80%" src="https://github.com/user-attachments/assets/c4f63136-5c4e-47be-bc34-55fd9c4498f3">
</p>

> ### 관리자 리뷰 조회/신고 관리
>
> <p>
  <img width="80%" src="https://github.com/user-attachments/assets/7aac95f8-4a86-4914-8cc7-e265e35757e9">
</p>

> ### 관리자 휴게소 관리(상세정보 관리, 먹거리 관리, 주유소 관리)
>
> <p>
  <img width="80%" src="https://github.com/user-attachments/assets/ef87e0f9-7f6a-4308-9169-a3af2d54c19e">
</p>

<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>

## ERD Diagram
<p>
  <img width="80%" src="https://github.com/user-attachments/assets/d1db5f9d-0140-432c-9a91-5ec471e0f028">
</p>

<p align="right">
  <a href="#목차">🔝 목차로 돌아가기</a>
</p>


