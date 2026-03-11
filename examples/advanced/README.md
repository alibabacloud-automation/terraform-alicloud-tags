# Advanced Tags Example

This example demonstrates the advanced usage of the terraform-alicloud-tags module with tag governance features including:

- Standard tag generation with all parameters
- Custom tags merged with standard tags
- Tag policy creation and attachment to current account
- Meta tag (predefined tag) registration from standard tags
- Additional custom meta tags
- Disaster recovery flag usage
- GDPR personal data classification
- Repository tracking

## Usage

```bash
terraform init
terraform plan
terraform apply
```

To clean up:

```bash
terraform destroy
```

## Note

- The `alicloud_tag_meta_tag` resource only supports the `cn-hangzhou` region, so this example uses `cn-hangzhou` as the provider region.
- Tag policy attachment requires the current account to have the Tag Policy feature enabled.
