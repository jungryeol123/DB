/**
* MYSQL : 정형 데이터를 저장하는 데이터베이스
- SQL 문법을 사용하여 데이터를 CRUD한다.
- C(Create : 생성, insert)
- R(Read : 데이터 조회, select)
- U(Update : 수정, update)
- D(Delete : 삭제, delete)  
- 개발자는 DML에 대한 CRUD 명령어를 잘 사용할 수 있어야 한다!!
- SQL은 크게 DDL, DML, DCL, DTL로 구분할 수 있다.
- SQL은 대소문자 구분하지 않음, 보통 소문자로 작성
- snake 방식의 네이밍 규칙을 가짐(소문자_)

1. DDL(Data Definition Language) : 데이터 정의어 alter
 - 데이터를 저장하기 위한 공간을 생성하고 논리적으로 정의하는 언어
 - create, alter, truncate, drop ...

2. DML(Data Manipulation Language) : 데이터 조작어
 - 데이터를 CRUD하는 명령어
 - insert, select, update, delete

3. DCL(Data Control Language) : 데이터 제어어
 - 데이터에 대한 권한과 보안을 정의하는 언어
 - grant, revoke

4. DTL(Data Transaction Language,TCL) : 트랜잭션 제어어
 - 데이터베이스의 처리 작업 단위인 트랜잭션을 관리하는 언어
 - commit, save, rollback
 */

/* 반드시 기억해주세요!! - 워크벤치 실행시 마다 명령어 실행!! */
show databases; 	-- 모든 데이터베이스 조회
use hrdb2019; 		-- 사용할 데이터베이스 오픈
select database();	-- 데이터베이스 선택
show tables; 		-- 데이터베이스의 모든 테이블 조회

/*use market_db;
select database();
show tables;
use hrdb2019;
select database();
show tables;
*/


/******************************************
	DESC(DESCRIBE) : 테이블 구조 확인
	형식> desc(describe) [테이블명];
    
    SELECT : 테이블 내용 조회
    형식> SELECT [컬럼리스트] FROM [테이블명]; 
    
    AS : 컬렴명 별칭 부여 
    형식> select [컬럼명 as 별칭, ...] from [테이블명];
******************************************/ 
show tables;
desc employee;
desc department;
desc unit;
desc vacation;

select EMP_ID, EMP_NAME from EMPLOYEE;
select * from EMPLOYEE;
select EMP_NAME, GENDER, HIRE_DATE from EMPLOYEE;

-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여를 조회
select emp_id, emp_name, gender, hire_date, salary from employee;

-- 부서 테이블의 모든 정보 조회
select * from department;

-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여 컬럼을 조회한 한글 컬럼명으로 출력
select emp_id as "사번", emp_name as "사원명", gender as "성별", hire_date as "입사일", salary as "급여" from employee;

-- 사원테이블의 ID, NAME, GENDER, HDATE, salary 컬럼명으로 출력
select emp_id ID, emp_name NAME, gender, hire_date HDATE, salary from employee;

-- 사원테이블의 사번, 사원명, 부서명, 폰 번호 이메일, 급여, 보너스(급여 * 10%)를 조회
-- 기존의 컬럼에 연산을 수행하여 새로운 컬럼을 생성할 수 있다.
desc employee;
select emp_id, emp_name, dept_id, phone, email, salary ,salary * 0.1 as bonus from employee;

-- 현재 날짜를 조회 : curdate()
select curdate() as DATE from dual;


/******************************************
	select : 테이블 내용 상세 조회
    형식> select [컬럼리스트]
		from [테이블명]
        where[조건절];
******************************************/

-- 정주고 사원의 정보를 조회
select * from employee where emp_name = "정주고"; -- ''사용 가능

-- SYS 부서에 속한 모든 사원을 조회
select * from employee where dept_id = "sys";

-- 사번이 S0005인 사원의 사원명, 성별, 입사일, 부서아이디, 이메일, 급여를 조회
select emp_name, gender, hire_date, dept_id, email, salary 
from employee 
where emp_id = "S0005";

-- sys 부서에 속한 모든 사원들을 조회, 단 출력되는 emp_id 컬럼은 '사원번호' 별칭으로 조회
select emp_id as '사원번호' , emp_name, eng_name, gender, hire_date, salary 
from employee
where dept_id = "sys";

-- emp_name '사원명' 별칭 수정

select emp_id as '사원번호' , emp_name as '사원명' , eng_name, gender, hire_date, salary 
from employee
where dept_id = "sys";

-- !! where 조건절 컬럼으로 별칭을 사용할 수 있을까??
-- 사원명이 홍길동인 사원을 별칭으로 조회??      * 칼럼리스트는 제일 마지막에 생성되므로 where 조건절에는 별칭을 사용 불가
-- select emp_id as '사원번호' , emp_name as '사원명' , eng_name, gender, hire_date, salary 
-- from employee
-- where 사원명 = "홍길동";

-- 전략기획 부서의 모든 사원들의 사번, 사원명, 입사일, 급여를조회
select * from department;
select emp_id, emp_name, hire_date, salary, dept_id
from employee 
where dept_id = 'stg';

-- 입사일이 2014년 8월 1일인 사원들을 조회
select * from employee where hire_date = '2014-08-01';   -- DATE 타입은 표현은 문자열처럼, 처리는 숫자처럼

-- 급여가 5000인 사원들을 조회
select * from employee where salary = 5000;

-- 성별이 남자인 사원들을 조회
select * from employee where gender = 'm';

-- 성별이 여자인 사람들을 조회
select * from employee where gender = 'F';

-- NULL : 아직 정의되지 않은 미지수
-- 숫자에서는 가장 큰 수로 인식, 논리적인 의미를 포함하고 있으므로 등호(=)로는 검색 X, IS 키워드와 함께 사용 O

-- 급여가 NULL인 값을 가진 사원들을 조회
select * from employee 
where salary is null;

-- 영어이름이 정해지지 않은 사워들을 조회
select * from employee
where eng_name is null;

