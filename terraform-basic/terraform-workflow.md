# Terraform Core Commands

1. **`terraform init`**: 
   - Initializes a working directory containing Terraform configuration files.
   - Downloads and installs the necessary provider plugins.
   - Initializes the backend (where state is stored).

2. **`terraform validate`**: 
   - Verifies whether a configuration is syntactically valid and internally consistent.

3. **`terraform plan`**: 
   - Creates an execution plan, letting you preview the changes Terraform will make.
   - It doesn't actually perform the changes.

4. **`terraform apply`**: 
   - Executes the actions proposed in a Terraform plan to create, update, or destroy infrastructure.
   - Typically requires a manual confirmation unless `-auto-approve` is used.

5. **`terraform destroy`**: 
   - Convenient way to destroy all remote objects managed by a particular Terraform configuration.

## Additional Basic Commands

- `terraform fmt`: Automatically formats your configuration files for consistency.
- `terraform show`: Provides human-readable output from a state or plan file.
- `terraform output`: Lists all output variables defined in your configuration.
- `terraform state list`: Lists all resources currently tracked in the Terraform state.
- `terraform version`: Checks your current Terraform version.

