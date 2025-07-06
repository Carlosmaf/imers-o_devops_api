# Define a imagem base. Usar uma versão específica e estável é uma boa prática.
# A imagem 'alpine' é escolhida por ser leve, ideal para produção.
# Esta é a versão estável mais recente no momento.
FROM python:3.12.4-alpine3.20

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o passo de instalação não será executado novamente.
COPY requirements.txt .

# Instala as dependências da aplicação
# --no-cache-dir reduz o tamanho final da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", !"--reload"]
