# pisponder
(Pi + Responder)

Run Responder locally on a Raspberry Pi Zero. Just like a LAN Turtle found here:
https://room362.com/post/2016/snagging-creds-from-locked-machines/



pisponder is my first script. All it does is turn a Raspberry Pi Zero running Raspbian lite into a NTLMv2 hash stealing machine (even when the target computer is locked!).

**Instructions**

Download pisponder.sh, make it executable and then run as root.

Like this for example:
```
wget https://raw.githubusercontent.com/dee-oh-double-gee/pisponder/master/pisponder.sh

sudo chmod 755 pisponder.sh

sudo ./pisponder.sh
```
This script will work ONLY on the Raspberry Pi Zero. And I have only tested it on ver 1.3.

**Demo Video:**

<a href="http://www.youtube.com/watch?feature=player_embedded&v=0Rrhi5nXQ2k
" target="_blank"><img src="http://img.youtube.com/vi/0Rrhi5nXQ2k/0.jpg" 
alt="Pisponder Demo" width="240" height="180" border="10" /></a>

**Credit goes to:**

https://github.com/lgandx/Responder

Mubix from room362.com

https://th3s3cr3tag3nt.blogspot.com/

http://elevatedprompt.com/2016/09/snagging-credentials-from-locked-machines-with-raspberry-pi-zero/

