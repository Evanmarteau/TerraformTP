# Définition d'une instance EC2
resource "aws_instance" "my_instance" {
  ami                    = "ami-02ea01341a2884771" # ID de l'AMI Amazon à utiliser
  instance_type          = var.instance_type       # Type d'instance défini par une variable
  
  vpc_security_group_ids = [aws_security_group.allow_tls.id]  # Utilisation d'un groupe de sécurité
  
  subnet_id              = aws_subnet.my_subnet.id            # Spécification du sous-réseau
  
  tags = {
    Name = "moninstance"
  }
}

# Configuration du backend (stockage de l'état dans un bucket S3)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket         = "yourbuckets3"                                 # Nom du bucket S3 pour stocker l'état Terraform, Remplacez par le nom unique de votre bucket!
    key            = "tfstate/yourbuckets3.tfstate"                 # Emplacement de stockage de l'état, Remplacez par le nom unique de votre bucket!
    region         = "eu-west-3"                                           # Région AWS pour le bucket, Remplacez par la région de votre choix
  }
}

# Configuration du fournisseur AWS
provider "aws" {
  region = var.aws_region     # Région AWS définie par une variable
  access_key = var.access_key # Clé d'accès AWS 
  secret_key = var.secret_key # Clé secrète AWS 
}

# Définition d'un VPC
resource "aws_vpc" "main" {
  # Configuration pour le VPC
  cidr_block = var.vpc_cidr_block # Bloc CIDR pour la VPC
}  


# Définition d'un groupe de sécurité
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"                 # Nom du groupe de sécurité
  description = "Allow TLS inbound traffic" # Description du groupe de sécurité
  vpc_id      = aws_vpc.main.id             # Association avec la VPC définie précédemment
  
  # Autorisation du trafic entrant TLS depuis la VPC
  ingress {                                      # Port source pour le trafic entrant
    description      = "TLS from VPC"            # Description de la règle d'autorisation
    from_port        = 443                       # Port source autorisé
    to_port          = 443                       # Port destination autorisé
    protocol         = "tcp"                     # Protocole autorisé (TCP)
    cidr_blocks      = [aws_vpc.main.cidr_block] # Plage d'adresses IPv4 autorisée
  }
  
  # Autorisation de tout trafic sortant
  egress {                           # Port source pour le trafic sortant
    from_port        = 0             # Port destination pour le trafic sortant
    to_port          = 0             # Autoriser tous les protocoles pour le trafic sortant
    protocol         = "-1"          # Autoriser tout trafic sortant vers n'importe quelle destination IPv4
    cidr_blocks      = ["0.0.0.0/0"] # Autoriser tout trafic sortant vers n'importe quelle destination IPv6
  }

  tags = {
    Name = "allow_tls" # Étiquette pour identifier le groupe de sécurité
  }
}

# Définition d'un sous-réseau
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.main.id     # Association avec la VPC principale
  cidr_block              = var.vpc_cidr_block  # Bloc CIDR pour le sous-réseau
  availability_zone       = "eu-west-3a"        # Zone de disponibilité pour le sous-réseau
}
