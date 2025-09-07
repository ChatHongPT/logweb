# CPU 모니터링 시스템

Linux 시스템에서 `journalctl`, `crontab`, `awk`를 사용한 실시간 CPU 스트레스 감지 시스템입니다.

## 팀원

| 최홍석 | 홍윤기 | 
| :---: | :---: |  
| <img width="160px" src="https://github.com/user-attachments/assets/02386ffc-793b-49ec-b0e2-41f088b5f52f"/>  | <img width="150px" src="https://github.com/user-attachments/assets/e8fdc284-987f-45a4-9cdc-d473dcbcc5bb"/> |
| [@ChatHongPT](https://github.com/ChatHongPT) | [@yunkihong-dev](https://github.com/yunkihong-dev) |

## 주요 기능

- 실시간 모니터링: 1초마다 CPU 사용률 체크
- 자동 알림: 임계값 초과 시 콘솔 및 시스템 로그에 기록
- 파일 로깅: 모든 결과를 `cpu_log.txt`에 저장
- 백그라운드 실행: 터미널 종료 후에도 계속 실행
- journalctl 연동: 시스템 로그로 스트레스 이벤트 추적
- awk 활용: 텍스트 처리 및 조건 분석

## 기술 스택

![Bash Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnubash&logoColor=fff)
![vmstat](https://img.shields.io/badge/Linux-vmstat-333?logo=linux&logoColor=fff)
![top](https://img.shields.io/badge/Linux-top-333?logo=linux&logoColor=fff)
![awk](https://img.shields.io/badge/Tool-awk-000?logo=gnu&logoColor=fff)
![logger](https://img.shields.io/badge/Linux-logger-666?logo=linux&logoColor=fff)
![journalctl](https://img.shields.io/badge/Linux-journalctl-666?logo=linux&logoColor=fff)
![crontab](https://img.shields.io/badge/Linux-crontab-666?logo=linux&logoColor=fff)
![nohup](https://img.shields.io/badge/Linux-nohup-666?logo=linux&logoColor=fff)
![stress](https://img.shields.io/badge/Linux-stress-CC0000?logo=linux&logoColor=fff)

## 파일 구조

```
/home/ubuntu/
├── cpu_monitor.sh      # 메인 CPU 모니터링 스크립트
├── cpu_log.txt         # CPU 로그 저장 파일 (자동 생성)
└── README.md           # 이 파일
```

## 설치 및 실행 방법

### 1. 스크립트 파일 생성

```bash
# 홈 디렉토리로 이동
cd /home/ubuntu/

# cpu_monitor.sh 파일 생성
nano cpu_monitor.sh

# 스크립트 내용 입력 후 저장 (Ctrl+X, Y, Enter)

# 실행 권한 부여
chmod +x cpu_monitor.sh
```

### 2. 스크립트 실행

**방법 A: 백그라운드에서 계속 실행 (추천)**
```bash
# 백그라운드에서 실행 (터미널 종료해도 계속 실행)
nohup /home/ubuntu/cpu_monitor.sh &

# 프로세스 확인
ps aux | grep cpu_monitor
```

**방법 B: 전경에서 실행**
```bash
# 직접 실행 (Ctrl+C로 중단)
./cpu_monitor.sh
```

**방법 C: crontab으로 자동 실행**
```bash
# crontab 편집
crontab -e

# 부팅 시 자동 실행 추가
@reboot /home/ubuntu/cpu_monitor.sh &
```

### 3. 로그 확인

```bash
# 실시간 로그 확인 (1초마다 업데이트)
tail -f /home/ubuntu/cpu_log.txt

# 최근 10줄 로그 보기
tail -n 10 /home/ubuntu/cpu_log.txt

# 전체 로그 보기
cat /home/ubuntu/cpu_log.txt
```

### 4. 시스템 로그 확인 (HIGH STRESS 발생 시)

```bash
# cpu_log.txt
# 평상시
2025-09-05 16:20:30 CPU: 3% - 정상
2025-09-05 16:20:32 CPU: 3% - 정상
2025-09-05 16:20:34 CPU: 2% - 정상

# 스트레스 테스트시
2025-09-05 16:20:36 CPU: 100% - 정상
2025-09-05 16:20:38 CPU: 100% - 정상
2025-09-05 16:20:40 CPU: 100% - 정상
```

## 설정 변경

### CPU 임계값 변경

스크립트 내에서 `THRESHOLD=80` 값을 원하는 값으로 변경:

```bash
# cpu_monitor.sh 편집
nano cpu_monitor.sh

# THRESHOLD=80을 원하는 값으로 변경
THRESHOLD=70   # 70%로 낮추기
THRESHOLD=90   # 90%로 높이기
```

### 모니터링 간격 변경

`sleep 1` 값을 변경해서 모니터링 간격 조정:

```bash
sleep 1     # 1초마다 (기본값)
sleep 5     # 5초마다
sleep 10    # 10초마다
```

## 출력 

<img width="640" height="382" alt="image" src="https://github.com/user-attachments/assets/85b881e4-7d84-45df-9584-220b96a6f8c9" />

 cpu_log.txt에 로그가 추가된 모습

### 정상 상태
```
2025-09-05 16:12:01 CPU: 15% - 정상
2025-09-05 16:12:02 CPU: 18% - 정상
2025-09-05 16:12:03 CPU: 22% - 정상
```

### 스트레스 감지
```
2025-09-05 16:12:04 CPU: 85% - HIGH STRESS!
2025-09-05 16:12:05 CPU: 92% - HIGH STRESS!
2025-09-05 16:12:06 CPU: 78% - 정상
```

## 테스트 방법

### CPU 스트레스 테스트

```bash
# stress 명령어 설치
sudo apt install stress

# CPU 부하 생성 (4개 코어, 30초간)
stress --cpu 4 --timeout 30s

# 다른 터미널에서 로그 실시간 확인
tail -f /home/ubuntu/cpu_log.txt
```


## 문제 해결

### 스크립트가 실행되지 않는 경우

```bash
# 실행 권한 확인
ls -la cpu_monitor.sh

# 실행 권한이 없다면
chmod +x cpu_monitor.sh
```

### 프로세스 관리

```bash
# 실행 중인 cpu_monitor 프로세스 확인
ps aux | grep cpu_monitor

# 프로세스 종료
kill [PID번호]

# 모든 cpu_monitor 프로세스 종료
pkill -f cpu_monitor
```

## 회고

### 최홍석
이번 프로젝트를 통해 Bash 스크립트를 활용한 실시간 모니터링 시스템을 구현하면서, 단순한 CPU 측정 로직뿐만 아니라 `journalctl`과 `logger`를 통한 시스템 로그 관리의 중요성을 체감했습니다. 특히, 프로세스가 백그라운드에서 안정적으로 동작하도록 `nohup`과 `crontab`을 조합하는 과정에서 많은 시행착오를 겪었지만, 이를 해결하면서 자동화와 유지보수 측면의 경험치를 크게 쌓을 수 있었습니다.

### 홍윤기
`vmstat`와 `awk`를 이용해 CPU 사용률을 실시간으로 분석하고, 특정 임계값을 초과했을 때 알림을 주는 구조를 설계한 것이 인상적이었습니다. 테스트 단계에서 `stress`를 활용해 다양한 부하 환경을 시뮬레이션하며, 로깅 포맷과 출력 타이밍을 개선했습니다. 특히, 로그를 단순 저장하는 것을 넘어 시스템 로그와 연동해 관리자가 한눈에 이벤트를 추적할 수 있도록 만든 점이 프로젝트의 완성도를 높였습니다.