-- 퇴사하지 않은 사람들의 보너스 칼럼(급여 * 20%)을 추가하여 조회, 컬럼명은 bonus
select emp_id, emp_name, eng_name,gender , hire_date, retire_date, dept_id, phone, email, salary, salary*0.2 as bouns from employee
where retire_date is null;

-- 퇴사한 사원들의 사번, 사원명, 이메일, 폰번호, 급여를 조회
select emp_id, emp_name, email, phone, salary, retire_date 
from employee
where retire_date is not null;

-- IFNULL함수 : NULL 값을 다른 값으로 대체하는 방법
-- 형식> IFNULL(NULL을포함하는컬럼명,대체값)
-- sys부서에 속한 사원들의 정보 조회, 단, 급여가 null인 사원은 0으로 치환
select emp_id, emp_name, email, phone, ifnull(salary ,0) as salary 
from employee
where dept_id = 'stg';

-- 사원 전체 테이블의 내용을 조회, 단 영어이름 정해지지 않은  사원들은 'smith' 이름으로 치환
select emp_id, emp_name, ifnull(eng_name,'smith') as eng_name, hire_date, salary
from employee;

-- MKT 부서의 사원들을 조회, 재직중인 사원들의 retire_date 컬럼은 현재 날짜로 치환
select emp_id, emp_name, hire_date,ifnull(retire_date, curdate() )as 'retire_date', dept_id, salary
from employee
where dept_id = 'MKT';

/******************************************
	DISTINCT : 중복된 데이터를 배제하고 조회
    형식> SELECT DISTINCT [컬럼리스트]~
******************************************/

-- 사원테이블의 부서리스트 조회   
select distinct dept_id from employee;
-- 주의!! UNIQUE한 컬럼과 함께 조회하는 경우 distinct가 적용되지 않음
select distinct emp_id, dept_id from employee;

/******************************************
	ORDER BY 컬럼 : 데이터 정렬
    형식> select [컬럼리스트]
			from[테이블]
            where[조건절]
		order by [컬럼명, ...] asc/desc
******************************************/

-- 급여를 기준으로 오름차순 정렬해 주세요
select *
from employee
order by salary asc; -- asc 생략 가능

select *
from employee
order by salary desc;

-- 모든 사원을 기준으로 급여, 성별을 기준으로 오름차순 정렬 
select *
from employee
order by salary, gender;

-- eng_name이 null인 사원들을 입사일 기준으로 내림차순 정렬
select *
from employee
where eng_name is null
order by hire_date desc;

-- 퇴직한 사원들을 급여 기준으로 내림차순 정렬
select *
from employee
where retire_date is not null
order by salary desc;

-- 퇴직한 사원들을 급여 기준으로 내림차순 정렬, salary 컬럼을 '급여' 별칭으로 치환
-- 급여 별칭으로 order by가 가능할까?? :: 별칭으로 order by 가능
-- where 조건절 데이터 탐색 > 컬럼리스트 > 정렬
select emp_id, emp_name, dept_id, hire_date, retire_date, salary as '급여'
from employee
where retire_date is not null
order by 급여 desc;

-- 정보시스템(SYS) 부서 사원들 중 입사일이 빠른 순서, 급여를 많이 받는 순서로 정렬
-- hire_date, salary 컬럼은 입사일, 급여 별칭으로 컬럼리스트 생성 후 정렬
select emp_id, emp_name, hire_date as '입사일', dept_id, salary as '급여'
from employee
where dept_id = 'sys'
order by '입사일','급여'desc;

/******************************************
	조건절 + 비교연산자 : 특정 범위 혹은 데이터 검색
    형식> select [컬럼리스트]
			from[테이블]
            where[조건절]
		order by [컬럼명, ...] asc/desc
******************************************/
-- 급여가 5000 이상인 사원들을 조회, 급여를 오름차순 정렬
select * 
from employee
where salary >= 5000
order by salary;

-- 입사일이 2017-01-01 이후 입사한 사원들을 조회
select *
from employee
where hire_date >= '2017-01-01'; 

-- 입사일이 2015-01-01 이후이거나, 급여가 6000 이상인 사원들을 조회
-- ~이거나, ~또는 : or - 두개의 조건중 하나만 만족해도 조회가능

select *
from employee
where hire_date >= '2015-01-01' or salary >= 6000;

-- 입사일이 2015-01-01 이후이고, 급여가 6000 이상인 사원들을 조회
-- ~이고 : and - 두개의 조건중 모두 만족해야 조회가능

select *
from employee
where hire_date >= '2015-01-01' and salary >= 6000;

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
select *
from employee
where hire_date >= '2015-01-01' and hire_date <= '2017-12-31'
order by dept_id asc;

-- 급여가 6000 이상 8000 이하인 사원들을 모두 조회
select *
from employee
where salary >= 6000 and salary <=8000
order by salary;

-- MKT 부서의 사원들의 사번, 사원명, 입사일, 이메일, 급여, 보너스(급여의 20%) 조회
-- 급여가 NULL인 사원의 보너스는 기본 50
-- 보너스가 1000 이상인 사원 조회
-- 보너스가 높은 사원 기준으로 정렬
select emp_id, emp_name, dept_id, hire_date, email, salary, ifnull(salary * 0.2,50) as bonus
from employee
where salary*0.2 >= 1000 and dept_id = 'MKT'
order by bonus desc;

-- 사원명이 '일지매', '오삼식', '김삼순' 인 사원들을 조회
select *
from employee
where emp_name = '일지매' or emp_name = '오삼식' or emp_name = '김삼순';

/******************************************
	논리합(AND) : BETWEEN ~ AND
    형식> select [컬럼리스트]
			from[테이블]
            where [컬럼명] BETWEEN 값1 AND 값2
		order by [컬럼명, ...] asc/desc
        
	논리합(OR) : IN
    형식> select [컬럼리스트]
			from[테이블]
            where [컬럼명] IN (값1,값2,값3...);
******************************************/

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
select *
from employee
where hire_date between '2015-01-01' and  '2017-12-31'
order by dept_id asc;

-- 급여가 6000 이상 8000 이하인 사원들을 모두 조회
select *
from employee
where salary between 6000 and 8000
order by salary;

