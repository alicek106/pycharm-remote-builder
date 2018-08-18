Remote interpreter for Pycharm IDE
===
1. How to use
---
	# git clone https://github.com/alicek106/pycharm-remote-builder.git
	# docker build . -t alicek106/your_docker_image_name:your_tag
    
or ...
	# docker pull alicek106/pycharm-remote-builder:latest
    

After image pulled, you can create a docker container from it.
For example in native docker engine, you can run container like above command.

	# docker run -d -p 50000:22 --name mycontainer alicek106/pycharm-remote-builder:latest
    
Or if you want to deploy container in kubernetes, refer the `kube-deployment.yaml`.
	# kubectl apply -f kube-deployment.yaml

In `kube-deployment.yaml`, NodePort is set to 30000, so you can access using 30000 port.
If you want to use a deserved port such as 22 (not recommanded), you should modify API server parameter of kube.

2. Setting in Pycharm
---
###### [1] SSH credential and connection test

 > `File` - `Setting` - `Project:$(Project Name)` - `Project Interpreter` - `Project Interpreter` - `Add Remote` (Gear Icon) - check `SSH Credential`

 Fill the blanks properly, user name is `root` and default password is `theoryofhappiness`.
 > `python interpreter` - `...` - select `/root/python_env.sh `

###### [2] Deployment and auto-upload setting
 > `Tools` - `Deployment` - `Configuration...` - set proper `SFTP host` and `Port` parameter.

In `Mapping` tap, set `deployment path on server` to `/root/src`

 > `Tools` - `Deployment` - Click `Upload to ... $(server info)`

3. Setting environment variables
---
Environment variables inside container are not applied to pycharm IDE. So I used a special trick.
Python source code is executed using `python_env.sh` and it call another script, `env_var.sh`, for example,

```
declare -x HOME="/root"
declare -x HOSTNAME="a19c8189a18e"
declare -x OLDPWD
declare -x PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
declare -x PWD="/root"
declare -x SHLVL="1"
```

When container start, `entrypoint.sh` will export variables to `env_var.sh`. 
Thanks to `env_var.sh`, `python_env.sh` can use environment variables. And pycharm use `python_env.sh ` :D

4. Contributions
---
Contributions are invited!
