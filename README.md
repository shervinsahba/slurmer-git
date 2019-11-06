# slurmer

Slurmer makes it quick and easy to run a job on a computing cluster that uses SLURM as its job batch system. Slurmer will generate a temporary SLURM sbatch file, log its work, queue your job, and organize logs of your job's output.

Run this script as an executable from command line, where you can add options in the form of flags to control SLURM variables. Options and examples are described in the header of the slurmer file.

- By default the working directory is used, jobnames are set as "untitled", and the current user is sent progress emails. 
- Output is redirected to `YYYYMMDDTHHMMSS-jobname.out`. The timestamp is similar to ISO-8601 format with year, month, and day followed by the letter T for time and then hour, minutes, and seconds. 
- A submission log is created at `logs/submit_log`. Subsequent submissions are appended to this file.


This script was designed with University of Washington Hyak in mind. Hyak and Mox Hyak are UW's computing cluster. Here's the [Hyak Wiki](https://wiki.cac.washington.edu/display/hyakusers/WIKI+for+Hyak+users).



## Installation
Log into a build node, `cd` to your desired install location, and run 

```
git clone https://github.com/shervinsahba/slurmer-git
```

To check if the software works, run
```
cd slurmer-git
./slurmer
```

The help dialog can be called with

`./slurmer --help` 

### Config default settings
Run `./slurmer --settings` to view the current settings. These settings ought to be okay for UW Hyak users on stf accounts, but you may wish to modify them later to tailor it to your workflow. If you do not use UW Hyak on stf, you'll need to run config.

To config your stock settings, run

```
./config
```
and follow the setup wizard. You can use this utility to reset to stock settings too.

### Link slurmer to make it run from command line
You'll want to link slurmer to a directory that's on your PATH, so you can
run `slurmer` from the command line. For example, to link it to `~/bin`, run

```
ln -s "$PWD/slurmer" ~/bin                   # symbolically link slurmer to ~/bin/slurmer  
```

If you don't have a bin directory for executables, make one with the following and rerun the above link command.
```
mkdir -p ~/bin                               # create home bin directory if doesn't exist
echo "export PATH=$PATH:~/bin" >> ~/.bashrc  # add ~/bin to PATH
source ~/.bashrc                             # rerun your .bashrc to update current environment
```

Now you can run slurmer from the command line as `slurmer`.

### Improving slurmer
Feel free to edit slurmer to tweak further options. This may be necessary if you are not a UW Hyak user. To propose improvements, please open an Issue or Pull Request here.



## Usage
```
slurmer [-h | --help] [-v | --version] [-D | --dryrun] [-s | --settings]
        [-n number_of_nodes] [-N tasks_per_node] [-m node_memory]  
        [-t walltime] [-d working_dir] [-j set_jobname]
        [-A account] [-P partition] [-E email_address]
        [job command] [optional pre-command 1] [optional pre-command 2]
```

Slurmer will automatically send compute updates via SLURM, if you've provided your email address.
To silence updates, run it with `-E ""`, or run config and set your email address as `""`.


### Example
Let's consider running a python file using a particular conda environment.
Say I want to run `mnist_cnn.py` from [Keras examples](https://github.com/keras-team/keras/tree/master/examples). 
With the example script downloaded to Hyak, I would run in that directory

```
slurmer "python mnist_cnn.py" "source activate env_name"
```

where "env_name" is my conda environment. 

The job should now appear on your queue. A submission log will be appended in your working directory to `logs/submit_log`. Output will appear in a timestamped file like `20191001T130001-untitled.out` if it was submitted on October 1, 2019 at 1:00:01PM. Note that the jobname was not set, and so it is untitled. A jobname can be set via a `-j jobname` option flag. Slurmer takes several command line option flags to modify its behavior, so check them out with the `--help` option.


### Options
```
Info
  -h | --help      	  Help
  -v | --version      Slurmer version and info
  -s | --settings     Displays default settings

Cluster and job variables
  -n [integer]        number of nodes
  -N [integer]        number of tasks per node
  -t [H:MM:SS]        walltime
  -m [integer]G       memory (Request less than node max.
                              e.g. On Mox Hyak, 128G node is 
                              120G max, 256 is 248, 512 is 500)
  -d [/...path/]      working directory
  -j [jobname]        jobname	

  -D | --dryrun       executes a dryrun, prints slurm batch file

User settings
  -A [account]        account
  -P [partition]      partition
  -E [email@host.xxx] email address for job notifications.
                       Set email to empty string for no updates.
```