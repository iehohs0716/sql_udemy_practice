# SQL学習用リポジトリ

以下のリポジトリにある演習をローカルで試せるようにしたものです。
リンク

## ディレクトリ構成

```
.
├── docker-compose.yml      # Dockerコンテナ設定 (MySQL)
├── execute_query.sh        # SQL実行用スクリプト
├── init/
│   ├── conf/
│   │   └── my.cnf          # MySQL設定ファイル
│   └── sql/
│       └── sample_data.sql # 初期投入用のサンプルデータ
├── query/
│   └── sample.sql          # SQLクエリのサンプルファイル
└── README.md               # このファイル
```

## 使い方

### 1. データベースコンテナの起動

Docker Composeを使ってMySQLコンテナを起動します。

```bash
docker-compose up -d
```

### 2. SQLクエリの実行

`execute_query.sh` スクリプトを使って、データベースに対してSQLファイルを実行します。
このスクリプトは、詳細な使い方やエラーハンドリング���機能を備えています。

#### 書式

```bash
./execute_query.sh <SQLファイルへのパス> [オプション]
```

#### 引数

-   `sql_file`: (必須) 実行したいSQLファイルへのパスを指定します。

#### オプション

-   `-h`, `--help`: ヘルプメッセージを表示します。

#### 実行例

```bash
# サンプルクエリを実行する
./execute_query.sh ./query/sample.sql

# ヘルプメッセージを表示する
./execute_query.sh --help
```

### 3. コンテナの停止

作業が終わったら、コンテナを停止してください。

```bash
docker-compose down -v
```

## 注意

- このコンテナにおいては、パスワード認証をオフにしています。本番で活用する際には最大限注意してください。