## Descrição do Projeto ##

Projeto Flask CI/CD Pipeline na AWS com infraestrutura automatizada via CloudFormation, deploy com Docker, Gunicorn e Nginx.”

Este projeto é uma aplicação web em Flask, configurada para execução em Docker e implantação em servidores EC2 com Gunicorn e Nginx, incluindo práticas básicas de CI/CD.

O objetivo é demonstrar um pipeline profissional, seguro e escalável para projetos Flask, com atenção especial à separação de ambientes, automação e versionamento seguro do código.

## Tecnologias Utilizadas ##

Python 3.x

Flask

Gunicorn

Nginx

Docker / Docker Compose

Git e GitHub

CI/CD (GitHub Actions ou outro serviço similar)

Pré-requisitos

Antes de iniciar, certifique-se de ter instalado:

Python 3.x

Git

Docker e Docker Compose

Nginx (opcional, caso não use Docker para implantar)

Conta no GitHub com token de acesso pessoal (para transações Git via HTTPS)

## Estrutura do Projeto ##
flask-app/
│
├── app.py              # Aplicação Flask principal
├── requirements.txt    # Dependências Python
├── Dockerfile          # Imagem Docker para a aplicação
├── .gitignore          # Arquivos e pastas ignoradas pelo Git
├── README.md           # Documentação do projeto
└── config/
    └── nginx.conf      # Configuração Nginx (opcional)

• Configuração do Ambiente

  Criar e ativar virtualenv:

  python3 -m venv venv
  source venv/bin/activate


  Instalar dependências:

  pip install -r requirements.txt


  Configurar variáveis de ambiente (exemplo seguro):

  export FLASK_ENV=production
  export SECRET_KEY='sua_chave_secreta'


• Executando Localmente

  Com o ambiente ativo:

  flask run
  
  utilizando Gunicorn para produção:

  gunicorn -w 4 -b 127.0.0.1:5000 app:app

  Implantação com Docker

  Construir a imagem:

  docker build -t flask-app .


  Rodar o container:

  docker run -d -p 5000:5000 flask-app


  Verificar se está rodando:

  docker ps
  curl http://localhost:5000

  Configuração Nginx (Opcional)

## Exemplo de configuração de proxy reverso:

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}


  Recarregue o Nginx após alterações:

  sudo nginx -t
  sudo systemctl restart nginx

  CI/CD com GitHub Actions

• Exemplo de workflow: .github/workflows/deploy.yml

name: Pipeline CI/CD

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: 3.11

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Run tests
        run: pytest

      - name: Build Docker image
        run: docker build -t flask-app .

      - name: Push to Docker Hub
        run: |
          echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
          docker tag flask-app ${{ secrets.DOCKER_USERNAME }}/flask-app:latest
          docker push ${{ secrets.DOCKER_USERNAME }}/flask-app:latest



## Boas Práticas ##

Use .gitignore para arquivos sensíveis (.env, .pem, venv/ etc.)

Manter ambientes separados: desenvolvimento, teste, produção

Monitore logs do Gunicorn/Nginx e container Docker

Use tokens de acesso pessoal (PAT) no GitHub em vez de senhas

## Contato ##

  ✍️Autor: Débora Martins 

    E-mail: ddeboraf.mar@gmail.com

    GitHub: https://github.com/Debora0Martins
