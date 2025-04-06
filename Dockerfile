FROM node:20-alpine AS frontend

WORKDIR /app/frontend

COPY ./frontend .

RUN npm install

RUN npm run build

FROM python:3.11-alpine AS backend

WORKDIR /app

COPY . .

COPY --from=frontend /app/frontend/dist ./frontend/dist

# 安装 pdm
ADD https://pdm-project.org/install-pdm.py .
RUN python3 install-pdm.py

RUN /root/.local/bin/pdm install

ENV PATH="/app/.venv/bin:$PATH"

ENV HOST= 
ENV PORT= 
ENV KEY=

WORKDIR /app/backend

CMD ["python3", "main.py"]
