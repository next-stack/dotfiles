# This is not a script to run, but to remember a solution to problem with linux kernel and ndivia driver.
# This solution works to run nvidia-390 with kernel 4.15-generic
sudo prime-select nvidia
sudo update-alternatives --config x86_64-linux-gnu_gl_conf # set to auto mode
glxinfo|egrep "OpenGL vendor|OpenGL renderer"
