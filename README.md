# STT Web API Server

Whisperモデルを使用した音声認識（Speech-to-Text）Web APIサーバーです。

## 機能

- 音声ファイルからの文字起こし（`/stt/file`エンドポイント）
- 音声データのバイト列からの文字起こし（`/stt/bytes`エンドポイント）
- 日本語を含む複数言語に対応

## 必要条件

- Python 3.8以上
- uv（依存関係管理用）
- Docker（コンテナ実行用）

## ローカル環境での起動方法

### uvを使用する場合

1. uvのインストール
```bash
pip install uv
```

2. 依存関係のインストール
```bash
uv pip install --system -e .
```

3. サーバーの起動
```bash
python app/server.py
```

### Dockerを使用する場合

1. Dockerイメージのビルド
```bash
docker build -t stt-webapi-server .
```

2. コンテナの起動
```bash
docker run -p 8001:8001 stt-webapi-server
```

## APIエンドポイント

### 1. 音声ファイルからの文字起こし

**エンドポイント**: `/stt/file`  
**メソッド**: POST  
**パラメータ**:
- `file`: 音声ファイル（multipart/form-data）
- `language`: 言語（デフォルト: "japanese"）

**使用例**:
```bash
curl -X POST -F "file=@audio.wav" -F "language=japanese" http://localhost:8001/stt/file
```

### 2. 音声データのバイト列からの文字起こし

**エンドポイント**: `/stt/bytes`  
**メソッド**: POST  
**パラメータ**:
- リクエストボディ: 音声データのバイト列
- `language`: 言語（デフォルト: "japanese"）

**使用例**:
```bash
curl -X POST --data-binary @audio.raw -H "Content-Type: application/octet-stream" http://localhost:8001/stt/bytes
```

## 注意事項

- 初回起動時は、Whisperモデルのダウンロードに時間がかかる場合があります
- GPUを使用する場合は、追加の設定が必要です
- 音声ファイルは16kHzのサンプリングレートで処理されます