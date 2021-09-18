# Minitel

![image text](files/minitel1.jpg "Minitel 1")

---

Fnct+Sommaire (pour passer du mode répertoire au mode terminal)

Fnct+T (en même temps), relâcher et A (passage en mode périphérique)

Fnct+T, (en même temps) et E (désactivation de l’echo du terminal)

Fnct+P, (en même temps), et 4 (connexion à 4800 bauds)

---

Ctrl+1  {

Ctrl+2  |

Ctrl+3  }

Ctrl+4  ~

Ctrl+5  '

Ctrl+6  _

#

Fnct+1 F1

Fnct+2 F2

...

Fnct+0 F10

---

Avec le minitel 2, vous pouvez même vous connecter à 9600 bauds en tapant Fnct+P, (en même temps), et 9 (à la place de 4), mais il faudra aussi modifier les paramètres du Raspberry Pi (ci-dessous).



## Test de communication

Branchez le minitel sur la prise USB du Raspberry Pi et allumez les. Connectez vous au Raspberry (avec PuTTY ou le client SSH de Windows).
Copiez ces 3 lignes en même temps dans votre client SSH :



> stty -F /dev/ttyUSB0 4800 istrip cs7 parenb -parodd brkint \
> ignpar icrnl ixon ixany opost onlcr cread hupcl isig icanon \
> echo echoe echok

> echo 'Hello World' > /dev/ttyUSB0


 Puis :

> cat /dev/ttyUSB0



## Ressources

https://arduiblog.com/2019/04/29/ressuscitez-le-minitel/

http://pila.fr/wordpress/?p=361

http://sta6502.blogspot.com/2016/02/utiliser-un-minitel-comme-terminal-sur.html

http://xseignard.github.io/2013/05/20/plug-your-minitel-on-your-raspberry-pi/

http://furrtek.free.fr/?a=telinux

https://www.synergeek.fr/recycler-un-minitel/

http://lea-linux.org/documentations/Pratique-minitel

https://www.framboise314.fr/retour-vers-le-passe/

https://www.raspberrypi.org/forums/viewtopic.php?t=44932


Et à essayez à tout prix, le starwars en ASCII :

telnet towel.blinkenlights.nl
