#!/bin/bash

declare config_json='configs.json'

#Allow for running with different config files
config_json=$1

# DR analysis
python DrAnalysis.py -c $config_json
# Perfcntr analysis
python RunBenchmarks.py -c $config_json
