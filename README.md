# Prerequisites

## VM Hardware Requirements

- 8 GB of RAM (Preferably 16 GB)
- 50 GB Disk space

## Chocolatey

Download and Install Chocolatey Windows package manager [chocolatey](https://docs.chocolatey.org/en-us/choco/setup)


## Vagrant

Vagrant provides an easier way to deploy multiple virtual machines on VirtualBox more consistently.

Install Vagrant using Chocolatey:

```shell
choco install vagrant
```

## VirtualBox
Virtualbox will be used as a provider: 

```shell
choco install virtualbox
choco list
```


## Vagrant IaaC workflow: 
   1. Scope (Infra, folders)
   2. vagrant init
   3. vagrant up 
   4. vagrant ssh
   4. vagrant halt 
   5. vagrant reload 
   6. vagrant destroy

Read more from [vagrant documentation.](https://developer.hashicorp.com/vagrant/docs)