Curso Academia do flutter
Desafio Dart Avançado 

Aplicação pega estados e cidades na API do site do IBGE e insere em tabelas do Mysql.

Usa container docker para instanciar Mysql, o qual instala na porta 3310 .

Pré requisitos:
Possuir  docker instalado .
Possuir  Dart instalado.

Para subir Mysql :
Em terminal na pasta do projeto execute:
docker-compose up

Possui tabela "pais", com registro 1 = Brasil

Importante ressaltar que para trabalhar com outros países, seria necessário alterar estrutuda das tabelas : estado e cidade  , inserindo campo id  auto increment  e outro campo de id para cidade e estado, para não conflitar com id de outros países.



