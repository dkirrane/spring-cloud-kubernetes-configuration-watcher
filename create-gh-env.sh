#!/usr/bin/env bash

# Description: This script us used to create the required GitHub environment needed by the GitHub Action workflow.
# Author: dkirrane
set -euo pipefail

# Check if logged in to GitHub
if gh auth status >/dev/null 2>&1; then
    echo "You are logged in to GitHub."
else
    gh auth status
    exit 1
fi

# Load environment variables from the .env file
if [[ -f .env ]]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found!"
    return 1
fi

# Ensure required variables are set
required_vars=(ENVIRONMENT ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_SUBSCRIPTION_ID ARM_TENANT_ID ACR_REGISTRY_NAME AKS_CLUSTER_NAME AKS_CLUSTER_RG)
for var in "${required_vars[@]}"; do
    if [[ -z "${!var}" ]]; then
        echo "Error: ${var} is not set. Please check your .env file."
        return 1
    fi
done

# GitHub Repository
REPO="dkirrane/spring-cloud-kubernetes-configuration-watcher"

create_github_environment() {
    # Delete the environment if it exists and just re-create from scratch
    if $(gh api /repos/${REPO}/environments/${ENVIRONMENT} >/dev/null 2>&1); then
        echo "${REPO} - Environment '${ENVIRONMENT}' already exist. Deleting..."
        # https://docs.github.com/en/rest/deployments/environments?apiVersion=2022-11-28#delete-an-environment
        gh api --silent -X DELETE /repos/${REPO}/environments/${ENVIRONMENT}
    fi

    echo "${REPO} - Creating Environment '${ENVIRONMENT}' ..."
    # https://docs.github.com/en/rest/reference/deployments#create-or-update-an-environment
    jq -n '{}' | gh api --silent -X PUT repos/${REPO}/environments/${ENVIRONMENT}
}

create_github_secrets_and_variables() {

    # Set secrets
    gh secret set ARM_CLIENT_ID --repo ${REPO} --env ${ENVIRONMENT} --body ${ARM_CLIENT_ID}
    gh secret set ARM_CLIENT_SECRET --repo ${REPO} --env ${ENVIRONMENT} --body ${ARM_CLIENT_SECRET}
    gh secret set ARM_SUBSCRIPTION_ID --repo ${REPO} --env ${ENVIRONMENT} --body ${ARM_SUBSCRIPTION_ID}
    gh secret set ARM_TENANT_ID --repo ${REPO} --env ${ENVIRONMENT} --body ${ARM_TENANT_ID}

    gh secret set ACR_REGISTRY_NAME --repo ${REPO} --env ${ENVIRONMENT} --body ${ACR_REGISTRY_NAME}
    gh secret set AKS_CLUSTER_NAME --repo ${REPO} --env ${ENVIRONMENT} --body ${AKS_CLUSTER_NAME}
    gh secret set AKS_CLUSTER_RG --repo ${REPO} --env ${ENVIRONMENT} --body ${AKS_CLUSTER_RG}

    # These could be considered non-sensitive so could be changed to variables
    # gh variable set ACR_REGISTRY_NAME --repo ${REPO} --env ${ENVIRONMENT} --body ${REGISTRY}
    # gh variable set AKS_CLUSTER_NAME --repo ${REPO} --env ${ENVIRONMENT} --body ${AKS_CLUSTER_NAME}
    # gh variable set AKS_CLUSTER_RG --repo ${REPO} --env ${ENVIRONMENT} --body ${AKS_CLUSTER_RG}

    # https://docs.github.com/en/actions/managing-workflow-runs/enabling-debug-logging#enabling-step-debug-logging
    gh secret set --repo ${REPO} ACTIONS_STEP_DEBUG --body "false"
    gh secret set --repo ${REPO} ACTIONS_RUNNER_DEBUG --body "false"
}

setup_github() {
    create_github_environment
    create_github_secrets_and_variables
}

setup_github
