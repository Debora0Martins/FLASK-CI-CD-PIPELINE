# Use Python 3.7
FROM python:3.7-slim

# Define diretório de trabalho
WORKDIR /app

# Copia arquivos do projeto
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Porta que o Flask usará
EXPOSE 5000

# Comando para rodar a aplicação
CMD ["python", "app.py"]

