#!/bin/bash

./model_test.sh \
    -c  /glade/u/home/jamesmcc/WRF_Hydro/wrf_hydro_nwm_public_2 \
    -r  /glade/u/home/jamesmcc/WRF_Hydro/.wrf_hydro_nwm_public_REFERENCE \
    --compiler=ifort \
    --mpi=impi \
    --config='nwm_ana' \
    --ncores=2 \
    --reference_update=false \
    --domain_dir /glade/work/jamesmcc/domains/public/croton_NY_v2.1

# Can be added
#    --queue=share \
#    --use_existing_test_dir
#    --xrcmp_n_cores 4

exit $?
