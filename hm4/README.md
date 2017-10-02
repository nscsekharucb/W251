This directory contains the scripts used for the mumber program required as part of Homework 4. These scripts make the following assumptions about the runtime environment

1. The filesystem is set as cd /gpfs/gpfsfpo/
2. The scripts in this folder are copied to /gpfs/gpfsfpo/scripts directory
3. There are three nodes - gpfs1, gpfs2, gpfs2
4. The scripts are all run on the primary node - gpfs1

First time Download:

```
cd /gpfs/gpfsfpo/
./scripts/download.sh
```

Preprocess

```
cd /gpfs/gpfsfpo/
./scripts/preprocess.sh
```

And running the mumbler

```
[root@gpfs1 ~]# cd /gpfs/gpfsfpo/
[root@gpfs1 gpfsfpo]# sh scripts/mumbler.sh available 3
Given word: available
next word-1: monitors
next word-2: television
next word-3: lawyer
```
