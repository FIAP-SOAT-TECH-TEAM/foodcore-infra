#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
PROJECT_ROOT=$(dirname "$SCRIPT_DIR")

echo "===== Iniciando infraestrutura ====="

# Verificar se o Docker está rodando
check_docker() {
  docker info &>/dev/null
  return $?
}

if ! check_docker; then
  echo "ERRO: O Docker não está rodando."
  echo "Por favor, inicie o Docker Desktop e tente novamente."
  exit 1
fi

# Ir para o diretório docker
cd "$PROJECT_ROOT/docker" || {
  echo "ERRO: Diretório docker não encontrado."
  exit 1
}

# Verificar se já existem containers rodando
RUNNING_CONTAINERS=$(docker compose ps --filter "name=foodcore" --format "{{.Name}}" 2>/dev/null)

if [ -n "$RUNNING_CONTAINERS" ]; then
  echo "AVISO: Existem containers da aplicação em execução:"
  echo "$RUNNING_CONTAINERS"

  if [ "$1" != "--force" ]; then
    read -p "Deseja parar os containers existentes e iniciar novamente? (s/n): " resposta
    if [[ ! "$resposta" =~ ^[Ss]$ ]]; then
      echo "Operação cancelada."
      exit 0
    fi
  fi

  echo "-> Parando containers existentes..."
  docker compose down
fi

# Iniciar RabbitMQ
echo "-> Iniciando RabbitMQ..."
docker compose up -d rabbitmq

# Verificar se o RabbitMQ está pronto (usando healthcheck)
echo "-> Verificando status do RabbitMQ..."
MAX_RETRIES=30
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    STATUS=$(docker inspect --format='{{.State.Health.Status}}' foodcore-rabbitmq 2>/dev/null)

    if [ "$STATUS" = "healthy" ]; then
        echo "-> RabbitMQ está pronto!"
        break
    fi

    RETRY_COUNT=$((RETRY_COUNT+1))
    echo "Aguardando RabbitMQ inicializar... ($RETRY_COUNT/$MAX_RETRIES)"
    sleep 2
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    echo "AVISO: Tempo limite excedido aguardando o RabbitMQ inicializar"
fi

# Iniciar Zipkin
echo "-> Iniciando Zipkin..."
docker compose up -d zipkin

# Verificar se o Zipkin está ativo
ZIPKIN_RETRIES=15
ZIPKIN_COUNT=0
while [ $ZIPKIN_COUNT -lt $ZIPKIN_RETRIES ]; do
    STATUS=$(docker inspect --format='{{.State.Status}}' foodcore-zipkin 2>/dev/null)
    if [ "$STATUS" = "running" ]; then
        echo "-> Zipkin está em execução!"
        break
    fi

    ZIPKIN_COUNT=$((ZIPKIN_COUNT+1))
    echo "Aguardando Zipkin iniciar... ($ZIPKIN_COUNT/$ZIPKIN_RETRIES)"
    sleep 2
done

if [ $ZIPKIN_COUNT -eq $ZIPKIN_RETRIES ]; then
    echo "AVISO: Tempo limite excedido aguardando o Zipkin iniciar"
fi

# Iniciar Adminer
echo "-> Iniciando Adminer..."
docker compose up -d adminer

# Mostrar status final
echo
echo "===== Infraestrutura iniciada com sucesso! ====="
echo
echo "Serviços disponíveis:"
echo "- Adminer: http://localhost:8083"
echo "- RabbitMQ (painel de gerenciamento): http://localhost:15672"
echo "- Zipkin: http://localhost:9411"
echo
echo "Use 'docker compose ps' para verificar o status dos serviços."