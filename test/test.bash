#!/usr/bin/env bash
#SPDX-FileCopyrightText: 2025 Tatsunori Kanno
#SPDX-License-Identifier: BSD-3-Clause

set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
WS_ROOT=$(cd "${SCRIPT_DIR}/.." && pwd)

PKG_NAME=mypkg
NODE_NAME=talker

ERRORS=0
NODE_PID=""

cleanup () {
  echo ""
  echo "[INFO] Cleaning up..."
  if [ -n "${NODE_PID}" ] && ps -p ${NODE_PID} > /dev/null 2>&1; then
    kill ${NODE_PID}
    wait ${NODE_PID} 2>/dev/null || true
    echo "[INFO] Node stopped"
  fi
}

trap cleanup SIGINT SIGTERM EXIT

echo "=== ROS2 talker test start ==="
echo "[INFO] Workspace root: ${WS_ROOT}"

# ROS2 環境
if ! command -v ros2 >/dev/null 2>&1; then
  echo "[ERROR] ros2 command not found"
  exit 1
fi

# setup.bash
if [ ! -f "${WS_ROOT}/install/setup.bash" ]; then
  echo "[ERROR] install/setup.bash not found in ${WS_ROOT}"
  exit 1
fi

source "${WS_ROOT}/install/setup.bash"

# ノード起動
echo "[INFO] Starting node..."
ros2 run ${PKG_NAME} ${NODE_NAME} &
NODE_PID=$!

sleep 2

# 起動確認
if ps -p ${NODE_PID} > /dev/null; then
  echo "[INFO] Node running (PID=${NODE_PID})"
else
  echo "[ERROR] Node failed to start"
  ERRORS=$((ERRORS+1))
fi

# topic 確認
if ros2 topic list | grep -q "^/countup$"; then
  echo "[INFO] Topic /countup OK"
else
  echo "[ERROR] Topic /countup not found"
  ERRORS=$((ERRORS+1))
fi

# 実データ確認
if ros2 topic echo /countup --once >/dev/null 2>&1; then
  echo "[INFO] /countup publishing OK"
else
  echo "[ERROR] No message on /countup"
  ERRORS=$((ERRORS+1))
fi

echo "=== TEST RESULT ==="
if [ ${ERRORS} -eq 0 ]; then
  echo "PASS"
  exit 0
else
  echo "FAIL (${ERRORS} errors)"
  exit ${ERRORS}
fi

