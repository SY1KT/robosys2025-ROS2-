#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Kanno Tatsunori
# SPDX-License-Identifier: BSD-3-Clause

from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='mypkg',
            executable='topic_watchdog',
            parameters=[
                {'watch_topic': '/chatter'},
                {'timeout_sec': 1.5},
            ],
        )
    ])

