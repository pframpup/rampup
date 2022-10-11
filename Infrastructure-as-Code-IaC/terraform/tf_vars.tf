
variable "itype" {
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  type        = string
  default     = "ami-018d291ca9ffc002f"
  description = "amzn2-ami-kernel-5.10-hvm-2.0.20220805.0-x86_64-gp2"
}

variable "vpc" {
  type = string
  default = "vpc-0d2831659ef89870c"
}

variable "ami" {
  type = string
  default = "ami-018d291ca9ffc002f"
}

variable "subnet_private-1" {
  type = string
  default = "subnet-038fa9d9a69d6561e" //ramp_up_training-private-1
}
variable "subnet_public-1" {
  type = string
  default = "subnet-055c41fce697f9cca" //ramp_up_training-public-1
}

variable "subnet_private-0" {
  type = string
  default = "subnet-0d74b59773148d704" //ramp_up_training-private-0
}
variable "subnet_public-0" {
  type = string
  default = "subnet-0088df5de3a4fe490" //ramp_up_training-public-0
}

variable "region" {
  type = string
  description = "region for aws resources"
  default = "us-west-1"
}

variable "fake_domain_authapi" {
  type = string
  default = "authapix.com"
}
variable "fake_domain_usersapi" {
  type = string
  default = "usersapix.com"
}
variable "fake_domain_todosapi" {
  type = string
  default = "todosapix.com"
}
variable "fake_domain_logmessageprocessor" {
  type = string
  default = "logmessageprocessorx.com"
}
variable "fake_domain_redisdatabase" {
  type = string
  default = "redisdatabasex.com"
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "tag_project" {
  type = string
  description = "tag project for aws resources"
  default = "ramp-up-devops"
}

variable "tag_responsible" {
  type = string
  description = "tag responsible for aws resources"
  default = "diego.puentes"
}

variable "machine_names" {
  description = "Create ec2 instaces with these names"
  type        = list(string)
  default     = ["redis", "go-java", "python-nodejs"]
}

variable "machine_user_data" {
  description = "user data for ec2 instaces. Depends on machine_names order"
  type        = list(string)
  default     = ["IyEvYmluL2Jhc2gKc2V0IC1leAp5dW0gLXkgdXBkYXRlICYmIHN1ZG8geXVtIC15IHVwZ3JhZGUKeXVtIC15IGdyb3VwIGluc3RhbGwgIkRldmVsb3BtZW50IFRvb2xzIgppZiBbICEgJChjb21tYW5kIC12IHJlZGlzLXNlcnZlcikgXTsgdGhlbgogIHl1bSAteSBpbnN0YWxsIHRjbAogIHdnZXQgLU4gaHR0cHM6Ly9kb3dubG9hZC5yZWRpcy5pby9yZWRpcy1zdGFibGUudGFyLmd6CiAgdGFyIC16eHZmIHJlZGlzLXN0YWJsZS50YXIuZ3oKICBjZCAkKHB3ZCkvcmVkaXMtc3RhYmxlLwogIG1ha2UKICBtYWtlIHRlc3QKICBtYWtlIGluc3RhbGwKZmkKc3UgZWMyLXVzZXIgLWMgICdub2h1cCAvdXNyL2xvY2FsL2Jpbi9yZWRpcy1zZXJ2ZXIgLS1wcm90ZWN0ZWQtbW9kZSBubyAmJw==", "IyEvYmluL2Jhc2gKc2V0IC1leAp5dW0gLXkgdXBkYXRlICYmIHN1ZG8geXVtIC15IHVwZ3JhZGUKeXVtIC15IGdyb3VwIGluc3RhbGwgIkRldmVsb3BtZW50IFRvb2xzIgppZiBbICEgJChjb21tYW5kIC12IGdvKSBdOyB0aGVuCiB3Z2V0IC1OIGh0dHBzOi8vZ28uZGV2L2RsL2dvMS4xOC4yLmxpbnV4LWFtZDY0LnRhci5negogdGFyIC1DIC91c3IvbG9jYWwgLXh6ZiAkKHB3ZCkvZ28xLjE4LjIubGludXgtYW1kNjQudGFyLmd6CiBlY2hvIC1lICdleHBvcnQgR09QQVRIPSRIT01FL2dvJyA+PiAvaG9tZS9lYzItdXNlci8uYmFzaF9wcm9maWxlCiBlY2hvIC1lICdleHBvcnQgUEFUSD0kUEFUSDovdXNyL2xvY2FsL2dvL2JpbjokR09QQVRIL2JpbicgPj4gL2hvbWUvZWMyLXVzZXIvLmJhc2hfcHJvZmlsZQogZWNobyAtZSAnZXhwb3J0IEdPMTExTU9EVUxFPW9uJyA+PiAvaG9tZS9lYzItdXNlci8uYmFzaF9wcm9maWxlCiBzb3VyY2UgL2hvbWUvZWMyLXVzZXIvLmJhc2hfcHJvZmlsZQpmaQp5dW0gLXkgaW5zdGFsbCBqYXZhLTEuOC4wLW9wZW5qZGstZGV2ZWwKX2Q9Ii9ob21lL2VjMi11c2VyIgppZiBbICEgLWQgJF9kL21pY3Jvc2VydmljZS1hcHAtZXhhbXBsZSBdOyB0aGVuCiBjZCAkX2QKIGdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vYm9ydGl6Zi9taWNyb3NlcnZpY2UtYXBwLWV4YW1wbGUuZ2l0CmZpCmNkICRfZC9taWNyb3NlcnZpY2UtYXBwLWV4YW1wbGUvYXV0aC1hcGkKZ28gYnVpbGQgLWJ1aWxkdmNzPWZhbHNlCnNjcmVlbiAtUyBhdXRoLWdvIC1kIC1tIGJhc2ggLWMgJ0pXVF9TRUNSRVQ9UFJGVCBBVVRIX0FQSV9QT1JUPTgwMDAgVVNFUlNfQVBJX0FERFJFU1M9aHR0cDovLzEyNy4wLjAuMTo4MDgzIC4vYXV0aC1hcGknCmNkICRfZC9taWNyb3NlcnZpY2UtYXBwLWV4YW1wbGUvdXNlcnMtYXBpCi4vbXZudyBjbGVhbiBpbnN0YWxsCnNjcmVlbiAtUyB1c2Vycy1qYXZhIC1kIC1tIGJhc2ggLWMgJ0pXVF9TRUNSRVQ9UFJGVCBTRVJWRVJfUE9SVD04MDgzIGphdmEgLWphciB0YXJnZXQvdXNlcnMtYXBpLTAuMC4xLVNOQVBTSE9ULmphcic=", "IyEvYmluL2Jhc2gKc2V0IC1leAp5dW0gLXkgdXBkYXRlICYmIHN1ZG8geXVtIC15IHVwZ3JhZGUKeXVtIC15IGdyb3VwIGluc3RhbGwgIkRldmVsb3BtZW50IFRvb2xzIgppZiBbICEgJChjb21tYW5kIC12IHBpcDMpIF07IHRoZW4KICB5dW0gLXkgaW5zdGFsbCBweXRob24tcGlwCiAgeXVtIC15IGluc3RhbGwgcHl0aG9uMy1waXAKICB5dW0gLXkgaW5zdGFsbCB6bGliMWctZGV2CiAgeXVtIC15IGluc3RhbGwgbGlicmVhZGxpbmUtZ3BsdjItZGV2IGxpYm5jdXJzZXN3NS1kZXYgbGlic3NsLWRldiBsaWJzcWxpdGUzLWRldiB0ay1kZXYgbGliZ2RibS1kZXYgbGliYzYtZGV2IGxpYmJ6Mi1kZXYKICBwaXAzIGluc3RhbGwgd2hlZWwKZmkKaWYgWyAhICQoY29tbWFuZCAtdiBweXRob24zLjYpIF07IHRoZW4KICBjZCAvb3B0LwogIGN1cmwgLUxPIGh0dHBzOi8vd3d3LnB5dGhvbi5vcmcvZnRwL3B5dGhvbi8zLjYuMy9QeXRob24tMy42LjMudGd6CiAgdGFyIC16eHZmIFB5dGhvbi0zLjYuMy50Z3oKICBjZCBQeXRob24tMy42LjMKICAuL2NvbmZpZ3VyZSAtLWVuYWJsZS1zaGFyZWQKICBtYWtlCiAgbWFrZSBpbnN0YWxsCmZpCl9kPS9ob21lL2VjMi11c2VyCmlmIFsgISAkKGNvbW1hbmQgLXYgbm9kZSkgXTsgdGhlbgogIGNkICRfZAogIGN1cmwgLUxPIGh0dHBzOi8vbm9kZWpzLm9yZy9kb3dubG9hZC9yZWxlYXNlL3Y4LjE3LjAvbm9kZS12OC4xNy4wLWxpbnV4LXg2NC50YXIuZ3oKICB0YXIgLXh2emYgbm9kZS12OC4xNy4wLWxpbnV4LXg2NC50YXIuZ3oKICBjZCBub2RlLXY4LjE3LjAtbGludXgteDY0LwogIGxuIC1zICQocHdkKS9iaW4vbm9kZSAvYmluL25vZGUKICBsbiAtcyAkKHB3ZCkvYmluL25wbSAvYmluL25wbQogIGxuIC1zICQocHdkKS9iaW4vbnB4IC9iaW4vbnB4CmZpCmlmIFsgISAtZCAkX2QvbWljcm9zZXJ2aWNlLWFwcC1leGFtcGxlIF07IHRoZW4KIGNkICRfZAogZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9ib3J0aXpmL21pY3Jvc2VydmljZS1hcHAtZXhhbXBsZS5naXQKZmkKY2QgJF9kL21pY3Jvc2VydmljZS1hcHAtZXhhbXBsZS9sb2ctbWVzc2FnZS1wcm9jZXNzb3IvCnBpcDMgaW5zdGFsbCAtciByZXF1aXJlbWVudHMudHh0ClJFRElTX0hPU1Q9MTAuMS45My4xOTggUkVESVNfUE9SVD02Mzc5IFJFRElTX0NIQU5ORUw9bG9nX2NoYW5uZWwgc2NyZWVuIC1TIGxvZ21lcy1weXRob24gLWQgLW0gYmFzaCAtYyAncHl0aG9uMyBtYWluLnB5JwpjZCAkX2QvbWljcm9zZXJ2aWNlLWFwcC1leGFtcGxlL3RvZG9zLWFwaS8KbnBtIGluc3RhbGwKSldUX1NFQ1JFVD1QUkZUIFRPRE9fQVBJX1BPUlQ9ODA4MiBzY3JlZW4gLVMgdG9kby1ub2RlanMgLWQgLW0gYmFzaCAtYyAnbnBtIHN0YXJ0Jw=="]
}