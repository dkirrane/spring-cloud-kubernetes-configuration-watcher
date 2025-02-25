# Overview

This project provides a GitHub Action workflow for deploying to Azure AKS.

## References
- https://docs.spring.io/spring-cloud-kubernetes/docs/current/reference/html/#spring-cloud-kubernetes-configuration-watcher
- https://github.com/spring-cloud/spring-cloud-kubernetes/tree/v2.1.7/spring-cloud-kubernetes-controllers/spring-cloud-kubernetes-configuration-watcher/k8s

## GitHub Actions Setup

_Create a GitHub Environment with the following Secrets and env Variables:_

| Name                      | Type                | Description                                                               |
|---------------------------|---------------------|---------------------------------------------------------------------------|
| **`ARM_CLIENT_ID`**       | Secret (required)   | Client ID of the Microsoft EntraID Service Principal with rbac to AKS     |
| **`ARM_CLIENT_SECRET`**   | Secret (required)   | Client Secret of the Microsoft EntraID Service Principal with rbac to AKS |
| **`ARM_SUBSCRIPTION_ID`** | Secret (required)   | The Azure Subscription ID                                                 |
| **`ARM_SUBSCRIPTION_ID`** | Secret (required)   | The Microsoft EntraID Tenant ID                                           |
| **`REGISTRY`**            | Variable (required) | The name of the Azure Container Registry (ACR)                            |

```bash
# Example setting up required GitHub Environment with GH CLI
env="dev"
gh secret set --repo dkirrane/spring-cloud-kubernetes-configuration-watcher --env ${env} ARM_CLIENT_ID --body ${GCP_CREDENTIALS}
gh secret set --repo dkirrane/spring-cloud-kubernetes-configuration-watcher --env ${env} ARM_CLIENT_SECRET --body ${env}
gh secret set --repo dkirrane/spring-cloud-kubernetes-configuration-watcher --env ${env} ARM_SUBSCRIPTION_ID --body ${region}
gh secret set --repo dkirrane/spring-cloud-kubernetes-configuration-watcher --env ${env} ARM_SUBSCRIPTION_ID --body ${env}
gh secret set --repo dkirrane/spring-cloud-kubernetes-configuration-watcher --env ${env} REGISTRY --body ${env}
```

## GitHub Actions Workflow

![Deploy Workflow](https://github.com/dkirrane/spring-cloud-kubernetes-configuration-watcher/actions/workflows/deploy.yml/badge.svg?branch=main)
