#!/bin/bash

set -eu

# ==============================================================================
# Functions
# ==============================================================================

# 使用法を表示する関数
function usage {
cat >&2 <<EOS
コンテナ上で動かしたMYSQLサーバにクエリを送ります
(このディレクトリでのみの動作が保証されています).

[usage]
  $0 <sql_file> [options]

[args]
  sql_file:
    Path to the SQL file to be executed.

[options]
  -h | --help:
    Display this help message.

[example]
  $0 ./query/sample.sql
  $0 ./query/sample.sql -c my-mysql-container
EOS
exit 1
}

# errorレベルのエラーメッセージを出力しつつスクリプトを異常終了させる関数
function error {
  echo "[ERROR] $1" >&2
  exit 1
}

# infoレベルのメッセージを出力する関数
function info {
  echo "[INFO] $1"
}

# コマンドを表示しつつ実行する関数
function invoke {
  info "$@"
  "$@" || error "Command failed: '$*'"
}

# ==============================================================================
# Main
# ==============================================================================

# --- Option Parsing ---
CONTAINER_NAME="sql_udemy_practice-db-1"

args=() # positional arguments
while [ "$#" != 0 ]; do
  case $1 in
    -h | --help    ) usage;;
    -* | --*       ) error "$1 : Invalid option." ;;
    *              ) args+=("$1");;
  esac
  shift
done

# --- Argument Validation ---
# Check number of arguments
if [ "${#args[@]}" -ne 1 ]; then
  usage
fi

SQL_FILE="${args[0]}"

# Check if SQL_FILE exists
if [ ! -f "${SQL_FILE}" ]; then
  error "SQL file not found: ${SQL_FILE}"
fi

# --- ログ記述 ---
info "Executing SQL file: ${SQL_FILE}"
info "Target container: ${CONTAINER_NAME}"

# SQLファイルの内容を一行に変換して実行
SQL_COMMAND=$(cat "${SQL_FILE}" | tr '\n' ' ')
invoke docker exec -i "${CONTAINER_NAME}" mysql -e"${SQL_COMMAND}"

info "Script finished successfully."
