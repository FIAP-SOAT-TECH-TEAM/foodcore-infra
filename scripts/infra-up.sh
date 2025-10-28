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

# Iniciar SQL Server do Service Bus Emulator
echo "-> Iniciando SQL Server para Azure Service Bus Emulator..."
docker compose up -d azure-service-bus-emulator-sql-server

# Aguardar o SQL Server inicializar
echo "-> Aguardando SQL Server inicializar..."
SQL_RETRIES=30
SQL_COUNT=0
while [ $SQL_COUNT -lt $SQL_RETRIES ]; do
    STATUS=$(docker inspect --format='{{.State.Status}}' foodcore-azure-service-bus-emulator-sql-server 2>/dev/null)
    if [ "$STATUS" = "running" ]; then
        echo "-> SQL Server está em execução!"
        break
    fi

    SQL_COUNT=$((SQL_COUNT+1))
    echo "Aguardando SQL Server... ($SQL_COUNT/$SQL_RETRIES)"
    sleep 3
done

if [ $SQL_COUNT -eq $SQL_RETRIES ]; then
    echo "AVISO: Tempo limite excedido aguardando SQL Server inicializar"
fi

# Iniciar Azure Service Bus Emulator
echo "-> Iniciando Azure Service Bus Emulator..."
docker compose up -d azure-service-bus-emulator

# Aguardar o Service Bus Emulator ficar pronto
echo "-> Verificando status do Azure Service Bus Emulator..."
SB_RETRIES=30
SB_COUNT=0
while [ $SB_COUNT -lt $SB_RETRIES ]; do
    STATUS=$(docker inspect --format='{{.State.Status}}' foodcore-azure-service-bus-emulator 2>/dev/null)
    if [ "$STATUS" = "running" ]; then
        echo "-> Azure Service Bus Emulator está em execução!"
        break
    fi

    SB_COUNT=$((SB_COUNT+1))
    echo "Aguardando Azure Service Bus Emulator... ($SB_COUNT/$SB_RETRIES)"
    sleep 2
done

if [ $SB_COUNT -eq $SB_RETRIES ]; then
    echo "AVISO: Tempo limite excedido aguardando Azure Service Bus Emulator inicializar"
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
echo "- Azure Service Bus Emulator: 5672 (AMQP), 5300 (Management)"
echo "- Zipkin: http://localhost:9411"
echo
echo "Use 'docker compose ps' para verificar o status dos serviços."