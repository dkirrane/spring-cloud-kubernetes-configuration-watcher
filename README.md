# Overview

This project provides a GitHub Action workflow for deploying **Spring Cloud Kubernetes Configuration Watcher** to **Azure AKS**.

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
| **`ACR_REGISTRY_NAME`**   | Variable (required) | The name of the Azure Container Registry (ACR)                            |
| **`AKS_CLUSTER_NAME`**    | Variable (required) | The name of the Azure Kubernetes Cluster (AKS)                            |
| **`AKS_CLUSTER_RG`**      | Variable (required) | The name of Resource Group containing the AKS Cluster                     |

See [create-gh-env.sh](./create-gh-env.sh) for an example script on how to setup GitHub environment automatically.

## GitHub Actions Workflow

![Deploy Workflow](https://github.com/dkirrane/spring-cloud-kubernetes-configuration-watcher/actions/workflows/deploy.yml/badge.svg?branch=main)
