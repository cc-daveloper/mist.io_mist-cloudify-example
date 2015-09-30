# Mist Cloudify Nodecellar Example

![alt text](http://img.shields.io/badge/nodecellar--local-tested-green.svg)
![alt text](http://img.shields.io/badge/nodecellar--aws--ec2-tested-green.svg)
![alt text](http://img.shields.io/badge/nodecellar--openstack-tested-green.svg)
![alt text](http://img.shields.io/badge/nodecellar--openstack--nova--net-tested-green.svg)
![alt text](http://img.shields.io/badge/nodecellar--openstack--haproxy--net-tested-green.svg)
![alt text](http://img.shields.io/badge/nodecellar--singlehost-manually--tested-yellow.svg)
![alt text](http://img.shields.io/badge/nodecellar--softlayer-tested-green.svg)
![alt text](http://img.shields.io/badge/nodecellar--cloudstack-manually--tested-yellow.svg)
![alt text](http://img.shields.io/badge/nodecellar--cloudstack--vpc-manually--tested-yellow.svg)
![alt text](http://img.shields.io/badge/nodecellar--host--pool-tested-green.svg)

This repository contains several blueprints for installing the
[nodecellar](http://coenraets.org/blog/2012/10/nodecellar-sample-application-with-backbone-js-twitter-bootstrap-node-js-express-and-mongodb/)
application.<br>
Nodecellar example consists of:

- A Mongo Database
- A NodeJS Server
- A Javascript Application

Before you begin its recommended you familiarize yourself with
[Cloudify Terminology](http://getcloudify.org/guide/3.1/reference-terminology.html).

The first thing you'll need to do is
[install the Cloudify CLI](http://getcloudify.org/guide/3.1/installation-cli.html).
<br>
This will let you run the various blueprints.

**Note: <br>Documentation about the blueprints content is located inside the blueprint files themselves.
<br>Presented here are only instructions on how to RUN the blueprints using the Cloudify CLI.**
<br><br>
**From now on, all commands will assume that the working directory is the root of this repository.**

## Blueprint using Mist run_script

[This blueprint](mist-blueprint.yaml) allows you to install the nodecellar application on a mist machine using the mist run_script. <br>
Let see how this is done:

### Step 1: Initialize

`cfy local init -p mist-blueprint.yaml -i inputs/mist.yaml` <br>

This command (as the name suggests) initializes your working directory to work with the given blueprint.
Now, you can run any type of workflows on this blueprint. <br>

### Step 2: Install

Lets run the `install` workflow: <br>

`cfy local execute -w install`

This command will install all the application components on you mist machine.
(don't worry, its all installed under the `tmp` directory)<br>
Once its done, you should be able to browse to [http://mist-machine-public-ip:8080](http://mist-machine-public-ip:8080) and see the application.
<br>


### Step 3: Uninstall

To uninstall the application we run the `uninstall` workflow: <br>

`cfy local execute -w uninstall`

## Blueprint using the cloudify-fabric-plugin

[This blueprint](mist-blueprint.yaml) allows you to install the nodecellar application on a mist machine using the mist run_script. <br>
Let see how this is done:

### Step 1: Initialize

`cfy local init -p mistfabric-blueprint.yaml -i inputs/mist.yaml` <br>

This command (as the name suggests) initializes your working directory to work with the given blueprint.
Now, you can run any type of workflows on this blueprint. <br>

### Step 2: Install

Lets run the `install` workflow: <br>

`cfy local execute -w install`

This command will install all the application components on you mist machine.
(don't worry, its all installed under the `tmp` directory)<br>
Once its done, you should be able to browse to [http://mist-machine-public-ip:8080](http://mist-machine-public-ip:8080) and see the application.
<br>


### Step 3: Uninstall

To uninstall the application we run the `uninstall` workflow: <br>

`cfy local execute -w uninstall`
