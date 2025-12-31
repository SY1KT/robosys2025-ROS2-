#!/usr/bin/env bash
#SPDX-FileCopyrightText: 2025 Tatsunori Kanno
#SPDX-License-Identifier: BSD-3-Clause

set -e

echo "[TEST] topic_watchdog I/O test start"

# watchdog 起動
ros2 run mypkg topic_watchdog \
  --ros-args \
  -p watch_topic:=/test_topic \
  -p timeout_sec:=0.5 \
  > /tmp/watchdog.log 2>&1 &

WATCHDOG_PID=$!

# WARN が来るまで最大10秒待つ
STATUS=$(timeout 10 bash -c '
  ros2 topic echo /watchdog/status 2>/dev/null |
  grep "^data: WARN:"
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
  exit 1
fi




