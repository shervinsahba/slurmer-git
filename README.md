# slurmer

Slurmer makes it quick and easy to run a job on a computing cluster that uses SLURM as its job batch system. Slurmer will generate a temporary SLURM sbatch file, log its work, queue your job, and organize logs of your job's output.

Run this script as an executable from command line, where you can add options in the form of flags to control SLURM variables. Options and examples are described in the header of the slurmer file.

- By default the working directory is used, jobnames are set as "untitled", and the current user is sent progress emails. 
- Output is redirected to `YYYYMMDDTHHMMSS-jobname.out`. The timestamp is similar to ISO-8601 format with year, month, and day followed by the letter T for time and then hour, minutes, and seconds. 
- A submission log is created at `logs/submit_log`. Subsequent submissions are appended to this file.


This script was designed with University of Washington Hyak in mind. Hyak and Mox Hyak are UW's computing cluster. Here's the [Hyak Wiki](https://wiki.cac.washington.edu/display/hyakusers/WIKI+for+Hyak+users).



## Installation:
Log into a build node and run the following.

```
wget https://raw.githubusercontent.com/shervinsahba/Hyak-SLURM/master/slurmer   # download slurmer
chmod +x slurmer                    # make slurmer executable
```

Run `slurmer --help` to see program information and `slurmer --settings` to see
current defaults. If you want to configure your preferred defaults, run the supplementary `config_slurmer` script.

```
wget https://raw.githubusercontent.com/shervinsahba/Hyak-SLURM/master/config_slurmer
bash ./config_slurmer
```

Now slurmer should be setup and executable from your current directory. I recommend moving slurmer to a directory that's on your PATH, or create a directory and append it to PATH in your .bashrc. For example,

```
mkdir -p ~/bin                                  # create home bin directory if doesn't exist
echo "export PATH=$PATH:~/bin" >> ~/.bashrc     # add ~/bin to PATH
source ~/.bashrc                                # rerun your .bashrc to update current environment

mv slurmer ~/bin
```


Feel free to edit slurmer, say via `nano slurmer`, to tweak further options. This may be necessary if you are not a UW Hyak user. To propose improvements, please open an Issue or Pull Request.


## Usage:
usage: 
```
slurmer [-h | --help] [-v | --version] [-D | --dryrun] [-s | --settings]
        [-n number_of_nodes] [-N tasks_per_node] [-m node_memory]  
        [-t walltime] [-d working_dir] [-j set_jobname]
        [job command] [optional pre-command 1] [optional pre-command 2]
```


#### Example:
Let's consider running a python file using a particular conda environment.
Say I want to run `mnist_cnn.py` from [Keras examples](https://github.com/keras-team/keras/tree/master/examples). 
With the example script downloaded to Hyak, I would run in that directory

```
slurmer python mnist_cnn.py" "source activate learning"
```

where "learning" is my conda environment. 

The job should now appear on your queue. A submission log will be appended in your working directory to `logs/submit_log`. Output will appear in a timestamped file like `20191001T130001-untitled.out` if it was submitted on October 1, 2019 at 1:00:01PM. Note that the jobname was not set, and so it is untitled. A jobname can be set via a `-j jobname` option flag. Slurmer takes several command line option flags to modify its behavior, so check them out with the `--help` option.
