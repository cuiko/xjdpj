FROM node:20-alpine AS frontend

WORKDIR /app/frontend

COPY ./frontend .

RUN npm install

RUN npm run build

FROM python:3.11-slim AS backend

WORKDIR /app

COPY . .

COPY --from=frontend /app/frontend/dist ./frontend/dist

# 安装 pdm
RUN curl -sSL https://pdm-project.org/install-pdm.py | python3 -

RUN pdm install

WORKDIR /app/backend

ENV KEY=

CMD ["python3", "main.py"]
