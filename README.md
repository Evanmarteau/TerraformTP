# Déploiement AWS avec Terraform

Cette configuration Terraform déploie des ressources AWS, y compris une instance EC2, un VPC, un groupe de sécurité, un sous-réseau et un backend S3.

## Prérequis

Avant de commencer, assurez-vous de disposer des éléments suivants :

- [Terraform](https://www.terraform.io/) installé sur votre machine.
- AWS CLI installé sur votre machine

Une fois AWS CLI installé faite dans un cmd en administrateur :

```bash
AWS configure
```

Renplissez les informations demandés notamment la clé publique et la clé secrète AWS

## Configuration

1. Clonez ce dépôt :

    ```bash
    git clone https://github.com/Evanmarteau/TerraformTP
    cd votre-repo
    ```

2. Créez un fichier `terraform.tfvars` et fournissez des valeurs pour les variables suivantes :

    ```hcl
    aws_region      = "votre_region_aws"
    instance_type   = "votre_type_instance"
    vpc_cidr_block  = "votre_bloc_cidr"
    access_key      = "votre_clé_d'accès_aws"
    secret_key      = "votre_clé_secrète_aws"
    ```

3. Initialisez Terraform :

    ```bash
    terraform init
    terraform plan
    ```

## Déploiement

Pour déployer l'infrastructure, exécutez :

```bash
terraform apply -var-file="terraform.tfvars"
```

Review the changes and type "yes" to confirm.

## Clean Up

Pour supprimer l'infrastructure, exécutez :

```bash
terraform destroy -var-file="terraform.tfvars"
```

## Variables

```hcl
aws_region     = Région AWS où les ressources seront déployées
instance_type  = Type d'instance EC2 à lancer
vpc_cidr_block = Bloc CIDR pour le VPC
access_key     = Clé d'accès AWS
secret_key     = Clé secrète AWS
```

## Auteurs

MARTEAU Evan evan.marteau@campus-igs-toulouse.fr

## 

N'oubliez pas de personnaliser les sections appropriées, comme l'auteur, la licence et les liens, en fonction des détails spécifiques de votre projet.
