AWS ECR Create Action
=====================

This GitHub Action creates an AWS ECR repo based on the GITHUB_REPOSITORY.

This action expects AWS credentials to have already been initialized.
See: https://github.com/aws-actions/configure-aws-credentials

Usage
-----

```yaml
  - name: Configure AWS Credentials
    uses: aws-actions/configure-aws-credentials@v1
    with:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      aws-region: us-east-2
  - name: Create ECR Repository
    uses: aplaceformom/aws-ecr-create-action@master
    with:
      allowed_accounts: 0123456789ABCDEF
```

Inputs
------

### allowed_accounts
A list of AWS Account ID's that should be granted read access to this repository.
- required: false
- default: N/A

### debug
Enable debugging
- required: false
- default: false
