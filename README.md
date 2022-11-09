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

![image](https://github.com/pframpup/rampup/blob/develop/Infrastructure-as-Code-IaC/aws-diagram2.png?raw=true)

### Configuration management tools

Configuration management tools enable changes and deployments to be faster, repeatable, scalable, predictable, and able to maintain the desired state, which brings controlled assets into an expected state.

Some advantages of using configuration management tools include:

- Adherence to coding conventions that make it easier to navigate code
- Idempotency, which means that the end state remains the same, no matter how many times the code is executed
- Distribution design to improve managing large numbers of remote servers

In this case it was used Ansible. Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your applications—automate in a language that approaches plain English, using SSH, with no agents to install on remote systems.

### CI / CD

IT was used Jenkins because, Jenkins is an open source automation server that helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.

![image](https://github.com/pframpup/rampup/blob/develop/Infrastructure-as-Code-IaC/CI-Jenkins.png?raw=true)

