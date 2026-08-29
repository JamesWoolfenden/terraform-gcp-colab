# terraform-gcp-colab

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-colab/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-colab)
[![Latest Release](https://img.shields.io/github/release/terraform-gcp-colab.svg)](https://github.com/JamesWoolfenden/terraform-gcp-colab/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-colab.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-colab/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Terraform module for a Colab Enterprise runtime template with CMEK-encrypted
disks, no internet access and an idle shutdown timer. Exercises holden's
`google_colab_runtime_template` policies.

## Usage

Add **module.colab.tf** to your code:-

```terraform
module "colab" {
  source       = "jameswoolfenden/colab/gcp"
  version      = "0.0.1"
  name         = "example-template"
  display_name = "Example runtime template"
  location     = "europe-west2"
  network      = google_compute_network.colab.id
  subnetwork   = google_compute_subnetwork.colab.id
  kms_key_name = google_kms_crypto_key.colab.id
}
```

`enable_internet_access = false` means notebooks cannot reach the public
internet, so the subnetwork needs Private Google Access (set in the example)
and Cloud NAT if pip installs from PyPI are required. The Vertex AI service
agent needs `roles/cloudkms.cryptoKeyEncrypterDecrypter` on the key.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_colab_runtime_template.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/colab_runtime_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | Description of the runtime template | `string` | `"Managed by Terraform"` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Size of the persistent data disk, in GB | `number` | `100` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name of the runtime template | `string` | n/a | yes |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | How long a runtime may be idle before it is shut down, in seconds with an s suffix | `string` | `"3600s"` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | Resource name of the Cloud KMS key used to encrypt runtime disks (CMEK) | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels applied to the runtime template | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Region of the runtime template | `string` | `"europe-west2"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type of the runtime | `string` | `"e2-standard-4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource ID of the Colab Enterprise runtime template | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Self-link of the VPC network the runtime attaches to | `string` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Self-link of the subnetwork the runtime attaches to | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ID of the Colab Enterprise runtime template |
| <a name="output_name"></a> [name](#output\_name) | Resource ID of the Colab Enterprise runtime template |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-gcp-colab/issues).

## Copyrights

Copyright © 2019-2026 [Jim Woolfenden](https://github.com/JamesWoolfenden)

## License

See [LICENSE](LICENSE) for full details.


<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "aiplatform.notebookRuntimeTemplates.create",
    "aiplatform.notebookRuntimeTemplates.delete",
    "aiplatform.notebookRuntimeTemplates.get",
    "aiplatform.notebookRuntimeTemplates.update"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "aiplatform.notebookRuntimeTemplates.get"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->