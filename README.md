# Kubernetes Basics
> Getting up and running and learning Kubernetes and its associated DevOps tools

<img src="images/Kubernetes-training-in-Hyderabad.jpeg" width="600" height="300" align="center" />

---

## Container Bootcamp

### Overview

Welcome to the Container Bootcamp! This bootcamp is designed to get you up and running with containerization technologies, starting with the basics and moving to advanced topics. By the end of this bootcamp, you'll have hands-on experience with Docker, Kubernetes, Kustomize, Helm, and GitOps with Flux.

---

## Prerequisites

- Basic knowledge of Linux/Unix commands
- Familiarity with programming concepts
- A computer with Docker and Kubernetes installed (installation guidance will be provided)

---

## Curriculum

### Module 1: Docker Basics

#### Goals:
- [Understand what containerization is](https://docs.docker.com/get-started/overview/)
- [Learn basic Docker commands](https://docker-curriculum.com/)
- [Build your first Docker container](https://docs.docker.com/language/java/build-images/)


#### Containerization Overview

Containerization is a technology that encapsulates an application and its dependencies into a "container." This allows the application to be run consistently across various computing environments. Containers have become a cornerstone in DevOps practices due to their portability and lightweight nature.


#### OCI Images

The Open Container Initiative (OCI) is an industry standards organization that has provided specifications for container images and runtimes. OCI images are a flexible and interoperable format for container images, enabling seamless portability across different runtime environments.

- **OCI Image Specification:** Defines the schema for container images, including layers, metadata, and more.
- **OCI Runtime Specification:** Describes the runtime configuration required to run a containerized application.

Docker images are generally compatible with the OCI standard, meaning they can be used interchangeably in systems that support OCI images.

#### Docker as a Container Runtime

Docker is one of the most popular container runtimes and has become synonymous with containerization. It allows you to easily build, ship, and run containers. Docker uses its own image format but is also compatible with OCI images, making it a versatile choice for containerization.

- **Docker Daemon:** The background service running on the host that manages building, running, and distributing Docker containers.
- **Docker CLI:** The command-line interface that allows users to interact with Docker.
- **Docker Hub:** A cloud-based registry service where you can link to code repositories, build images, and share them with others.


#### Using Docker in Your Workflow

You'll be primarily using Docker for containerization in your workflow. Docker makes it easy to package your applications into containers, manage those containers, and then deploy them anywhere you need to.

1. **Installation:** First, ensure Docker is installed on your development machine.
2. **Building Images:** Use a `Dockerfile` to build an image for your application.
    ```Dockerfile
    # Use an official Python runtime as a parent image
    FROM python:3.7-slim
    
    # Set working directory
    WORKDIR /app
    
    # Install application dependencies
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    
    # Copy the current directory contents
    COPY . .
    
    # Run app.py when the container launches
    CMD ["python", "app.py"]
    ```
3. **Running Containers:** Run a container based on your image.
    ```bash
    docker run -p 4000:80 my-image
    ```


#### Accessing the Docker Container

Once the container is up and running, it's available to access via the web browser and command-line tools like `curl` and `wget`. In the example Docker command above, we mapped port 4000 on the host to port 80 on the container. Here's how to access the application:

- **Via Web Browser:** Open your web browser and navigate to `http://localhost:4000`. This should display the application's home page.

- **Via Command-Line:**
    - Using `curl`:
      ```bash
      curl http://localhost:4000
      ```
    - Using `wget`:
      ```bash
      wget http://localhost:4000
      ```

Note: Make sure to replace `4000` with the host port you have configured while running the Docker container.

#### Assignments:
Skip the github actions and CI/CD for now
1. [Python-based Application Container](https://docs.docker.com/language/python/)
2. [Java-based Application Container](https://docs.docker.com/language/java/build-images/)
3. See Jay for a small Java based task with one of our containers. We will want to get you a simple feel for how we create our micro services.

---

### Module 2: Kubernetes Essentials

#### Goals:
- Understand Kubernetes architecture and components
- Deploy applications using YAML files
- Request storage with Persistent Volume Claims (PVC)
- Manage application configuration with ConfigMaps and Secrets

Absolutely, let's add the requested sections to the existing content.


#### Kubernetes Overview

Kubernetes is an open-source container orchestration platform that automates many of the manual processes involved in deploying, managing, and scaling containerized applications. At a high level, Kubernetes helps you ensure that your services and applications meet your desired state, such as keeping services available and scalable.


#### Architecture Basics

In Kubernetes, the architecture is primarily divided into two components: the Control Plane and the Worker Nodes.

- **Control Plane:** This is the brain behind Kubernetes, responsible for maintaining the desired state of the cluster. Components like the API Server, etcd, Scheduler, and Controller Manager form the Control Plane.
    - **API Server:** Exposes the Kubernetes API and acts as the frontend for the control plane.
    - **etcd:** Distributed key-value store used to save all cluster data.
    - **Scheduler:** Places containers based on resource availability.
    - **Controller Manager:** Ensures the desired state is maintained.

- **Worker Nodes:** These are the machines where your containers will run. Each worker node contains:
    - **Kubelet:** An agent to communicate with the Control Plane.
    - **Container Runtime:** Software for running containers (e.g., Docker).
    - **Kube-proxy:** Manages network rules and enables service abstraction.


#### Request a vCluster

If you don't have access to a Kubernetes cluster, you'll likely need to request a virtual cluster (vCluster) from someone in your organization. You may want to reach out to Jamie for this. A vCluster allows you to have an isolated environment within the main Kubernetes cluster, which is great for development and testing purposes.

#### Installing `kubectl`

The Kubernetes Command-Line Tool, `kubectl`, allows you to interact with your Kubernetes cluster. It's essential for deploying and managing applications, inspecting cluster resources, and viewing logs.

1. **Install on Linux:**
    ```bash
    curl -LO https://dl.k8s.io/release/v1.24.16/bin/linux/amd64/kubectl
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    ```
    This will download version `v1.24.16` of `kubectl`, make it executable, and move it to `/usr/local/bin/` so it's in your path.

2. **Verify Installation:**
    Confirm that `kubectl` is installed correctly by running the following command to get the version:
    ```bash
    kubectl version --client
    ```

3. **Set Up Autocompletion:**
    To enable shell autocompletion for `kubectl`:
    ```bash
    # For bash users
    source <(kubectl completion bash)
    
    # For zsh users
    source <(kubectl completion zsh)
    ```

#### Extracting KubeConfig from Rancher

Once you have access to a cluster through Rancher, obtaining the KubeConfig file is generally straightforward:

1. Log into Rancher.
2. Navigate to your specific cluster by clicking on its name.
3. Once inside the cluster dashboard, look for a "KubeConfig File" option, often located under the "Cluster" menu.
4. Click to download the KubeConfig file, which you can then use to interact with your Kubernetes cluster via `kubectl`.

You'll get into more details about Rancher later, but this should be sufficient to get you started with obtaining your KubeConfig file.


### Understand KubeConfig File

The KubeConfig file is crucial for setting up the communication between your local machine and the Kubernetes cluster. It contains information like cluster details, user details, and namespaces. By default, the KubeConfig file is located in your home directory under `~/.kube/config`.

#### Key Components:

- `apiVersion` & `kind`: Indicates the version and type of the configuration.
- `clusters`: Contains information about the clusters and their addresses.
- `contexts`: Helps in setting up the environment to talk to a particular cluster as a specific user and within a specific namespace.
- `users`: User details including the authentication methods supported.
- `current-context`: Specifies which context should be used by default.

#### Example KubeConfig:

```yaml
apiVersion: v1  # API version
kind: Config    # Kind of the object
clusters:       # Cluster information
- name: my-cluster
  cluster:
    server: http://localhost:8080
contexts:       # Context information
- name: my-context
  context:
    cluster: my-cluster
    user: me
users:          # User information
- name: me
  user:
    password: secret
current-context: my-context  # Current context in use
```

#### Understand Kubernetes Objects and Resources

Kubernetes objects are the fundamental entities that make up a Kubernetes cluster. They represent the state of the cluster and provide the specifications required to run applications or services.

##### Key Kubernetes Objects:

- Pods
- Services
- ConfigMaps
- Secrets
- Deployments
- StatefulSets
- DaemonSets
- Jobs & CronJobs

##### Pods

A Pod is the smallest deployable unit in Kubernetes and can contain one or more containers.

```yaml
apiVersion: v1  # API version
kind: Pod       # Kind of the object
metadata:       # Metadata like name, labels
  name: my-pod
spec:           # Specifications like containers
  containers:
  - name: my-container
    image: nginx
```

##### Services

A Service is an abstraction to expose applications running on a set of Pods.

```yaml
apiVersion: v1  # API version
kind: Service   # Kind of the object
metadata:       # Metadata like name, labels
  name: my-service
spec:           # Specifications like selector and ports
  selector:
    app: MyApp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 9376
```

##### ConfigMaps

ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable.

```yaml
apiVersion: v1        # API version
kind: ConfigMap       # Kind of the object
metadata:             # Metadata like name, labels
  name: my-configmap
data:                 # Actual data
  key1: value1
  key2: value2
```

##### Secrets

Secrets are used to store sensitive information like passwords or API keys.

```yaml
apiVersion: v1   # API version
kind: Secret     # Kind of the object
metadata:        # Metadata like name, labels
  name: my-secret
type: Opaque     # Type of the secret
data:            # Encoded data (base64)
  password: c2VjcmV0
```

##### Deployments

Deployments are used to manage multiple replicas of a Pod for high availability.

```yaml
apiVersion: apps/v1  # API version
kind: Deployment     # Kind of the object
metadata:            # Metadata like name, labels
  name: my-deployment
spec:                # Specifications like replicas, template
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: my-image
```

##### StatefulSets

StatefulSets are used for managing stateful applications.

```yaml
apiVersion: apps/v1   # API version
kind: StatefulSet     # Kind of the object
metadata:             # Metadata like name, labels
  name: web
spec:                 # Specifications like serviceName, replicas, template
  serviceName: "nginx"
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: k8s.gcr.io/nginx-slim:0.8
```

##### DaemonSets

DaemonSets are used to ensure that some or all nodes run a copy of a Pod.

```yaml
apiVersion: apps/v1   # API version
kind: DaemonSet       # Kind of the object
metadata:             # Metadata like name, labels
  name: my-daemonset
spec:                 # Specifications like selector, template
  selector:
    matchLabels:
      name: my-daemonset
  template:
    metadata:
      labels:
        name: my-daemonset
    spec:
      containers:
      - name: my-daemonset-container
        image: my-daemonset-image
```

##### Jobs & CronJobs

Jobs create one or more Pods and ensure that a specified number of them successfully terminate.

```yaml
apiVersion: batch/v1  # API version
kind: Job             # Kind of the object
metadata:             # Metadata like name, labels
  name: my-job
spec:                 # Specifications like template, restartPolicy
  template:
    spec:
      containers:
      - name: my-container
        image: my-job-image
      restartPolicy: OnFailure
```

CronJobs manage time-based Jobs.

```yaml
apiVersion: batch/v1beta1  # API version
kind: CronJob              # Kind of the object
metadata:                  # Metadata like name, labels
  name: my-cronjob
spec:                      # Specifications like schedule, jobTemplate
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: my-cronjob-container
            image: my-cronjob-image
          restartPolicy: OnFailure
```

##### Learn About the Object YAML Structure

Kubernetes objects are often defined in YAML files. Understanding the YAML structure helps in defining and managing these objects efficiently.

##### YAML Components:

- `apiVersion`: Specifies the API version to use.
- `kind`: The kind of object to create.
- `metadata`: Meta-information like name, labels, and namespaces.
- `spec`: The specification containing details like containers, volumes, etc.

### Assignments:
1. [Deploying Your First Pod](link-to-guide)
2. [Working with PVCs](link-to-guide)
3. [Using ConfigMaps and Secrets](link-to-guide)

---

### Module 3: Kustomize Essentials

#### Goals:
- Understand the role of Kustomize in Kubernetes
- Customize Kubernetes manifests using Kustomize
- Use overlays and variables in Kustomize
- Implement best practices with Kustomize

#### Kustomize Overview

Kustomize is a standalone tool to customize Kubernetes manifests through a kustomization file. It provides a template-free way to customize application configuration that simplifies the use of off-the-shelf applications. It's also included in `kubectl` as of v1.14, which means you can use `kubectl kustomize` to run your kustomizations.

#### Installing `kustomize`

Kustomize can be installed as a standalone CLI tool. Below are the generic Linux installation instructions for version `5.1.1`:

1. **Install on Linux:**
    ```bash
    kustomize_version=5.1.1
    wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${kustomize_version}/kustomize_v${kustomize_version}_linux_amd64.tar.gz
    tar xfz kustomize_v${kustomize_version}_linux_amd64.tar.gz
    sudo mv kustomize /usr/bin/
    rm -rf kustomize_v${kustomize_version}_linux_amd64.tar.gz
    ```
    This will download version `5.1.1` of `kustomize`, extract it, move it to `/usr/bin/`, and clean up the tarball.

2. **Verify Installation:**
    Confirm that `kustomize` is installed correctly by running the following command to get the version:
    ```bash
    kustomize version
    ```

#### Basics of Kustomization

The core concept in Kustomize is a `kustomization.yaml` file. This file allows you to define customizations and then build a new Kubernetes manifest based on that.

##### Example Kustomization File:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - deployment.yaml

patchesStrategicMerge:
  - patch.yaml
```

In this example, `resources` specify the original manifests, and `patchesStrategicMerge` specifies the patches to apply. Kustomize then merges the original and the patch to produce a final manifest.

#### Overlays and Variables

Kustomize allows you to have different "overlays" for different environments like development, staging, and production.

##### Example Overlay:

```yaml
# staging/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../base

patchesStrategicMerge:
  - replica_count.yaml
```

You can also use variables to replace fields dynamically.

##### Example Variable Usage:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - deployment.yaml

vars:
  - name: DOMAIN
    objref:
      apiVersion: apps/v1
      kind: Deployment
      name: my-deployment
    fieldref:
      fieldpath: metadata.name
```

#### Best Practices with Kustomize

1. **Keep Base and Overlays Separate:** Maintain a separate base directory and overlay directories for different environments.
2. **Version Control:** Keep your kustomization files and overlays in version control systems for tracking changes.
3. **Minimal Patches:** Use minimal patches to reduce conflicts and make it easier to rebase your customizations on updated upstream manifests.

### Assignments:
1. [Customizing a Deployment with Kustomize](link-to-guide)
2. [Managing Multiple Environments with Overlays](link-to-guide)
3. [Advanced Kustomize Techniques](link-to-guide)


---

### Module 4: Helm Essentials

#### Goals:
- Understand the role of Helm in Kubernetes
- Learn to manage Kubernetes applications with Helm charts
- Learn Helm basics such as creating and deploying charts
- Implement best practices with Helm

#### Helm Overview

Helm is a package manager for Kubernetes that allows developers and operators to more easily package, configure, and deploy applications and services onto Kubernetes clusters. Helm uses a packaging format called "charts," which are a collection of files that describe a related set of Kubernetes resources.

#### Installing Helm

Installing Helm involves a straightforward process. Below are the generic Linux installation instructions for version `3.12.3`:

1. **Install on Linux:**
    ```bash
    helm_version=3.12.3
    curl -fOL https://get.helm.sh/helm-v$helm_version-linux-amd64.tar.gz
    tar xfz helm-v$helm_version-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /bin/helm
    rm -rf linux-amd64/ helm-v$helm_version-linux-amd64.tar.gz
    ```
    This will download version `3.12.3` of Helm, extract it, move it to `/bin/helm`, and clean up the tarball.

2. **Verify Installation:**
    Confirm that Helm is installed correctly by running the following command to get the version:
    ```bash
    helm version
    ```

#### Helm Basics: Charts, Repositories, and Releases

1. **Charts:** A Helm chart is a package of pre-configured Kubernetes resources. It is a collection of YAML templates filled with variables that will be replaced with real values when a chart is installed.

2. **Repositories:** Helm charts can be stored and shared through Helm chart repositories. The default repository for Helm is the Helm Hub, but you can also create your own.

3. **Releases:** When you deploy a chart into a Kubernetes cluster, that deployment is called a "release."

#### Deploying a Helm Chart

To deploy a Helm chart, you typically perform the following steps:

1. **Add the repository:**
    ```bash
    helm repo add [repo_name] [repo_url]
    ```

2. **Update the repository:**
    ```bash
    helm repo update
    ```

3. **Install the chart:**
    ```bash
    helm install [release_name] [chart_name]
    ```

#### Best Practices with Helm

1. **Parameterize:** Use Helm values to parameterize your applications for different environments.

2. **Use Helm Hooks:** Helm hooks allow you to manage the lifecycle of your application more effectively.

3. **Version Control:** Like with Kustomize, keep your Helm charts and values in version control for tracking.

### Assignments:
1. [Getting Started with Helm Charts](link-to-guide)
2. [Managing Helm Repositories](link-to-guide)
3. [Creating Your Own Helm Chart](link-to-guide)

---

### Module 5: Working with SOPS for Secret Management

#### Goals:
- Understand the importance of secret management in Kubernetes
- Learn what SOPS is and how it works
- Use SOPS for encrypting, decrypting, and editing secrets
- Integrate SOPS with Kubernetes for managing secrets

#### Overview of SOPS

SOPS (Secrets OPerationS) is an editor of encrypted files that supports YAML, JSON, ENV, INI and BINARY formats and encrypts with AWS KMS, Azure Key Vault, GCP KMS, and more. It's particularly useful for storing secrets in a secure manner and integrating them into your Kubernetes cluster.

#### Installing SOPS

Installing SOPS is straightforward, and you can use package managers to facilitate the process. Here are the generic Linux installation instructions for version `3.7.3`:

1. **Install on Linux using RPM:**
    ```bash
    sops_version=3.7.3
    rpm -i https://github.com/mozilla/sops/releases/download/v${sops_version}/sops-${sops_version}-1.x86_64.rpm
    ```
    This will download version `3.7.3` of SOPS and install it using the RPM package manager.

2. **Verify Installation:**
    To verify that SOPS is installed correctly, you can run:
    ```bash
    sops --version
    ```

#### SOPS Basics: Encryption, Decryption, and Editing

1. **Encryption:** To encrypt a file, you can simply run:
    ```bash
    sops -e my-secret.yaml > my-secret.enc.yaml
    ```

2. **Decryption:** Decrypting is as simple as:
    ```bash
    sops -d my-secret.enc.yaml > my-secret.yaml
    ```

3. **Editing:** SOPS provides an interactive editor for encrypted files:
    ```bash
    sops my-secret.enc.yaml
    ```

#### Integrating SOPS with Kubernetes

1. **Creating Encrypted Secrets:** Use SOPS to create encrypted secrets that can be stored in a VCS like Git.

2. **Deploying Secrets:** Utilize hooks or custom scripts to decrypt secrets at deploy time.

3. **Key Management:** Leverage cloud-based key management services (AWS KMS, Azure Key Vault, etc.) to manage the keys used for encryption and decryption.

#### Best Practices with SOPS

1. **Least Privilege:** Ensure only authorized personnel have access to SOPS and the keys.

2. **Version Control:** Keep your encrypted files in version control to track changes.

3. **Audit Trail:** Use key management services that provide an audit trail for key usage.

### Assignments:
1. [Getting Started with SOPS](link-to-guide)
2. [SOPS and Kubernetes: Managing Secrets Securely](link-to-guide)
3. [Key Management with SOPS](link-to-guide)

By the end of this module, you should have a good understanding of how to securely manage secrets in a Kubernetes environment using SOPS.

---

Certainly! Keeping in mind the previous modules, let's draft a more comprehensive Module 6 that introduces Flux and Continuous Integration/Continuous Deployment (CI/CD) concepts, while also explaining how to install Flux.

---

## Module 6: Installing and Using Flux for CI/CD in Kubernetes

### Introduction

In this module, you will learn how to install and use Flux v2, a tool for GitOps-based Continuous Integration/Continuous Deployment (CI/CD) in Kubernetes. We'll also touch upon the basic principles of CI/CD to give you a broader understanding of how Flux fits into the development lifecycle.

### Prerequisites

- A working Kubernetes cluster (Module 2)
- `kubectl` installed (Module 2)
- Basic knowledge of Helm (Module 4)
- Familiarity with SOPS for secret management (Module 5)

### What is CI/CD?

CI/CD stands for Continuous Integration and Continuous Deployment. It's a software development practice where developers regularly merge their changes back to the main branch (Continuous Integration). After that, automated scripts compile, test, and deploy the new changes to production, ensuring a streamlined and automated deployment process (Continuous Deployment).

### Installing Flux

To install Flux on your system, run the following command:

```bash
curl -s https://fluxcd.io/install.sh | bash
```

This will install the latest version of Flux v2 on your system. Confirm the installation by running:

```bash
flux check --pre
```

### Initial Configuration with Flux

Now, let's configure Flux to monitor a Git repository. The repository will contain your Kubernetes manifests, which Flux will automatically apply to your cluster.

Run the following command, replacing `<your-repo>` with the URL of your repository:

```bash
flux bootstrap github --repository=<your-repo> --owner=<your-github-username> --path=clusters/my-cluster
```

### Integrate SOPS for Secret Management

Since you have SOPS installed (as covered in Module 5), you can use it to encrypt your Kubernetes Secrets. Flux can decrypt these secrets before applying them to the cluster.

First, create a Kustomization object that tells Flux to decrypt secrets:

```bash
flux create kustomization my-kustomization \
  --source=GitRepository/my-repo \
  --path="./path-in-repo" \
  --prune=true \
  --interval=10m \
  --decryption-provider=sops \
  --decryption-secret=my-sops-key
```

Replace `GitRepository/my-repo`, `path-in-repo`, and `my-sops-key` with your specific settings.

### Conclusion

In this module, you learned about the basics of CI/CD and how to set up Flux for CI/CD in a Kubernetes environment. Flux will now monitor your designated Git repository and automatically apply changes to your Kubernetes cluster, decrypting secrets with SOPS as necessary.

---

Adding the specific project name and instructing students to consult a teammate for the ticket number will help clarify where to find the relevant information for the final project. Here's how you might update the section with these details:

---

Certainly, here's the revised section:

---

### Final Project: Apply Your Skills on Our Project

In this final project, you will have the opportunity to apply all the skills and knowledge you've gained throughout this course. The project is focused on our ongoing initiative. This hands-on experience aims to solidify your understanding and give you practical experience in deploying, managing, and securing applications in a Kubernetes environment.

#### Instructions

Detailed instructions for the final project are available in our Jira board under a specific ticket number allocated for this course. Please consult a teammate to get the ticket number for the project.

To access the Jira board:
1. Log in to our Jira dashboard.
2. Navigate to the "Projects" tab.
3. Select our project from the list.
4. Use the ticket number to find the tasks, objectives, and deliverables assigned for this course's project.

#### Objectives

- Set up a CI/CD pipeline using Flux.
- Deploy a multi-service application using Helm.
- Implement secret management with SOPS.
- Customize deployments with Kustomize.
  
#### Assessment Criteria

Your project will be evaluated based on the following criteria:

- Correctness and completeness of the Kubernetes setup.
- Efficiency and readability of your YAML configurations.
- Successful deployment and functionality of the application.
- Implementation of best practices and security measures.

Good luck, and may your pods be ever running!

---

## Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Kustomize Documentation](https://kubernetes-sigs.github.io/kustomize/)
- [Helm Documentation](https://helm.sh/docs/)
- [Flux Documentation](https://fluxcd.io/docs/)
