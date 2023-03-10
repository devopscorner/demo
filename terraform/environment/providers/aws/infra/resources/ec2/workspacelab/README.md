# Terraform WorkspaceLab

## How-to-Deploy

- Terraform Initialize

  ```
  terraform init
  ```

- List Existing WorkspaceLab

  ```
  terraform workspace list
  ```

- Create WorkspaceLab

  ```
  terraform workspace new [environment]
  ---
  eg:
  terraform workspace new lab
  terraform workspace new staging
  terraform workspace new prod
  ```

- Use WorkspaceLab

  ```
  terraform workspace select [environment]
  ---
  eg:
  terraform workspace select lab
  terraform workspace select staging
  terraform workspace select prod
  ```

- Terraform Planning

  ```
  terraform plan
  ```

- Terraform Provisioning

  ```
  terraform apply
  ```

## Migrate State

- Rename Backend

  ```
  mv backend.tf.example backend.tf
  ```

- Initiate Migrate

  ```
  terraform init --migrate-state
  ```

## Cleanup Environment

```
terraform destroy
```

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
