# Resourcely Github Actions

This repository demonstrates how to integrate Resourcely into
repository that uses Github Actions with multi-environment as the Terraform runner.

It contains a [workflow](.github/workflows/terraform.yml) that runs
`terraform plan` and then uses the [Resourcely Github
Action](https://github.com/Resourcely-Inc/resourcely-action) to
evaluate guardrails on that plan.

## Assumptions

This repository uses Github Actions to run `terraform plan` and
`terraform apply`.

If you use a different runner, see the scaffolding repository for that
runner:

- Terraform Cloud - [scaffolding-github-terraform-cloud](https://github.com/Resourcely-Inc/scaffolding-github-terraform-cloud)

## Limitations
This repository supports only AWS, Google, and GitHub Terraform providers. Any other providers require real credentials.

## Description 
This repository integrates with Resourcely to evaluates guardrails on Terraform plans with multiple environments. Here is a breakdown of the contents and function of each file in the repository:

- `main.tf`: The main Terraform configuration file where resources are defined. In this case, it shows a `null_resource` with a trigger based on a variable project. This resource might be used as a placeholder or for testing.

- `provider.tf` : Specifies the Terraform providers required for this project. It configures providers for AWS, Google Cloud, and GitHub. This file includes provider settings such as regions and optionally skips certain validations and checks for quicker runs in non-production environments.

- `terraform.tf`: Configures the required providers with their respective versions and any other Terraform settings that apply globally across the configuration.

- `vars.tf`: Defines the variable project used throughout the Terraform configurations. It specifies that project is of type string and includes a description of the variable.

- `dev.tfvars` and `prod.tfvars`: These files contain environment-specific variables for Terraform. `dev.tfvars` is used for development settings, while `prod.tfvars` is for production settings. These might include different resource sizes, configurations, or credentials specific to the environment. We created this setup to enable you to test Resourcely across various environment configurations, demonstrating how these map to settings in the Resourcely.yaml file.

- `.resourcely.yaml` is a config file in repos to which Resourcely Create can emit Terraform. It provides metadata about the structure of the Terraform config within the repo. For more info on this, please refer to the docs [here](https://docs.resourcely.io/getting-started/onboarding/configuring-resourcely.yaml#what-is-.resourcely.yaml)

## Environments

This scaffolding supports multiple-envs, one config root, `*.tfvars` file per environment style. For more info on that please visit [.resourcely.yaml Structure](https://docs.resourcely.io/getting-started/onboarding/configuring-resourcely.yaml#resourcely.yaml-structure). 

When you create a Pull Request and select the config root, in this example, `Resourcely Demo` specified in `.resourcely.yaml`, we will detect the environments and reference those in the create form. 

If you create a pull request from a blueprint," you can toggle the `"Env"` setting and select the `versioning_configuration_status` variable. Both values in `dev.tfvars` and `prod.tfvars` will then be referenced in the form.

## Usage

This repository is a template. Some setup is required after cloning to use it.

### 1. Configure Terraform Backend

Running Terraform in Github Actions requires storing the Terraform
state in a durable backend.  Terraform supports a variety of backends
described
[here](https://developer.hashicorp.com/terraform/language/settings/backends/configuration).

Edit [terraform.tf](terraform.tf) to add and configured your chosen
backend.

### 2. Add Resourcely API Token to Github Secrets.

The Resourcely Github Action requires an API token to authenticate to
the Resourcely API.

- Generate a new API token in the [Resourcely portal](https://portal.resourcely.io/settings/generate-api-token)
- Create a new [Github repository secret](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository) named `RESOURCELY_API_TOKEN` containing this token.

### 3. Update .resourcely.yaml

`.resourcely.yaml` tells Resourcely where to find the Terraform
configs within this repo.  If you move the config out of the
repository root or add new configs in subdirectories, update the file
to reflect these changes.

### 4. Ensure you have a valid manifest configuration.
The configuration are specified here [manifest](https://github.com/Resourcely-Inc/scaffolding-github-actions/blob/main/.github/workflows/terraform.yml#L89-L101)