-- IN
-- 사원명이 '일지매', '오삼식', '김삼순' 인 사원들을 조회
select *
from employee
where emp_name in('일지매' ,'오삼식' ,'김삼순');

-- 부서아이디가 MKT, SYS, STG 에 속한 모든 사원 조회
select *
from employee
where dept_id in ('MKT','SYS','STG')
order by dept_id;

/******************************************
	특정 문자열 검색 : 와일드 문자(%,_) + LIKE 연산자
					% : 전체, _ : 한글자
    형식> select [컬럼리스트]
			from[테이블]
            where [컬럼명] LIKE '와일드 문자 포함 검색어';
******************************************/

-- '한'씨 성을 가진 모든 사원을 조회
select *
from employee
where emp_name like '한%';

-- 영어이름이 'f' 로 시작하는 모든 사원을 조회
select *
from employee
where eng_name like 'f%';

-- 이메일 이름 중 두번째 자리에 'a'가 들어가는 모든 사원을 조회
select *
from employee
where email like '_a%';

-- 이메일 아이디가 4자리인 모든 사원을 조회
select *
from employee
where email like '____@%';

/******************************************
	내장함수 : 숫자함수, 문자함수, 날짜함수
    호출되는 위치 - {컬럼리스트}, [조건절의 컬럼명]
******************************************/
-- [숫자함수]
-- 함수 실습을 위한 테이블 : DUAL 테이블
-- (1) abs(숫자) : 절댓값
select abs(100), abs(-100) from dual;
-- (2) floor(숫자), truncate(숫자, 자리수) : 소수점 버리기
select floor(123.456), truncate(123.456,2) ,truncate(123.456,-2) from dual;
-- 사원테이블의 sys 부서 사원들의 사번, 사원명, 부서아이디, 폰번호, 급여, 보너스(급여의 25%) 컬럼을 추가하여 조회
-- 보너스 컬럼은 소수점 1자리로 출력
select emp_id, emp_name, dept_id, phone, salary, truncate(salary * 0.25,1) as bonus
from employee
where dept_id = 'sys';

-- (3) RAND() : 임의의 수를 난수로 발생시키는 함수, 0~1 사이의 난수 생성
select rand() from dual;
-- 정수 3자리 난수 발생
select truncate(rand()*1000,0) from dual; -- 정수 3자리 (0~ 999) 난수 발생
-- 정수 4자리 (0~9999) 난수 발생, 소수점 2자리
select truncate(rand()*10000,2) from dual;

-- (4) mod(숫자, 나누는 수) : 나머지 함수
select mod(123,2) as odd , mod(124,2) as even from dual;

-- 3자리 수를 랜덤으로 발생시켜, 2로 나눈 후 홀수, 짝수를 구분
select truncate(mod(rand()*1000,2),0);

-- [문자함수]
-- (1) concat : 문자열 합쳐주는 함수
select concat('안녕하세요!', '홍길동','입니다') as str from dual;

-- 사번, 사원명, 사원명2 컬럼을 생성하여 조회
-- 사원명2 컬럼의 데이터 형식은 S0001(홍길동) 출력
select emp_id, emp_name ,concat(emp_id, '(', emp_name ,')') as '사원명2' 
from employee;

-- 사번, 사원명, 영어이름, 입사일, 폰번호, 급여를 조회
-- 영어이름의 출력 형식을 '홍길동/hong' 타입으로 출력
-- 영어이름이 null인 경우에는 'smith'를 기본으로 조회

select emp_id, emp_name, concat(emp_name, '/', ifnull(eng_name,'smith'),'/') as '영어이름', hire_date, phone, salary
from employee;

-- (2) substring(문자열, 위치, 갯수) : 문자열 추출, 공백도 하나의 문자로 인식
select substring('대한민국 홍길동', 1, 4) from dual; 
-- 홍길동만 출력
select substring('대한민국 홍길동', 6, 3) from dual;

-- 사원데이블의 사번, 사원명, 입사년도, 입사월, 입사일, 급여
select emp_id, emp_name, substring(hire_date, 1, 4) as 입사년도,  substring(hire_date, 6, 2) as 입사월, substring(hire_date, 9, 2) as 입사일
from employee;
-- 2015년도에 입사한 모든 사원 조회
select *
from employee
where substring(hire_date,1,4) = '2015';

-- 2018년도에 입사한 정보시스템(sys) 부서 사원 조회

select *
from employee
where substring(hire_date,1,4) = '2018' and dept_id = 'sys';

-- (3) left(문자열, 갯수), right(문자열, 갯수) : 왼쪽, 오른쪽 기준으로 문자열 추출
select left(curdate(),4) as year, right('010-1234-5678',4) as phone from dual;

-- 2018년도에 입사한 모든 사원 조회
select *
from employee
where left(hire_date,4) = '2018';

-- 2025년부터 2017년 사이에 입사한 모든 사원 조회
select *
from employee
where left(hire_date,4) between '2017' and '2025';

-- 사원번호, 사원명, 입사일, 폰번호, 급여를 조회
-- 폰번호는 마지막 4자리만 출력
select emp_name, emp_id, hire_date, right(phone,4), salary
from employee;

-- (4) upper(문자열), lower(문자열) : 대문자나 소문자로 변환
select upper('welcomeToMySQL!!'), lower('welcomeToMySQL!!') from dual;

-- 사번, 사원명, 영어이름, 부서아이디, 폰번호, 이메일, 급여를 조회
-- 영어 이름은 전체 대문자, 부서아이디 소문자, 이메일 대문자 조회
select emp_id, emp_name, upper(eng_name), lower(dept_id), phone, upper(email), salary
from employee;

-- (5) trim() : 공백 제거
select trim('             대한민국') as t1,
	   trim('대한민국             ') as t2,
       trim('대한             민국') as t3,
       trim('       대한민국      ') as t4
from dual;

-- (6) format(문자열, 소수점자리) : 문자열 포맷
select format(123456, 0 ) as format from dual;
select format('123456', 0 ) as format from dual;

