## vnc server 
$ Xtightvnc :0 -desktop X -auth /home/ysr/.Xauthority -geometry 1280x720 -depth 16 -rfbwait 120000 -rfbauth /home/ysr/.vnc/passwd -rfbport 5900 -fp /usr/share/fonts/X11/misc/,/usr/share/fonts/X11/Type1/,/usr/share/fonts/X11/75dpi/,/usr/share/fonts/X11/100dpi/ -co /etc/X11/rgb -dpi 75 -httpd /usr/local/vnc/classes

$ x11vnc -forever -shared -rfbauth root/.vnc/passwd -display :0

$ Xvnc :0 -desktop X -rfbauth /root/.vnc/passwd /usr/bin/x11vnc -shared -forever -accept /usr/bin/confirmed


