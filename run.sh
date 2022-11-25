#!/usr/bin/env bash
cd /home/centos/gatling-maven-plugin-demo
DOMAIN="https://www.preprod-opt.idfcfirstbank.com" mvn gatling:test -Dgatling.simulationClass=computerdatabase.InfraSimulation