-- 사번, 사원명, 입사일, 폰번호, 급여, 보너스(급여의 20)
-- 급여, 보너스는 소수점 없이 3자리 콤마로 구분하여 출력
-- 급여가 null인 경우 기본값 0
-- 2016년부터 2017년  사이에 입사한 사원
-- 사번 기준으로 내림차순 정렬
select emp_id, emp_name, hire_date, phone, format(ifnull(salary,0),0), format(ifnull(salary*0.2 ,0),0) as bonus
from employee
where left(hire_date,4) between '2016' and '2017'
order by  emp_id desc;

-- [날짜함수]
-- curdate() : 현재 날짜(년, 월, 일)
-- sysdate(), now() : 현재 날짜(년, 월, 일, 시, 분, 초)
-- 날짜는 date 타입
select curdate(), sysdate(), now() from dual; 

-- [형변환 함수]
-- cast(변환하고자하는 값 as 데이터 타입)
-- convert(변환하고자하는 값 as 데이터 타입) ; MySQL에서 지원하는 old 버전
select 1234  as number, cast(1234 as char) as string from dual;
select '1234' as string, cast('1234' as signed integer) as number from dual;
select '20250723' as string, cast('20250723' as date) as date from dual;
select now(), 
		cast(now() as char) as string,
        cast(cast(now() as char) as date) as date ,
        cast(cast(now() as char) as datetime) as datetime,
        cast(curdate() as datetime) as curdatetime
        from dual;

select '12345' as string,
		cast('12345' as signed integer) as cast_int,
        cast('12345' as unsigned integer) as cast_int,
        cast('12345' as decimal(10,2)) as cast_decimal
from dual;

-- [문자 치환 함수]
-- replace(문자열, old, new)
select '홍-길-동' as old, replace('홍-길-동', '-' , ',') as new from dual;

-- 사원테이블의 사번, 사원명, 입사일, 퇴사일, 부서아이디, 폰번호, 급여를 조회
-- 입사일, 퇴사일, 출력 '-' 을 '/'로 치환하여 출력
-- 재직중인 사원은 현재 날짜를 출력
-- 급여 출력시 3자리 콤마(,) 구분
select emp_id, emp_name, 
	replace(hire_date,'-','/') as hire_date, 
    replace(ifnull(retire_date,curdate()), '-','/') as retire_date , 
    dept_id, 
    phone, 
    format(salary,0) as salary
from employee;

-- '20150101' ~ '20171231' 사이에 입력된 날짜를 기준으로 해당 날짜 이후에 입사한 사원들을 모두 조회
-- 모든 mysql 데이터베이스에서 적용 가능한 형태로 작성
select *
from employee
where hire_date between cast('20150101' as date) and cast('20171231' as date);

/******************************************
그룹(집계)함수 : sum(), avg(), min(), max(), count() ...
group by - 그룹함수를 적용하기 위한 그룹핑 컬럼 정의
having - 그룹함수에서 사용하는 조건절
** 그룹함수는 그룹핑이 가능한 반복된 데이터를 가진 컬럼과 사용 O
******************************************/
-- (1) sum(숫자) : 전체 총합을 구하는 함수
-- 사원들 전체의 급여 총액을 조회, 3자리 구분, 마지막 '만원' 표시
select concat(format(sum(salary),0),'만원')as 총급여 from employee;

select emp_id, sum(salary) 
from employee
group by emp_id;

-- (2) avg(숫자) : 전체 평균을 구하는 함수
-- 사원들 전체의 급여 평균을 조회, 3자리 구분, 마지막 '$' 표시
-- 소수점은 절삭
select concat('$',format(avg(salary),0)) as avg from employee;

-- 정보시스템(sys) 부서 전체의 급여 총액과 평균을 조회
-- 3자리 구분, 마지막 '만원' 표시
select concat(format(sum(salary),0 ), '만 원')as 총급여, concat(format(avg(salary),0),'만 원') as 평균급여
from employee
where dept_id = 'sys';

-- (3) max(숫자) : 최대값 구하는 함수
-- 가장 높은 급여를 받는 사원의 급여를 조회
select max(salary)
from employee;

-- (4) min(숫자) : 최소값 구하는 함수
-- 가장 낮은 급여를 받는 사원의 급여를 조회
select min(salary)
from employee;

-- 사원들의 총급여, 평균급여, 최대급여, 최소급여를 조회
select format(sum(salary),0) as 총급여,
	   format(avg(salary),0) as 평균급여,
	   format(max(salary),0) as 최대급여,
	   format(min(salary),0) as 최소급여
       from employee;

-- (5) count(컬럼) : 조건에 맞는 데이터의 row 수를 조회, null은 제외
-- 전체 row count
select count(*) from employee;
-- 급여 컬럼의 row count
select count(salary) from employee;

-- 재직중인 사원 row count
select (count(*) -count(retire_date)) as 재직사원
from employee;

-- 퇴사한 사원 row count
select count(retire_date) as 퇴사자
from employee;

-- '2015'년도에 입사한 입사자 수
-- select count( left(hire_date, 4 ) = '2015' ) as '2015입사자 수'
-- from employee;
select count(*)
from employee
where left(hire_date, 4 ) = '2015';

-- 정보시스템(sys) 부서의 사원수
select count(*)
from employee
where dept_id = 'sys';

-- 가장 빠른 입사자, 가장 늦은 입사자를 조회 : max(), min() 함수를 사용
select max(hire_date), min(hire_date)
from employee;

-- 가장 빨리 입사한 사람의 정보를 조회 : 서브쿼리로 그룹함수 사용!! 
select *
from employee
where hire_date = (select min(hire_date) from employee);

-- [group by] : 그룹함수와 일반컬럼을 함께 사용할 수 있도록 함
-- ~별 그룹핑이 가능한 컬럼으로 쿼리를 실행
-- 부서별 총급여, 평균급여, 사원수, 최대급여, 최소급여
select dept_id, sum(salary), format(avg(salary),0) ,count(*) , max(salary), min(salary)
from employee
group by dept_id;

