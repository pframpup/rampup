# Rampup - training

## Vagrant

The approaches depends of the numbers of machines, mayor number of machines more expensive will be. In this case, the use of three machines was proposed, due to the hardware that the local machine has.

- Machine1: 192.168.56.10: 
  - Auth.api
  - Users-api

- Machine2: 192.168.56.11
  - Redis

- Machine3: 192.168.56.12
  - TODOs-api
  - log-message-processor
  - Frontend

### Vagrant scripts

it was necessary to create a Vagrant script to deploy the three machines with their respective options per machine. For that, the provision option was used to execute the necessary scripts


## Git Strategy

Git flow.  It offers maximum development speed with minimum formality feature branches.  It's faster and you can add user value. It doesn't need to much ceremony.

### Standard Commit message
Example:

docs: update README file:  

**type**  **Message**



| type | description |
|--|--|
|feat:| (new feature for the user, not a new feature for build script)|
|fix: |(bug fix for the user, not a fix to a build script)|
|docs: |(changes to the documentation)|
|style:| (formatting, missing semi colons, etc; no production code change)|
|refactor:| (refactoring production code, eg. renaming a variable)|
|test:| (adding missing tests, refactoring tests; no production code change)|
|chore: | (updating grunt tasks etc; no production code change)|


## Infrastructure as Code 

In this case it was neccesary to choose terraform, because it can interoperate in various Cloud technologies like AWS, Azure, Digital Ocean etcetera.

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure.

### AWS EC2 Diagram

![image](https://github.com/pframpup/rampup/blob/develop/Infrastructure-as-Code-IaC/aws-diagram1.png?raw=true)

