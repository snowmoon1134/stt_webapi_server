# Python 3.10をベースイメージとして使用
FROM python:3.10-slim

# 必要なシステムパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# uvをインストール
RUN pip install uv

# 仮想環境を作成してアクティベート
RUN uv venv
ENV PATH="/app/.venv/bin:$PATH"

# 依存関係ファイルをコピー
COPY pyproject.toml ./

# 依存関係をインストール
RUN uv pip install --no-cache-dir -e .

# モデルの事前ダウンロードを実行
COPY model_downloader model_downloader
RUN python model_downloader/pre_download.py

# アプリケーションのソースコードをコピー
COPY app/ ./app/

# ポート8001を公開
EXPOSE 8001

# アプリケーションを起動
CMD ["python", "app/server.py"] 