# XCP-ng Debian Packer Build and Terraform Deployment

This repository contains the necessary files for automating the deployment of a Debian server template using **Packer** and managing infrastructure with **Terraform**.

## Overview

This project uses **Packer** to create a Debian server template and **Terraform** to deploy the server. The following files are included:

1. **`main.tf`** (Terraform): A Terraform configuration file to deploy a Debian-based server on your chosen cloud provider or virtualization platform.
2. **`preseed.cfg`** (Packer): A preseed file used by Packer to automate the installation of Debian on a virtual machine.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- **Terraform**: Version 0.12 or higher
- **Packer**: Version 1.7 or higher
- Access to a cloud provider (AWS, GCP, Azure) or a local virtualization platform (e.g., VirtualBox, VMware)

## Getting Started

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/wezke/XCP_ng-Debian-packer-build.git
cd XCP_ng-Debian-packer-build
