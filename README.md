# Virtual Private Cloud

Modulo terraform para criar o serviço de VPC.

## Requisitos

|Nome|Versão|
|----|------|
|terraform|>= 0.14.0|

## Suposições

* Você deseja criar uma VPC com subnets privadas e publicas, com 1 Internet Gateway, 1 Nat Gateway e rotas default.

## Importante

Informe em `aws_profile_name` o profile AWS que provisionará o ambiente.

## Outputs

|Nome|Descrição|
|----|---------|
|vpc_id|O ID da VPC|
|vpc_arn|Amazon Resource Name da VPC|
|vpc_cidr_block|Range IPv4 da VPC|
|private_subnets_id|O ID das subnets privadas|
|private_subnets_arn|O Amazon Resource Name das subnets privadas|
|private_subnets_cidr_block|Range IPv4 das subnets privadas|
|public_subnets_id|O ID das subnets publicas|
|public_subnets_arn|O Amazon Resource Name das subnets privadas|
|public_subnets_cidr_block|Range IPv4 das subnets privadas|

## Veja

Na pasta exemples possue exemplos de utilização do modulo.

### Em desenvolvimento

* Opção de criação de subnets para bancos de dados
* Habilitar o serviço VPC Flow Logs