# Path To Adventure
Inspired by [this](https://www.youtube.com/watch?v=9fLVU4N7sSM) wonderful video from the Hello World Program. 

This is a project for my I.T. students to practice basic Bash shell commands. It uses a slightly medieval theme. 

## Pre-Learning

Students should have some practice with using the Bash on Linux. They should have at least _some_ exposure to how permissions work on Linux and how to change them. It's good practice for students to have used each of the commands listed below during a group follow-along, but not a follow-along of this activity. It's also useful for students to have some experience using <kbd>Ctrl</kbd>+<kbd>C</kbd> to bail out of commands they need to get out of.

This little game will give practice with using these commands:

* `ls`, along with the `-l` and `-a` options
* `cd`
* `pwd`
* `rm`, along with the `-r` option OR
* `rmdir`
* `mv`
* `grep`
* `wc`, especially with its `-l` option
* `chmod`
* `touch`
* `mkdir`
* `man`
* Also some way to get text into files, either:
  * `echo` with file redirection OR
  * `vim` with the basic `i`, `<ESC>`, and `:wq` OR
  * `nano` with instruction on how to understand the menu

## Running on your regular system

In order to run this game, you will need to have the ability to use `sudo` to elevate your privileges.

To run this game, you can download the `adv.tar` file from the Releases page. Untar the file with `tar -xf adv.tar`. Then change to the `path_to_adventure` directory and start the game with `./start`

If you clone this repository and want to run the game, you need to first run the setup.sh script. This will set up the correct permissions and files for the Ruins and Catacombs.

## Running in a container

If you don't have the ability to use sudo on your main system, but you *can* run containers with `podman`, you can play the game with a simple 

```bash
podman run -it quay.io/jbaldus/path_to_adventure
```

---

If you want to build your own local container, first clone the repository. Then you can build a container to play this game in using the Containerfile with the following command:

```bash
podman build . -t path_to_adventure
```

Then you can play it with 

```bash
podman run -it localhost/path_to_adventure
```