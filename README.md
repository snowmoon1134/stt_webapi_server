# STT Web API Server
Whisperモデルを使用した音声認識（Speech-to-Text）Web APIサーバーです。
https://github.com/nyosegawa/local-simple-realtime-api の `server_stt.py` を拝借し、Dockerで動作するようにしたコードです。

以下の機能を追加しています
- Dockerfile(CPU版、GPU版)を追加
- dockerビルド時に、特定のSTTモデルファイルをダウンロードするスクリプトを追加
    - これにより、docker run するとすぐSTTサーバが立ち上がります

## Base Repository
[nyosegawa/local-simple-realtime-api の2024/10/29時点のmainブランチ](https://github.com/nyosegawa/local-simple-realtime-api/commit/97db84c29b1255042e8f41d163d1f0817d5f743a#diff-01b03cb00e1bf2ed3f4dd9276a6605f0dfdbe89a99889a50228e3ec12376228a)の`server_stt.py`をベースとしています

## 機能
- 音声ファイルからの文字起こし（`/stt/file`エンドポイント）
- 音声データのバイト列からの文字起こし（`/stt/bytes`エンドポイント）

## 必要条件
- Python 3.8以上
- uv（依存関係管理用）
- Docker（コンテナ実行用）

## How to Run

```
# dockerイメージビルド
docker build -t stt_webapi_server .
# docker起動
docker run --rm -it -p 8001:8001 stt_webapi_server
```

### Run with NVIDIA GPU
NVIDIA Container Toolkitは事前導入

```
docker build -t stt_webapi_server -f Dockerfile.gpu .

# CUDAがGPUを認識しているか事前チェック
docker run --rm -it --entrypoint="python" --gpus=all stt_webapi_server '-c' 'import torch;print(torch.cuda.is_available())'
# Trueと出ていたら認識している

# サーバ起動
docker run --rm -it -p 8001:8001 --gpus=all stt_webapi_server
```