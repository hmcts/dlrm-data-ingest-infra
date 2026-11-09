# dlrm-data-ingest-infra
Infrastructure configuration for DLRM Data Ingestion

## FTP Publishing

Both `modules/ipkit_logic` (Logic App Standard) and `modules/function_app`
(Linux Function App) configure `site_config.ftps_state` using the same input:

| Input | Default | Accepted values | Explicit null |
| --- | --- | --- | --- |
| `ftps_state` | `FtpsOnly` | Exact `Disabled` or `FtpsOnly` | Resolves to `FtpsOnly` |

`FtpsOnly` allows encrypted FTP publishing without permitting plain FTP.
Set `Disabled` to turn off both FTP and FTPS publishing. Unsupported values,
including `AllAllowed`, empty, whitespace, padded and wrong-case strings, are rejected.

The landing caller does not forward this input, so selecting `Disabled` requires
a caller change and confirmation of publishing requirements. Function App
creation remains controlled by `deploy_function_app`. Publishing authentication
and other resource settings are unchanged.

## Contract Tests

From the repository root, use Terraform >= 1.7 for these mocked, plan-only tests.
This test-runner requirement does not raise production version requirements.
Initialization downloads dependencies. No Azure credentials or remote state are needed.

```sh
terraform -chdir=modules/ipkit_logic init -backend=false -input=false
terraform -chdir=modules/ipkit_logic fmt -check -recursive
terraform -chdir=modules/ipkit_logic test -filter=tests/ftps_state.tftest.hcl

terraform -chdir=modules/function_app init -backend=false -input=false
terraform -chdir=modules/function_app fmt -check -recursive
terraform -chdir=modules/function_app test -filter=tests/ftps_state.tftest.hcl
```
