#!/bin/bash
# cpu_monitor.sh - 1초마다 CPU 모니터링

LOG_FILE="/home/ubuntu/cpu_log.txt"

# 무한 루프로 1초마다 실행
while true; do
    # CPU 사용률 확인
    CPU_USAGE=$(vmstat 1 2 | tail -1 | awk '{print 100-$15}')

    # 방법 2: top에서 idle 값으로 계산 (백업)
    if [ -z "$CPU_USAGE" ] || [ "$CPU_USAGE" = "100-" ]; then
        CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{idle=$8; gsub(/%id.*/, "", idle); if(idle=="") idle=0; usage=100-idle; print usage}')
    fi

    # 현재 시간
    TIME=$(date '+%Y-%m-%d %H:%M:%S')

    # 임계값 (80%)
    THRESHOLD=80

    # 결과 출력 및 로그 기록
    echo "$TIME CPU: ${CPU_USAGE}%" | awk -v threshold="$THRESHOLD" '
    {
        cpu = $3
        gsub(/%/, "", cpu)
        
        # 숫자가 아닌 경우 0으로 처리
        if (cpu !~ /^[0-9.]+$/) cpu = 0
        
        if (cpu > threshold) {
            print $0 " - HIGH STRESS!"
            system("logger \"CPU 스트레스 감지: " cpu "%\"")
        } else {
            print $0 " - 정상"
        }
    }' >> "$LOG_FILE"

    # 1초 대기
    sleep 1
done
