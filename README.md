# General information

> [!IMPORTANT]
> This repository contains Helm charts and development tools for OpenCRVS. For comprehensive documentation, installation guides, and infrastructure setup instructions, please refer to the **[Official OpenCRVS Documentation](https://documentation.opencrvs.org/)**.


## 🚀 Getting Started

### Prerequisites for Quick start

<!-- FIXME: Replace with link to official doc once published! -->

* [ ] **Kubernetes**: For macOS and Windows users, we recommend Docker Desktop with Kubernetes, for Linux users, we recommend Minikube. Use one of available solutions:
  * Install [minikube](https://minikube.sigs.k8s.io/docs/start)
  * Enable kubernetes on Docker Desktop, [Learn more](https://www.docker.com/)
  * Any other available kubernetes engine, e/g OrbStack
* [ ] **kubectl**: Install kubectl, Kubernetes command-line tool, check [here](https://kubernetes.io/docs/tasks/tools/)
* [ ] **helm**: Install [helm](https://helm.sh/docs/intro/install/). Helm is a template engine for managing Kubernetes manifests.
* [ ] **tilt**: Install [tilt](https://docs.tilt.dev/install.html)

### Quick Start with Tilt

> [!NOTE]
> Apple Silicon and ARM64 device owners, please check existing ARM64 tags at [GitHub packages](https://github.com/orgs/opencrvs/packages?ecosystem=container) or build images yourself and update `Tiltfile` before running `tilt up`

1. The fastest way to get OpenCRVS running locally:
    ```bash
    # Clone the repository
    git clone https://github.com/yourusername/opencrvs-helm-charts.git
    cd opencrvs-helm-charts

    # Start the development environment
    tilt up
    ```
2. Open the Tilt UI in your browser
3. Navigate to http://localhost:10350
4. Scroll to **"2.Data-tasks"** and run `data-seed` job
5. Navigate to http://opencrvs.localhost

Please also check the [OpenCRVS helm chart](./charts/opencrvs-services/README.md#-quickstart) Quick Start documentation for how to deploy without `tilt`.

For comprehensive guides on OpenCRVS development setup, infrastructure configuration, and deployment options, please refer to the **[Official Documentation](https://documentation.opencrvs.org/)**.


## Repository Content

#### `charts/`
Contains Helm charts for deploying OpenCRVS and its dependencies on Kubernetes. Each chart is a self-contained package with its own `README.md`, `values.yaml`, and templates. These charts define the complete application stack including microservices, databases, backup and restore workflows, and supporting observability solutions based on the ELK stack.

#### `examples/`
Provides ready-to-use example configurations for local deployment scenarios. Each example includes custom `values.yaml` files demonstrating best practices for specific use cases. Use these as starting points for your own deployments.

#### `tilt/`
Houses Tilt-specific helper scripts, extensions, and configuration modules used by the main `Tiltfile`. These scripts automate common development tasks such as managing Kubernetes resources, OpenCRVS configuration, data cleanup, and seeding.

#### `Tiltfile`
The main entry point for Tilt-based local development. This file orchestrates the entire local development environment, defining how services are built and deployed. Running `tilt up` uses this file to spin up the complete OpenCRVS stack locally.