-- 연도별 총급여, 평균급여, 사원수, 최대급여, 최소급여
select left(hire_date,4) as 연도 ,
 format(sum(salary),0) as 총급여,
 format(avg(salary),0) as 평균급여,
 count(*) as 사원수, 
 format(max(salary),0) as 최대급여,
 format(min(salary),0) as 최소급여
from employee
group by left(hire_date,4);

-- [Having 조건절] : 그룹함수를 적용한 결과에 조건을 추가
select left(hire_date,4) as 연도 ,
 format(sum(salary),0) as 총급여,
 format(avg(salary),0) as 평균급여,
 count(*) as 사원수, 
 format(max(salary),0) as 최대급여,
 format(min(salary),0) as 최소급여
from employee
group by left(hire_date,4) 
having sum(salary) >= 15000;

-- 부서별 총급여, 평균급여를 조회
-- 부서의 총급여가 30000 이상인 부서만 출력
-- 급여 컬럼의 null은 제외
select dept_id, 
format(sum(salary),0) 총급여, 
format(avg(salary),0) 평균급여
from employee
where salary is not null
group by dept_id
having sum(salary) >= 30000;

-- 연도별 총급여, 평균급여, 사원수, 최대급여, 최소급여
-- 총급여가 30000 이상인 년도 출력
-- 급여 협상이 안된 사원은 제외
select left(hire_date,4) as 연도 ,
 format(sum(salary),0) as 총급여,
 format(avg(salary),0) as 평균급여,
 count(*) as 사원수, 
 format(max(salary),0) as 최대급여,
 format(min(salary),0) as 최소급여
from employee
where salary is not null
group by left(hire_date,4)
having sum(salary) >= 30000;

-- rollup 함수 : 리포팅을 위한 함수
-- 부서별 사원수, 총급여, 평균급여 조회
select dept_id,
count(*) 사원수,
sum(ifnull(salary,0)) 총급여,
avg(ifnull(salary,0)) 평균급여
from employee
group by dept_id with rollup;

-- rollup한 결과의 부서아이디를 추가
select if(grouping(dept_id), '부서총합계', ifnull(dept_id,'-')) as 부서명, 
count(*) 사원수,
sum(ifnull(salary,0)) 총급여,
avg(ifnull(salary,0)) 평균급여
from employee
group by dept_id with rollup ;

-- [limit] : 출력갯수 제한 함수
select * from employee
limit 3;

-- 급여 기준 5순위 출력
select *
from employee
order by salary desc 
limit 5;

/******************************************
	조인(Join) : 두 개 이상의 테이블을 연동해서 sql 실행
    ERD(Endtity Relation Diagram) :데이터베이스 구조도(설계도)
    - 데이터 모델링 : 정규화 과정
    
    ** ANSI SQL : 데이터베이스 시스템들의 표준 SQL
    조인(Join) 종류
    1) cross JOIN(CATEISIAN) - 합집합 : 테이블들의 데이터 전체를 조인 - 테이블A(10) * 테이블B(10)
    2) INNER JOIN(NATURAL) - 교집합 : 두 개이상의 테이블을 조인 연결 고리를 통해 조인 실행
    3) OUTER JOIN - INNER JOIN + 선택한 테이블의 조인 제외 ROW 포함
    4) SELF JOIN : 한 테이블을 두 개 테이블처럼 조인해서 실행 
******************************************/
use hrdb2019;
select database();
select * from employee;
select * from department;

-- cross join
select *
from employee, department;

select count(*)
from employee cross join department;

--
select count(*) from vacation; -- 102
-- 사원, 부서, 휴가 테이블 cross join : 20 * 7 * 102
select count(*) from employee, department, vacation;
select count(*) from employee cross join department cross join vacation;

-- inner join
select *
from employee, department
where employee.dept_id = department.dept_id
order by emp_id;

-- inner join : ansi
select *
from employee inner join department
on employee.dept_id = department.dept_id
order by emp_id;

-- 사원테이블, 부서테이블, 본부테이블 inner join
select *
from employee e, department d, unit u
where e.dept_id = d.dept_id
and d.unit_id = u.unit_id
order by e.emp_id;

-- 사원테이블, 부서테이블, 본부테이블 inner join : ansi
select *
from employee e inner join department d 
on e.dept_id = d.dept_id
inner join unit u
on d.unit_id = u.unit_id
order by emp_id;

-- 사원테이블, 부서테이블, 본부테이블, 휴가테이블 inner join : ansi
select *
from vacation v inner join employee e
on v.emp_id = e.emp_id
inner join department d
on e.dept_id = d.dept_id
inner join unit u
on d.unit_id = u.unit_id;

select *
from  employee e, department d, unit u ,vacation v
where e.dept_id = d.dept_id
	and d.unit_id = u.unit_id
    and e.emp_id = v.emp_id;

-- 모든 사원들의 사번, 사원명, 부서아이디, 부서명, 입사일, 급여를 조회
select e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.hire_date, e.salary
from employee e, department d
where e.dept_id = d.dept_id
order by emp_id;

-- 영업부에 속한 사원들의 사번, 사원명, 입사일, 퇴사일, 폰번호, 급여, 부서아이디, 부서명 조회

select e.emp_id, e.emp_name, e.hire_date, e.retire_date, e.phone, e.salary, e.dept_id, d.dept_name
from employee e, department d
where e.dept_id = d.dept_id
	and d.dept_name = '영업';

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들의 내역을 조회

select *
from employee e, vacation v, department d
where e.emp_id = v.emp_id
and d.dept_id = e.dept_id
and dept_name = '인사';

-- 영업부서 사원의 사원명, 폰번호, ,부서명, 휴가사용 이유 조회
-- 휴가 사용 이유가 '두통'인 사원, 소속본부 조회
select e.emp_name, e.phone, d.dept_name, v.reason, u.unit_name
from employee e, department d, unit u, vacation v
where e.dept_id = d.dept_id and u.unit_id = d.unit_id and e.emp_id = v.emp_id
and d.dept_name = '영업'
and reason = '두통';

