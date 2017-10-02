#!/bin/bash

sh -c 'cd /gpfs/gpfsfpo/; nohup scripts/sh download_1.sh &
ssh -n -f root@gpfs2 "sh -c 'cd /gpfs/gpfsfpo/; nohup scripts/sh download_2.sh &'"
ssh -n -f root@gpfs3 "sh -c 'cd /gpfs/gpfsfpo/; nohup scripts/sh download_3.sh &'"
