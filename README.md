# Poor Man's Job Scheduler

### TLDR

- `pmrun "python3 foo.py"`
- Run Asynchronous jobs on remote/local server as if they were your local machine.
- Without directly messing with SSH (Let me take care of that).

### Not so TLDR

- A Simple tool for giving jobs to a remote workstation/server through ssh.
- Sync source code across systems with RSync (both LAN and WAN).
- Simple logging of errors supported.
- Only Supports a single compute node.
- If you're looking for something a bit more sophisticated, please use SLURM.
- Meant for use with a single machine with multiple GPUs for Machine Learning Workloads.
- This is not really a Job SCHEDULER.

## Installation

- Install ssh and setup Keys on client and the server.
- Install `runoverssh` with `sudo apt-get install runoverssh`.
- Run `bash source_pm-jobs.sh` and restart terminal.
- Setup Global Settings with `pmrun global <remote_user> <remote_host> <projects_root>`.
- For me, this command looks like `pmrun global surya 192.168.225.21 /home/surya/Documents/Projects/pm-jobs`.
  NOTE: DO NOT input a trailing `/` when passing `<projects_root>`
  NOTE: Make sure to use public IP Address if SSH-ing over WAN.

## Getting Started

- `cd` into a project directory, for e.g. `cd ~/Projects/StyleGAN2/`, this will create a directory `<projects_root>/StyleGAN2/`on the server.
- Run `pmrun init` to sync this directory with the server.
- For running whatever command you would locally in the server with simply `pmrun "~/miniconda3/bin/python3 test.py"`.
- Errors and anything printed (STDOUT and STDERR) will be redirected to `<projects_root>/<current_project>/pmsrun.log`

## Author

#### Surya Kant Sahu

- Researching Impractical and Stupid Ideas in Machine Learning.
- I play the Piano. A huge fan of Frédéric Chopin and Japanese Neo-Classical.
- Contact:
  - [Github](https://github.com/ojus1)
  - [LinkedIn](https://www.linkedin.com/in/surya-kant-oju/)
