# Advanced Tags Example

This example demonstrates the advanced usage of the terraform-alicloud-tags module with tag governance features including:

- Tag policy creation and attachment to current account
- Meta tag (predefined tag) registration
- Associated rules for automatic tag propagation
- Multi-region provider configuration (Shanghai for tag policies, Hangzhou for meta tags)

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

## Cost

This example creates tag policies, meta tags, and associated rules, which are free services. However, ensure your account has the Tag Policy feature enabled before running this example.
