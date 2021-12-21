#!/bin/bash
# Run a sweep of all the available configs. Call from the top-level directory of your BP install

#Uncomment to debug script
set -x 

APP_NAME=pennant

WORKDIR=$PWD
echo "Running a sweep of tests for $APP_NAME from $WORKDIR"

#Number of threads to test over
THREADS=(1 2 4 8 16 32 64 128)
#Use for debugging
#THREADS=(1)

#Pointer to the BP run config and plotting config. We edit these in the for loop below to do a sweep
RUN_CFG=scripts/configs.json.${APP_NAME}
PLOT_CFG=scripts/configs_plot.json.${APP_NAME}

INITIAL_TEST=1
LAST_TEST=1

for thr in "${THREADS[@]}"
do
	echo "Running tests for $thr threads with config $RUN_CFG"

	#Replace the test number of threads in the file to do a sweep across threads
	sed -i "s/$LAST_TEST/$thr/g" $RUN_CFG	
	sed -i "s/$LAST_TEST/$thr/g" $PLOT_CFG
	LAST_TEST=$thr	

	#Run the tests and plot the results
	echo ".$WORKDIR/run-BarrierPoint.sh -c $RUN_CFG"
	$WORKDIR/run-BarrierPoint.sh $RUN_CFG
	echo ".$WORKDIR/plot-BarrierPoint.sh $PLOT_CFG"
	$WORKDIR/plot-BarrierPoint.sh $PLOT_CFG


done

#Reset config files to their original state
sed -i "s/$LAST_TEST/$INITIAL_TEST/g" $RUN_CFG	
sed -i "s/$LAST_TEST/$INITIAL_TEST/g" $PLOT_CFG
