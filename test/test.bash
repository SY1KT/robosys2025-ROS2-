#!/usr/bin/env bash
#SPDX-FileCopyrightText: 2025 Tatsunori Kanno
#SPDX-License-Identifier: BSD-3-Clause

set -e

source /opt/ros/humble/setup.bash

source install/setup.bash

echo "[TEST] topic_watchdog I/O test start"

# watchdog 起動
ros2 run mypkg topic_watchdog \
  --ros-args \
  -p watch_topic:=/test_topic \
  -p timeout_sec:=0.5 \
  > /tmp/watchdog.log 2>&1 &

WATCHDOG_PID=$!

sleep 1

# 1回だけ publish
ros2 topic pub /test_topic std_msgs/msg/String "{data: test}" --once

# WARN が出るまで最大10秒待つ
STATUS=$(timeout 10 bash -c '
  until grep "WARN: /test_topic timeout" /tmp/watchdog.log; do
    sleep 0.1
  done
' || true)

# 後始末
kill ${WATCHDOG_PID} 2>/dev/null || true

echo "[DEBUG] status message:"
echo "${STATUS}"

if [ -n "${STATUS}" ]; then
  echo "[PASS] watchdog WARN detected"
  exit 0
else
  echo "[FAIL] watchdog WARN not detected"
  echo "[DEBUG] watchdog log:"
  cat /tmp/watchdog.log || true
  exit 1
fi

