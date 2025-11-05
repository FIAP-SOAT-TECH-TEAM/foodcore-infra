# Pré-carga LocalStack

# Criar User Pool
echo "-> Criando User Pool no LocalStack..."
USER_POOL_NAME="test-user-pool"
USER_POOL_ID=$(docker exec foodcore-localstack awslocal cognito-idp create-user-pool \
    --pool-name "$USER_POOL_NAME" \
    --schema '[
        {"Name":"cpf","AttributeDataType":"String","Mutable":true},
        {"Name":"role","AttributeDataType":"String","Mutable":true},
        {"Name":"createdAt","AttributeDataType":"String","Mutable":true}
    ]' \
    --query 'UserPool.Id' --output text)
echo "-> User Pool criado: $USER_POOL_ID (Atualize environment variables onde necessário)"

# Criar usuário pré-carregado
USER_JSON=$(docker exec foodcore-localstack awslocal cognito-idp admin-create-user \
    --user-pool-id "$USER_POOL_ID" \
    --username "jao" \
    --user-attributes \
        Name=email,Value=jao@foodcore.com \
        Name=name,Value=João \
        Name=custom:cpf,Value=866.756.240-83 \
        Name=custom:role,Value=CUSTOMER \
        Name=custom:createdAt,Value=2025-10-07T02:00:00Z \
    --query 'User.Attributes' --output json)
SUBJECT_ID=$(echo "$USER_JSON" | jq -r '.[] | select(.Name=="sub") | .Value')
echo "-> Usuário pré-carregado com sucesso!"
echo "-> Subject ID: $SUBJECT_ID (Utilize isto no cabeçalho 'Auth-Subject' para autenticação simulada)"