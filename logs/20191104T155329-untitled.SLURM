#!/bin/bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   SLURM Script - [EDIT]
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

## Main SLURM variables
#SBATCH --job-name=untitled
#SBATCH --account=stf
#SBATCH --partition=stf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=1:00:00
#SBATCH --mem=10G
#SBATCH --chdir=/home/shervin/Dropbox/ACADEMIA/UW/Hyak

## Email notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=shervin@uw.edu

## Export all your environment variables to the batch job session
#SBATCH --export=all

## Output important run info
pwd; hostname; date --iso-8601=seconds
echo "Option1: python job.py"
echo "Option2: "
echo "Command: gfhjb"

## Export your .bashrc settings
source /home/shervin/.bashrc

## Run job and time it
python job.py

(time gfhjb | tee /home/shervin/Dropbox/ACADEMIA/UW/Hyak/20191104T155329-untitled.out)


date --iso-8601=seconds