-- 2014년부터 2016년까지 입사한 사원들 중에서 퇴사하지 않은 사원들의
-- 사원아이디, 사원명, 부서명, 입사일, 소속본부를 조회
-- 소속본부 기준으로 오름차순 정렬

select e.emp_id, e.emp_name, d.dept_name, e.hire_date, u.unit_name
from employee e, department d, unit u
where e.dept_id = d.dept_id and d.unit_id = u.unit_id
and e.retire_date is null
and left(ifnull(hire_date,0),4) between '2014' and '2016'
order by u.unit_name;

-- 부서별 총급여, 평균급여, 총휴가사용일수를 조회
select d.dept_name 부서명,
 concat(format(sum(e.salary),0),' 만원') 총급여, 
 concat(format(avg(e.salary),2),' 만원') 평균급여, 
 sum(duration) 횟수
from employee e, department d, vacation v
where e.dept_id = d.dept_id and e.emp_id = v.emp_id
group by e.dept_id, d.dept_name;


-- 본부별, 부서의  휴가사용 일수
select u.unit_name, d.dept_name, d.dept_id, sum(duration) as 휴가사용일수
from employee e, department d, vacation v, unit u
where e.dept_id = d.dept_id
	and e.emp_id = v.emp_id
    and d.unit_id = u.unit_id
group by d.dept_id, d.dept_name, u.unit_name;   

-- outer join : inner join + 조인에서 제외된 row(테이블별 지정)
-- 오라클 형식의 outer join은 사용불가, ansi sql 형식만 사용가능!!
-- select [컬럼리스트] from [테이블명1 테이블별칭] left/right outer join 테이블명2 [테이블별칭],...]
-- on [테이블명1.조인컬럼 = 테이블명2.조인컬럼]

-- 오라클 형식 outer join (mysql에서는 사용불가!!)
-- select * from table1 t1, table2 t2
-- where t1.col = t2.col(+);

-- 모든 부서의 부서아이디, 부서명, 본부명을 조회
select d.dept_id, d.dept_name, u.unit_name
from department d
	 left outer join unit u 
on d.unit_id = u.unit_id;

-- 본부별, 부서의 휴가사용 일수 조회
-- 부서의 누락없이 모두 출력
select u.unit_name, d.dept_name, d.dept_id ,count(duration)
from department d
     left outer join employee e
     on d.dept_id = e.dept_id
     left outer join vacation v
	 on e.emp_id = v.emp_id
     left outer join unit u
     on u.unit_id = d.unit_id
group by u.unit_name, d.dept_id, d.dept_name
order by unit_name;


select  u.unit_name, d.dept_name, count(duration)
from employee e left outer join vacation v
	on e.emp_id = v.emp_id
    right outer join department d
    on e.dept_id = d.dept_id
    left outer join unit u 
    on d.unit_id = u.unit_id
group by u.unit_name, d.dept_name
order by u.unit_name;

-- 2017년부터 2018년도까찌 입사한 사원들의 사원명, 입사일, 연봉, 부서명을 조회
-- 단, 퇴사한 사원들 제외
-- 소속본부를 모두 조회
select e.emp_name , e.hire_date , ifnull(e.salary ,0), d.dept_name , ifnull(u.unit_name, '제-본부') as unit_name
from employee e 
	inner join department d
on e.dept_id = d.dept_id
	left outer join unit u
on d.unit_id = u.unit_id
where left(hire_date ,4) between '2017' and '2018' and retire_date is null; 
 
-- self join : 자기 자신의 테이블을 조인
-- self join은 서브쿼리 형태로 실행하는 경우가 많음!!
-- select [컬럼리스트] from [테이블1], [테이블2] where [테이블1.컬럼명] = [테이블2.컬럼명]
-- 사원테이블을 self join
select e.emp_id , e.emp_name, m.emp_id, m.emp_name
from employee e, employee m
where e.emp_id = m.emp_id;

-- 서브쿼리를 사용한 경우
select emp_id , emp_name
from employee 
where emp_id = (select emp_id from employee where emp_name = '홍길동');

/******************************************
	서브쿼리(SubQuery) : 메인 쿼리에 다른 쿼리를 추가하여 실행하는 바익
    형식 : select [컬럼리스트 : (스칼라서브쿼리)]
			from [테이블명 : (인라인뷰)]
            where [조건절 : (서브쿼리)]
******************************************/
use hrdb2019;
select database();
show tables;

-- [서브쿼리]
-- 정보시스템 부서의 사원들을 조회
-- 사번, 사원명, 부서아이디, 부서명, 급여, 폰번호
select emp_id, emp_name, dept_id ,phone, salary
from employee
where dept_id = (select dept_id from department where dept_name = '정보시스템');

select dept_id from department where dept_name = '정보시스템';

-- [스칼라서브쿼리]
-- 정보시스템 부서의 사원들을 조회
-- 사번, 사원명, 부서아이디, 부서명(부서테이블), 급여, 폰번호
select emp_id, 
	   emp_name, 
       dept_id ,
	   (select dept_name from department where dept_name = '정보시스템') as dept_name,
       phone, 
       salary
from employee
where dept_id = (select dept_id from department where dept_name = '정보시스템');

-- 홍길동 사원이 속한 부서명을 조회
-- '=' 로 조건절 비교하는 경우 :: 단일행 서브쿼리
select dept_name
from department
where dept_id = (select dept_id from employee where emp_name = '홍길동');

-- 홍길동 사원의 휴가사용 내역을 조회
select *
from vacation
where emp_id = (select emp_id from employee where emp_name = '홍길동');

-- 제3본부에 속한 모든 부서를 조회
select *
from department
where unit_id = (select unit_id from unit where unit_name = '제3본부');

-- 급여가 가장 높은 사원의 정보를 조회
select *
from employee
where salary = (select max(salary) as salary from employee );

-- 급여가 가장 낮은 사원의 정보를 조회
select *
from employee
where salary = (select min(salary) from employee );

-- 가장 빨리 입사한 사원의 정보 조회
select *
from employee
where hire_date = (select min(hire_date) from employee);

