# PwnLaunch
A nsjail-based, automated vulnerable app/challenge launcher via docker for CTFs and Cybersecurity Training


* Who this is for?
* Why PwnLaunch
* [How to Build](README.md#how-to-build)
* [How to use]()
* [Credits]()
* [License]()


### Who is this for?
Anyone who wants to set up an isolated environment for their next vulnerable code deployment in minutes!

Example:
1. Cybersecurity Students
2. CTF Organisers
3. Vulnerability Testers


### Why PwnLaunch?
When I was trying to learn ROP and other binary exploits, I stumbled upon many archived CTF challenges but I was not able to set up an environment for them.
It took me 2 days to set up my first docker environment for practice. I understand how painful it can be to build it every time from scratch if something goes wrong or you are setting up a new set of challenges to practice on;

So I took just one more day to automate the whole process which works well in 2022 (unlike some old scrap abominations I found on GitHub) so that you can focus on your practice/challenge and leave setting up everything else on PwnLaunch!

## How to build?

1. Clone this repo by `git clone https://github.com/Saket-Upadhyay/PwnLaunch.git`
2. Copy your vulnerable application in the **./chal** folder
3. If you have a flag, copy it in **./flag/flag**
4. Change your current directory to PwnLaunch `cd PwnLaunch`
5. Build docker image by `./BuildDockerimage.sh` or `docker compose build` in the root directory of PwnLaunch

> Note: You should have a docker image named `pwnlaunch_main`; check this by `docker images`

## How to use?
1. Run `runPWNLaunch.sh` and wait for the docker shell to open
2. In docker's shell run `/nsjailexec.sh` or `nsjail --config /etc/nsjail.cfg`
3. To exit press `CTRL+C`

> Note: TO run in detached mode type `nsjail --config /etc/nsjail.cfg -d`


## Credits
1. This project uses Google's opensource NSJail [https://github.com/google/nsjail](https://github.com/google/nsjail)
2. The sample challenge in ./chal/return-to-what is taken from [DownUnderCTF/Challenges_2020_public](https://github.com/DownUnderCTF/Challenges_2020_public/tree/master/pwn/return-to-what)

## License

This project is made by Saket Upadhyay and is available under [MIT License](https://github.com/Saket-Upadhyay/PwnLaunch/blob/main/LICENSE).
