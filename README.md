# Hyak-SLURM

Hyak and Mox Hyak are UW's computing cluster.
https://wiki.cac.washington.edu/display/hyakusers/WIKI+for+Hyak+users


## slurmer

SLURM sbatch facilitator. This script is meant to be run as an executable. Slurmer
takes in options via command line to control SLURM variables, creates a temp SLURM 
sbatch file, and queues it.

Output is redirected to ./YYYYMMDDTHHMMSS-jobname.out
A submission log is appended at ./logs/submit_log.

### Installation:
On a Hyak build node, run

```
wget https://raw.githubusercontent.com/shervinsahba/Hyak-SLURM/master/slurmer
chmod +x slurmer
```

Now slurmer should be executable from this directory. 
I recommend moving it to a directory that's on your $PATH, 
or create a directory and append it to $PATH in your .bashrc.

### Instructions and setup:
Run `less slurmer` to read through usage instructions.
Make edits to match your preferred defaults.


### Usage Example:
Let's consider running a python file using a particular conda environment.
Say I want to run `mnist_cnn.py` from [Keras examples](https://github.com/keras-team/keras/tree/master/examples). 
With the example script downloaded to Hyak, I would run in that directory

```
slurmer "python mnist_cnn.py" "source activate learning"
```

where "learning" is my conda environment. 

The job should now appear on your queue. 
A submission log will be appended in your working directory to logs/submit_log.
Output will appear in your working directory in a file like YYYYMMDDTHHMMSS-untitled.out