-- 가장 늦게 입사한 사원의 정보 조회
select *
from employee
where hire_date = (select max(hire_date) from employee);

-- [서브쿼리 : 다중행 - IN] 
-- '제3본부'에 속한 모든 사원 정보 조회

select *
from employee
where dept_id in (select dept_id from department where unit_id = (select unit_id from unit where unit_name = '제3본부'));

-- 제3본부에 속한 모든 사원들의 휴가 사용 내역 조회
select *
from vacation
where emp_id in (select emp_id from employee where dept_id in (select dept_id from department where unit_id = (select unit_id from unit where unit_name = '제3본부'))
);

-- [인라인 뷰 : 메인쿼리의 데이블 자리에 들어가는 서브쿼리 형식]
-- [휴가를 사용한 사원정보만!!] 
-- 사원별 휴가사용 일수를 그룹핑하여, 사원아이디, 사원명, 입사일, 연봉, 휴가사용일수를 조회해주세요
select e.emp_id, e.emp_name, e.hire_date, e.salary, v.duration
from employee e, (select emp_id, sum(duration) as duration 
from vacation
group by emp_id
) as v
where e.emp_id = v.emp_id;

select emp_id, sum(duration) as duration 
from vacation
group by emp_id;

-- [휴가를 사용한 사원정보 + 사용하지 않은 사원정보만!!] 
-- 사원별 휴가사용 일수를 그룹핑하여, 사원아이디, 사원명, 입사일, 연봉, 휴가사용일수를 조회해주세요
-- 사용일수 기준 내림차순 정렬
-- 휴가를 사용하지 않은 사원은 기본값 0
select e.emp_id, e.emp_name, e.hire_date, e.salary, ifnull(v.duration,0) duration
from employee e left outer join  (select emp_id, sum(duration) as duration 
from vacation
group by emp_id
) as v
on e.emp_id = v.emp_id
order by duration desc;

select emp_id, sum(duration) as duration 
from vacation
group by emp_id;

-- 1) 2016 ~ 2017년도 입사한 사원들의 정보 조회
-- 2) 1번의 실행 결과와 vacation 테이블을 조인하여 휴가사용 내역 출력
-- 3) 인라인뷰 형태로 조회
select *
from employee ,(select duration from vacation) as d 
where left(hire_date,4) between '2016' and '2017';

select *
from vacation v, ( select * from employee where left(hire_date,4) between  '2016' and '2017') as e
where  v.emp_id = e.emp_id;

-- 1) 부서별 총급여, 평균급여를  구하여 30000 이상인 부서의 테이블 조회
-- 2) 1번의 실행 결과와 employee 테이블을 조인하여 사원아이디, 사원명, 급여, 부서아이디, 부서명, 부서별 총급여, 평균급여 출력
select dept_id,sum(salary) sum , avg(salary) avg
from employee
group by dept_id
having sum(salary) >= 30000;

select e.emp_id, e.emp_name ,d.dept_id, d.dept_name , e.salary , t.sum, t.avg
from employee e, department d ,(select dept_id,sum(salary) sum , avg(salary) avg
from employee
group by dept_id
having sum(salary) >= 30000) t 
where e.dept_id = d.dept_id and d.dept_id = t.dept_id;

/******************************************
	테이블 결과 합치기 : union, union all
    형식> 쿼리1 실행 결과 union 쿼리2 실행 결과
	   > 쿼리1 실행 결과 union all 쿼리2 실행 결과
		 실행결과 컬럼이 동일(컬럼명, 데이터타입)
         -- union은 성능이 좋은 편은 아니기 때문에 자주 쓰진 않는다.
******************************************/
-- 영업부, 정보시스템 부서의 사원아이디, 사원명, 급여, 부서아이디 조회
-- union : 영업 부서 사원들이 한번만 출력
select emp_id, emp_name, salary, dept_id
from employee 
where dept_id = (select dept_id from department where dept_name = '영업')
union 
select emp_id, emp_name, salary, dept_id
from employee 
where dept_id = (select dept_id from department where dept_name = '정보시스템')
union 
select emp_id, emp_name, salary, dept_id
from employee 
where dept_id = (select dept_id from department where dept_name = '영업');

-- 영업부, 정보시스템 부서의 사원아이디, 사원명, 급여, 부서아이디 조회
-- union all : 영업 부서 사원들이 중복되어 출력
select emp_id, emp_name, salary, dept_id
from employee 
where dept_id = (select dept_id from department where dept_name = '영업')
union all
select emp_id, emp_name, salary, dept_id
from employee 
where dept_id = (select dept_id from department where dept_name = '정보시스템')
union all
select emp_id, emp_name, salary, dept_id
from employee 
where dept_id = (select dept_id from department where dept_name = '영업');

/******************************************
	논리적인 테이블 : VIEW(뷰), SQL을 실행하여 생성된 결과를 가상테이블로 정의 
    뷰 생성 : create view [view 이름]
			as [SQL 정의];
	뷰 삭제 : drop view [view 이름]
	 ** view 생성 시 권한을 할당 받아야 함 - mysql, maria 제외
     장점 : 개발할때 코드를 간소화 할 수 있음
     단점 : 권한 할당 때문에 보안문제가 생길 수 있음
******************************************/
select *
from information_schema.views
where table_schema = 'hrdb2019';

-- 부서 총급여가 30000 이상인 테이블
create view view_salary_sum
as
select e.emp_id, e.emp_name ,d.dept_id, d.dept_name , e.salary , t.sum, t.avg
from employee e, department d ,(select dept_id,sum(salary) sum , avg(salary) avg
from employee
group by dept_id
having sum(salary) >= 30000) t 
where e.dept_id = d.dept_id and d.dept_id = t.dept_id;

-- view_salary_sum 실행
select *
from view_salary_sum;

-- view_salary_sum 삭제
drop view view_salary_sum;
select *
from information_schema.views
where table_schema = 'hrdb2019';

/**********************************************
	DDL(Data Definition Laguage) : 생성, 수정, 삭제 - 테이블기준
    DML : C(insert), R(select),U(update),D(delete)
**********************************************/
-- 모든 테이블 목록
show tables;

