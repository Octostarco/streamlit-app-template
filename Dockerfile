FROM octostar/streamlit-apps-gpu:latest

WORKDIR /app

ENV VIRTUAL_ENV=/app/venv
ENV PATH="/app/venv/bin:$PATH"
ENV CODE_SERVER_PORT=8080

RUN apt-get update \
 && apt-get install -y --no-install-recommends python3-venv \
 && rm -rf /var/lib/apt/lists/* \
 && python3 -m venv "$VIRTUAL_ENV" \
 && "$VIRTUAL_ENV/bin/pip" install --upgrade pip

COPY . /app

RUN chmod +x build.sh && chmod +x main.sh && ./build.sh

ENTRYPOINT ["/bin/bash", "/app/main.sh"]

EXPOSE 8080