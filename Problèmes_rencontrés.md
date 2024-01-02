Lors de la confection des différants fichiers de configuration j'ai rencontré plusieurs problèmes :

Dans un premier temps j'ai créé le fichier main.tf avec la création d'une instance EC2, la configuration du backend S3 et la configuration du fournisseur AWS avec les variables en dur dans le main.tf et ça a fonctionné directement 

## problemes liés aux groupe de sécurité et VPC

Dans un premier temps j'ai pris la configuration dans la documentation terraform et ça n'a pas fonctionné
puis j'ai défini un VPC et intégrer le groupe de sécurité dans mon instance
J'ai eu un problème de sous réseaux car mon groupe de sécurité etait dans un sous-réseau différent que le sous-réseau par défaut

J'ai donc défini un sous-réseaux et je l'ai intégré dans mon instance

## problemes liés a l'IPv6

J'ai essayé de mettre de l'IPv6 dans la configuration mais j'ai eu l'erreur suivante 

```hcl
 "ipv6_cidr_block": all of `ipv6_cidr_block,ipv6_ipam_pool_id` must be specified
```

J'ai donc créé un fichier vpc.tf avec la configuration suivante :

```hcl
 variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Enable DNS support for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}
```

Je n'ai pas réussi à faire marcher le VPC et le groupe de sécurité avec l'IPv6 j'ai donc pris la décision de ne pas intégrer l'IPv6 mais ça m'a permis de comprendre le lien entre les VPC, les groupes de sécurité, les sous-reseaux et l'instance

## problemes liés a AWS

J'ai eu plusieurs petits soucis avec la liaison AWS et terraform sur mon PC comme par exemple mes clés AWS mal renseigner etc. qui ont été résolu très rapidement et qui participent à la compréhension globale de Terraform et AWS 