-- [테이블 생성]
-- 형식> create table [테이블명] (
-- 			컬럼명 데이터타입(크기),
-- 			....
-- );
desc employee;
-- 데이터 타입 : 정수형(int,long), 실수형(float, double), 문자형(char, varchar, lontext ...)
--  		  이진데이터(longblob), 날짜형(date, datetime)..
-- char(고정형 문자형) : 크기가 메모리에 고정되는 형식, 예) char(10) --> 3자리 입력 : 7자리 낭비
desc employee;
select * from employee;

-- varchar(가변형 문자형) : 실제 저장되는 데이터 크기에 따라 메모리가 변경되는 형식, varchar(10) --> 3자리 입력 : 메모리 3자리 공간만 생성
-- longtext : 문장형태로 다수의 문자열을 저장
-- longblob : 이진데이터 타입의 이미지, 동영상 등 데이터 저장
-- date : 년,월,일 --> curdate()
-- datetime : 년,월,일,시,분,초 --> sysdate(), now()

-- emp 테이블 생성
-- emp_id : (char,4), ename : (varchar ,10), gender : (char, 1), hire_date : (dateime), salary : (int)
show tables;
create table emp(
		emp_id	 	char(4),
        ename 	 	varchar(10),
        gender 	 	char(1),
        hire_date 	datetime,
        salary 		int
);

select * from information_schema.tables
where table_schema = 'hrdb2019';

desc emp;

-- [테이블 삭제]
-- 형식 : drop table [테이블명]
drop table emp;

-- [테이블 복제]
-- 형식 : create table[테이블명]
-- 		as [SQL 정의]
-- employee 테이블을 복제하여 emp 테이블 생성
create table emp2
as
select * from emp;
show tables;

select * from emp;
select * from emp2;
desc employee;
desc emp;

-- 2016년도에 입사한 사원의 정보를 복제 : employee_2016
create table employee_2016
as select * 
from employee
where left(hire_date,4) = '2016';
drop table employee_2016;

show tables;
select * from employee_2016;

/********************************************************
	데이터 생성(insert : C)
	형식> insert into [테이블명] ({컬럼리스트 ...})
			values(데이터1, 데이터2 ....)
********************************************************/
show tables;
desc emp;
select * from employee;

insert into emp(emp_id, ename, gender, hire_date, salary)
values('s001','홍길동','m', now(), 1000);
select * from emp;

insert into emp(emp_id, ename, gender, hire_date, salary)
values('s001','홍길동','m', now(), 1000);

insert into emp(emp_id)
values ('s002');

-- [테이블 절삭 : 테이블의 데이터만 영구 삭제]
-- 형식> truncate table [테이블명];
truncate table emp;
drop table emp;

create table emp(
		emp_id	 	char(4)  		not null,
        ename 	 	varchar(10)		not null,
        gender 	 	char(1)			not null,
        hire_date 	datetime,
        salary 		int
);

insert into emp(emp_id, ename, gender, hire_date, salary)
values 		   ('s001', '홍길동', 'm', now(), 1000);
insert into emp values('s002', '이순신', 'm' , sysdate(), 2000);
insert into emp values('s003', '김유신', 'm' , curdate(), 2000);
desc emp;

select * from emp;

-- [자동 행번호 생성 : auto_increment]
-- 정수형으로 번호를 생성하여 저장함, pk, unique, 제약으로 설정된 컬럼에 주로 사용
create table emp2(
			emp_id		int		auto_increment primary key,	-- primary key : unique + not null
            ename 		varchar(10) not null,
            gender 		char(1) not null,
            hire_date	date,
            salary	 	int
);
insert into emp2 (ename , gender ,hire_date, salary)
values 			 ('김유신', 'm', now(), 2000);


show tables;
desc emp2;
select * from emp2;

/***********************************************************************
	테이블 변경 : alter table
    형식> alter table [테이블명]
			add column [새로추가하는 컬럼명, 데이터타입] -- null 허용
            modify column [변경하는 컬럼명, 데이터타입] -- 크기 고려
            drop column [삭제하는 컬럼명] 
***********************************************************************/
show tables;
select * from emp;

-- phone (char, 13) 컬럼 추가, null 허용
alter table emp
	add column phone char(13) null;
desc emp;

-- phone컬럼 삭제
alter table emp
	drop column phone;
insert into emp
values ('s004', '홍홍', 'f', now(), 4000, '010-1234-1234');

-- phone 컬럼의크기변경 : char(13) --> char(10)
alter table emp
	modify column phone char(10) null; -- 저장된 데이터보다 크기가 작으면 에러 발생!! 데이터 유실 위험 발생!!
    
/***********************************************************************
	데이터 수정 (update : U)
    형식> update [테이블명] 
			set (컬럼리스트 ...)
            where [조건절 ~]
	** set sql_safe_updates = 1 or 0; // 1 : 업데이트 불가 , 0 : 업데이트 가능
***********************************************************************/
select * from emp;
set sql_safe_updates = 0; -- 업데이트 모드 해제
-- 홍길동의 급여를 6000으로 수정
update emp
	set salary = 6000
    where emp_id = 's001';

-- 김유신의 입사날짜를 '20210725'로 수정
update emp
	set hire_date = cast('20210725135503' as datetime)
	where emp_id = 's003';

-- emp2 테이블에 retire_date 컬럼추가 : date
-- 기존 데이터는 현재 날짜로 업데이트
-- 업데이트 완료 후 retire_date not null 설정 변경
select * from emp2;
desc emp2;
alter table emp2
	add column retire_date date nulL;
update emp2
	set retire_date = curdate()
	where retire_date is null;
alter table emp2
modify column retire_date date not null;

/***********************************************************************
	데이터 삭제(delete : D)
    형식> delete from [테이블명]
			where [조건절 ~]
	** set sql_safe_updates = 1 or 0; 
    // 1 : 업데이트 불가 , 0 : 업데이트 가능
***********************************************************************/
select  * from emp;

-- 홍홍 사원 삭제
delete from emp
	where emp_id = 's004';
rollback;












    
