AWS ECR Create Action
=====================

This [GitHub Action][GitHub Actions] creates an AWS ECR repo based on the
`GITHUB_REPOSITORY`.

This action expects AWS credentials to have already been initialized.

See also:
- https://github.com/aws-actions/configure-aws-credentials
- https://github.com/apfm-actions
- https://help.github.com/en/actions

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

Outputs
-------

### arn
AWS ARN of the ECR repository

### uri
Docker URI of the ECR repository

### label
 suggested ECR label derrived from the git revision

[//]: # (The following are reference links used elsewhere in the document)

[Git]: https://git-scm.com/
[GitHub]: https://www.github.com
[GitHub Actions]: https://help.github.com/en/actions
[Terraform]: https://www.terraform.io/
[Docker]: https://www.docker.com
[Dockerfile]: https://docs.docker.com/engine/reference/builder/
