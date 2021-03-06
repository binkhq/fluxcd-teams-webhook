FROM python:3.9-slim as base
WORKDIR /app
COPY Pipfile /app
COPY Pipfile.lock /app
RUN pip install pipenv && \
    pipenv lock -r > requirements.txt

FROM python:3.9-slim as build
WORKDIR /app
COPY --from=base /app/requirements.txt /app/
RUN pip install -r requirements.txt
COPY fluxcd_teams_bot /app/fluxcd_teams_bot/

EXPOSE 8080

LABEL org.opencontainers.image.source https://github.com/binkhq/fluxcd-teams-webhook
LABEL org.opencontainers.image.licenses Apache-2.0
Label org.opencontainers.image.title Flux v1 Teams Webhook

CMD ["python3", "-m", "fluxcd_teams_bot.server"]
