# AKS Hello World App

[![Build Status](https://travis-ci.org/perprogramming/aks-hello-world.svg?branch=master)](https://travis-ci.org/perprogramming/aks-hello-world)

## Description

This is a demonstration on how to use github and travis-ci to create a kubernetes cluster on Microsoft Azure and deploy a simple hello world application upon it.

## How to start the AksHelloWorld application

1. Run `mvn clean install` to build your application
1. Start application with `java -jar target/aks-hello-world-latest.jar server config.yml`
1. To check that your application is running enter url `http://localhost:8080`

## Health Check

To see your applications health enter url `http://localhost:8081/healthcheck`
