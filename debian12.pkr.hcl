packer {
  required_plugins {
    xenserver = {
      version = "= v0.7.3"
      source  = "github.com/ddelnano/xenserver"
    }
  }
}

variable "remote_host" {
  type        = string
  description = "The ip or fqdn of your XCP-ng. It must be the master"
  sensitive   = true
  default     = "youre xcp master server ip"
}

variable "remote_username" {
  type        = string
  description = "The username used to interact with your XCP-ng"
  sensitive   = true
  default     = "root"
}

variable "remote_password" {
  type        = string
  description = "The password used to interact with your XCP-ng"
  sensitive   = true
  default     = "your master server admin password"
}

variable "sr_iso_name" {
  type        = string
  description = "The ISO-SR to packer will use"
  default     = "ISO"
}

variable "sr_name" {
  type        = string
  description = "The name of the SR to packer will use"
  default     = "Local storage"
}

source "xenserver-iso" "debian12" {
  iso_checksum = "ee8d8579128977d7dc39d48f43aec5ab06b7f09e1f40a9d98f2a9d149221704a"
  iso_url      = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.10.0-amd64-netinst.iso"

  sr_iso_name    = var.sr_iso_name
  sr_name        = var.sr_name
  tools_iso_name = ""

  remote_host     = var.remote_host
  remote_password = var.remote_password
  remote_username = var.remote_username

  http_directory = "http"  # Ensure that the preseed.cfg is in this directory
  ip_getter      = "tools"

  boot_command = [
    "<wait><wait><wait><esc><wait><wait><wait>",
    "/install.amd/vmlinuz ",
    "initrd=/install.amd/initrd.gz ",
    "auto=true ",
    "domain= ",
    "url=http://{{.HTTPIP}}:{{.HTTPPort}}/preseed.cfg ",
    "hostname=debian ",
    "interface=auto ",
    "vga=788 noprompt quiet<enter>"
  ]

  # Removed clone_template as you are using an ISO
  vm_name         = "Debian 12 template"
  vm_description  = "My first template with packer"
  vcpus_max       = 2
  vcpus_atstartup = 2
  vm_memory       = 2048 #MB
  network_names   = ["eth0"]
  disk_size       = 20480  # In bytes
  disk_name       = "debian disk"
  vm_tags         = ["Generated by Packer"]

  ssh_username           = "debian"
  ssh_password           = "debian"
  ssh_wait_timeout       = "60000s"
  ssh_handshake_attempts = 10000

  output_directory = "packer-debian-12"
  keep_vm          = "never"
  format           = "xva_compressed"
}

build {
  sources = ["xenserver-iso.debian12"]
}
