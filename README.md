# terraform-padock-test

"Write a Terraform module that provisions a PostgreSQL database on GCP."

- Module terraform PostgreSQL 

[Code Here](https://github.com/eugenemazamda/terraform-padock)

- Give at least one example of the use of the module.

once my module is created it can be used like this: 

see the link and configuration to deploy in an automated way with github action 
[Url CI](https://github.com/eugenemazamda/terraform-padock/runs/7030345956?check_suite_focus=true)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| activation\_policy | The activation policy for the master instance.Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`. | `string` | `"ALWAYS"` | no |
| create\_timeout | The optional timout that is applied to limit long database creates. | `string` | `"15m"` | no |
| database\_version | The database version to use | `string` | n/a | yes |
| db\_name | The name of the default database to create | `string` | `"default"` | no |
| disk\_autoresize | Configuration to increase storage size. | `bool` | `true` | no |
| disk\_size | The disk size for the master instance. | `number` | `10` | no |
| disk\_type | The disk type for the master instance. | `string` | `"PD_SSD"` | no |
| enable\_default\_db | Enable or disable the creation of the default database | `bool` | `true` | no |
| enable\_default\_user | Enable or disable the creation of the default user | `bool` | `true` | no |
| region | The region of the Cloud SQL resources | `string` | `"us-central1"` | no |
| tier | The tier for the master instance. | `string` | `"db-f1-micro"` | no |
| user\_labels | The key/value labels for the master instances. | `tomap({string})` | `{}` | no |
| user\_name | The name of the default user | `string` | `"default"` | no |
| user\_password | The password for the default user. If not set, a random one will be generated and available in the generated\_user\_password output variable. | `string` | `""` | no |
| zone | The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| additional\_users | List of maps of additional users and passwords |
| generated\_user\_password | The auto generated default user password if not input password was provided |
| instance\_connection\_name | The connection name of the master instance to be used in connection strings |
| instance\_first\_ip\_address | The first IPv4 address of the addresses assigned. |
| instance\_ip\_address | The IPv4 address assigned for the master instance |
| instance\_name | The instance name for the master instance |
| instance\_self\_link | The URI of the master instance |
| instance\_server\_ca\_cert | The CA certificate information used to connect to the SQL instance via SSL |
| instance\_service\_account\_email\_address | The service account email address assigned to the master instance |
| instances | A list of all `google_sql_database_instance` resources we've created |

- Focus on quality and good practice. Document and justify the chosen practices.

There are many good practices in the implementation of terraform. Here are some examples :

**Structuring**

an appropriate directory structure should be followed to handle some of the complexities that may arise in the project. 
For example, if you are using terraform in environments it is best to separate directories.

**Naming convention**

it is important to name variables correctly, so your code will be easier to understand. 

**Use Shared Modules**

it is strongly recommended to use modules. In addition, each module should focus on a single aspect of the infrastructure, such as creating a database instance in our case. 

[Examples of ready-to-use modules](https://registry.terraform.io/)

[PostgresSQL Module](https://registry.terraform.io/modules/AckeeCZ/postgresql/sql/5.6.0)

**Latest version**

it is recommended to stay on the latest version of Terraform as in the case of a major new release. you can easily upgrade to the latest version. If you skip several major releases, the upgrade will become very complex.

**Backup System State**

Always back up the Terraform state files. These files keep track of the metadata and resources of the infrastructure. By default, these files called terraform.tfstate are stored locally in the workspace directory.

Without these files, Terraform will not be able to determine which resources are deployed on the infrastructure. It is therefore essential to have a backup of the state file. By default, a file with the name terraform.tfstate.backup will be created to keep a backup of the status file.

**Lock State File**

There may be several scenarios where several developers try to run the terraform configuration at the same time. This can lead to corruption of the terraform state file or even data loss. The locking mechanism prevents such scenarios. It ensures that only one person runs the terraform configurations at a time and that there are no conflicts.

**Use self Variable**

self variable is a special type of variable that is used when you don't know the value of the variable before deploying an infrastructure.

Let's say you want to use the IP address of an instance that will only be deployed after the terraform apply command, so you don't know the IP address until it is up and running. These variables are only allowed on the connection and provisioning blocks of the terraform configuration.

**Minimize Blast Radius**

The blast radius is nothing more than a measure of the damage that can occur if things don't go as planned.

For example, if you deploy certain terraform configurations on the infrastructure and the configuration is not applied correctly, how much damage will be done to the infrastructure.

So, to minimise the blast radius, it is always suggested to push a few configurations on the infrastructure at a time. This way, if something goes wrong, the damage to the infrastructure will be minimal and can be corrected quickly. Deploying many configurations at once is very risky.

**Use var-file**

In terraform, you can create a file with the extension tfvars and pass this file to the terraform apply command using -var-file flag. Cela vous aide à transmettre les variables que vous ne souhaitez pas mettre dans le code de configuration de terraform.

It is always suggested to pass variables for a password, secret key, etc. locally via "rather than saving it in terraform configurations or on a remote version control system.

**User Docker**

When running a CI/CD pipeline generation task, it is suggested to use docker containers. Terraform provides official docker containers that can be used. If you change the server CI/CD, you can easily switch the infrastructure inside a container.

Before deploying the infrastructure on the production environment, you can also test the infrastructure on Docker containers, which are very easy to deploy. By combining Terraform and Docker, you get a portable, reusable and repeatable infrastructure.

## TO DO
- Configure the replication database in order zone and region 
- Configure backup for this databases 