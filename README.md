# Mist Cloudify Nodecellar Example


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
This plugin needs [an account on mist.io](https://mist.io/).

**Note: <br>Documentation about the blueprints content is located inside the blueprint files themselves.
<br>Presented here are only instructions on how to RUN the blueprints using the Cloudify CLI with Mist.io plugin .**
<br><br>
**From now on, all commands will assume that the working directory is the root of this repository.**

## Install dependencies
`pip install -r dev-requirements.txt` </br>


## Step 1: Initialize
 

You need to add a cloud on mist.io account.Click "ADD CLOUD" ![alt tag](http://d33v4339jhl8k0.cloudfront.net/docs/assets/555c5984e4b01a224b425242/images/5605257f903360177092e035/file-ysREVMYhF4.png)

The nodecellar scripts are made for ubuntu image and has been tested with AWS service.

Check the blueprint file inputs section and fill
the [mist input](inputs/mist.yaml) file with the necessary information.

There are two blueprints. The [mist-blueprint](mist-blueprint.yaml file uses the mist.io service to run the scripts on the machine so the user can read the logs be notified about operation success.
The [mistfabric-blueprint](mistfabric-blueprint.yaml) file uses the cloudify fabric plugin to run the scripts:

### Blueprint using Mist Script runnner

`cfy local init --install-plugins -p  mist-blueprint.yaml -i inputs/mist.yaml` <br>

### Blueprint using the cloudify-fabric-plugin

`cfy local init --install-plugins -p mistfabric-blueprint.yaml -i inputs/mist.yaml` <br>

This command (as the name suggests) initializes your working directory to work with the given blueprint.
Now, you can run any type of workflows on this blueprint. <br>

## Step 2: Install

Lets run the `install` workflow: <br>

`cfy local execute -w install`

This command will install all the application components on you mist machine.
(don't worry, its all installed under the `tmp` directory)<br>
Once its done, you should be able to browse to [http://mist-machine-public-ip:8080](http://mist-machine-public-ip:8080) and see the application.
<br>


## Step 3: Uninstall

To uninstall the application we run the `uninstall` workflow and will also destroy the machine: <br>

`cfy local execute -w uninstall`

