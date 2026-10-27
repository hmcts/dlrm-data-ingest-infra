# dlrm-data-ingest-infra
Infrastructure configuration for DLRM Data Ingestion

## Logic App FTP Publishing

The `modules/ipkit_logic` module explicitly configures the Logic App Standard
resource's `site_config.ftps_state`.

| Input | Default | Accepted values | Explicit null |
| --- | --- | --- | --- |
| `ftps_state` | `Disabled` | Exact `Disabled` or `FtpsOnly` | Resolves to `Disabled` |

`Disabled` turns off FTP and FTPS publishing. Set `FtpsOnly` only when encrypted
FTP publishing is required. `AllAllowed`, empty strings, whitespace, differently
cased values and unsupported values are rejected during input validation.
The change does not modify publishing authentication, HTTP access or identities.

Existing callers that omit this input now explicitly disable FTP publishing.
Confirm normal, manual, emergency and third-party publishing requirements before
adoption. The landing component does not currently forward this input, so an FTPS
exception there requires a separate caller change. This module change does not
establish the configuration of deployed Azure resources.

### Contract Tests

Use Terraform 1.7 or later for the mocked tests. This test-runner requirement does
not raise the module's production Terraform or provider requirements.

From the repository root:

```sh
terraform -chdir=modules/ipkit_logic init -backend=false -input=false
terraform -chdir=modules/ipkit_logic fmt -check -recursive
terraform -chdir=modules/ipkit_logic test -filter=tests/ftps_state.tftest.hcl
```

Initialization downloads providers and external modules. The tests use mocked
Azure providers and an overridden App Insights module. Every run is plan-only
and requires no Azure credentials or remote state. The assertions inspect the
planned Logic App resource's FTP setting for omitted, explicit and null inputs,
and check rejection of invalid inputs.

The resource-free test fixture pins AzureRM 4.81.0, matching the landing caller
without changing the module's production constraints.

Verified with Terraform 1.16.1 and AzureRM 4.81.0: 12 runs passed, including the
provider-only fixture. This is not a compatibility certification for every
provider version allowed by the module.
Standalone `terraform validate` in this child module requires the aliased
provider configurations supplied by a caller. The test runner validates its
configurations using the mocked providers instead.

## Function App FTP Publishing

The `modules/function_app` module exposes the same `ftps_state` contract as the
Logic App module: omitted and null inputs map to `Disabled`, and only exact
`Disabled` or `FtpsOnly` values are accepted. The value is explicitly assigned to
the Linux Function App's `site_config.ftps_state`. Invalid values are rejected
before provisioning. Publishing authentication, HTTPS, identities, runtime,
networking and existing lifecycle rules are unchanged.

The landing caller still creates Function Apps only for landing zones with
`deploy_function_app = true`. It does not forward the new FTP input. An FTPS
exception needs a separately coordinated caller change and publishing-owner
confirmation before adoption. No deployed compliance is inferred from source.

From the repository root, use Terraform 1.7 or later for these isolated checks:

```sh
terraform -chdir=modules/function_app init -backend=false -input=false
terraform -chdir=modules/function_app fmt -check -recursive
terraform -chdir=modules/function_app test -filter=tests/ftps_state.tftest.hcl
```

The test fixture pins AzureRM 4.81.0, matching the landing caller without changing
the module's production constraints. All runs are plan-only, with mocked Azure
providers, an overridden App Insights module and dummy inputs. A resource-free
fixture checks the existing landing creation filter without planning the real
deployment root. Standalone child-module validation needs caller provider aliases,
which the test runner supplies as mocks. Initialization downloads dependencies.

Verified with Terraform 1.16.1 and AzureRM 4.81.0: 12 runs passed. This does not
certify other runtime/provider versions or the deployed publishing configuration.
