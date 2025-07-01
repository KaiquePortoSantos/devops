# Etapa 1: Imagem base
# Usamos uma imagem oficial e leve do Python com Alpine Linux.
FROM python:3.12.11-alpine3.22

# Etapa 2: Definir o diretório de trabalho
# Isso garante que os comandos subsequentes sejam executados neste diretório dentro do container.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache do Docker.
# Se o arquivo não mudar, o Docker reutilizará a camada de cache, acelerando builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
# Copia todos os outros arquivos (como app.py, routers/, etc.) para o diretório de trabalho.
COPY . .

# Etapa 5: Expor a porta
# Informa ao Docker que o container escutará na porta 8000 em tempo de execução.
EXPOSE 8000

# Etapa 6: Comando para iniciar a aplicação
# Executa o servidor Uvicorn. O host 0.0.0.0 torna a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]