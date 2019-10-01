# Hyak-SLURM

Hyak and Mox Hyak are UW's computing cluster. Here's the Hyak Wiki.
https://wiki.cac.washington.edu/display/hyakusers/WIKI+for+Hyak+users


## slurmer

Slurmer is a SLURM sbatch facilitator. This script is meant to be run as an executable. Slurmer
takes in options via command line to control SLURM variables, creates a temp SLURM 
sbatch file, and queues it.

By default the working directory is used, jobnames are set as untitled, and the user is sent progress emails. These and other options are accessible via the command line with flags, described in the header of the slurmer file.

Output is redirected to `YYYYMMDDTHHMMSS-jobname.out`. The timestamp is similar to ISO-8601 format with year, month, and day followed by the letter T for time and then hour, minutes, and seconds. 

A submission log is created at `logs/submit_log`. Subsequent submissions are appended to this file.



#### Installation:
On a Hyak build node, run

```
wget https://raw.githubusercontent.com/shervinsahba/Hyak-SLURM/master/slurmer
chmod +x slurmer
```

Now slurmer should be executable from this directory. 
I recommend moving it to a directory that's on your $PATH, 
or create a directory and append it to $PATH in your .bashrc.

#### Instructions and setup:
Run `less slurmer` to read through usage instructions.
Make edits, say via `nano slurmer` so you setup your preferred defaults.


#### Usage Example:
Let's consider running a python file using a particular conda environment.
Say I want to run `mnist_cnn.py` from [Keras examples](https://github.com/keras-team/keras/tree/master/examples). 
With the example script downloaded to Hyak, I would run in that directory

```
slurmer "python mnist_cnn.py" "source activate learning"
```

where "learning" is my conda environment. 

The job should now appear on your queue. A submission log will be appended in your working directory to `logs/submit_log`.
Output will appear in a timestamped file like `20191001T130001-untitled.out` if it was submitted on October 1, 2019 at 1:00:01PM. Note that the jobname was not set, and so it is untitled. A jobname can be set via a `-j jobname` option flag. Slurmer takes several command line option flags to modify its behavior, so check them out.
