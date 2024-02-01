## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_nutanix"></a> [nutanix](#requirement\_nutanix) | 1.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_nutanix"></a> [nutanix](#provider\_nutanix) | 1.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [nutanix_image.ubuntu](https://registry.terraform.io/providers/nutanix/nutanix/1.4.1/docs/resources/image) | resource |
| [nutanix_virtual_machine.vm](https://registry.terraform.io/providers/nutanix/nutanix/1.4.1/docs/resources/virtual_machine) | resource |
| [nutanix_subnet.subnet](https://registry.terraform.io/providers/nutanix/nutanix/1.4.1/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_creds"></a> [creds](#input\_creds) | n/a | `map(string)` | <pre>{<br>  "end": "10.10.15.115",<br>  "pass": "sdofoiewrndof",<br>  "user": "souravp"<br>}</pre> | no |

## Outputs

No outputs.
