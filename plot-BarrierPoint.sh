#!/bin/bash

declare config_json='configs_plot.json'

#Allow for running with different config files
config_json=$1

python errorEstimate.py -c $config_json
