#!/bin/bash
{
  sudo service mariadb start
  bench start
} || {
  echo "============================================="
  echo "ERROR: entrypoint command failed to start"
  echo "============================================="
  tail -f /dev/null
}