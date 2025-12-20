#!/bin/bash

# Kill any existing application process
pkill -f virtual-threads-structured-concurency

# Start the Spring Boot application in the background
./mvnw spring-boot:run &

# Get the process ID of the application
APP_PID=$!
echo "PID=${APP_PID}"

# Wait for the application to start
echo "Waiting for application to start..."
while ! curl -s http://localhost:8088/actuator/health > /dev/null; do
  sleep 1
done

echo "Application started!"

# Function to check the health endpoints
check_health() {
  PROBE_TYPE=$1
  PROBE_URL="http://localhost:8088/actuator/health/${PROBE_TYPE}"
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $PROBE_URL)

  echo "curl ${PROBE_URL} has ${HTTP_STATUS}"

  if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "$PROBE_TYPE probe is UP"
    return 0
  else
    echo "$PROBE_TYPE probe is DOWN (HTTP status: $HTTP_STATUS)"
    return 1
  fi
}

# Continuously check the liveness and readiness probes
SUCCESS_COUNT=0
while true; do
  check_health "liveness"
  LIVENESS_STATUS=$?

  check_health "readiness"
  READINESS_STATUS=$?

  if [ "$LIVENESS_STATUS" -eq 0 ] && [ "$READINESS_STATUS" -eq 0 ]; then
    echo "Application is healthy!"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    echo "Consecutive successes: $SUCCESS_COUNT"
    if [ "$SUCCESS_COUNT" -ge 5 ]; then
      echo "Application is stable. Exiting."
      exit 0
    fi
  else
    echo "Application is not healthy."
    SUCCESS_COUNT=0
  fi

  sleep 5
done

# Clean up the background process on script exit
trap "pkill -f virtual-threads-structured-concurency" EXIT
