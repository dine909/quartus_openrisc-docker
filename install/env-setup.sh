export DISPLAY=:1

export QT_GRAPHICSSYSTEM=native
export LD_PRELOAD=/usr/lib/libtcmalloc_minimal.so.4

while :
do
Xvfb :1 -screen 0 2560x1600x24
sleep 1
done &

while :
do
fluxbox
sleep 1
done &

while :
do
x11vnc  -display :1 -noxrecord -noxfixes -noxdamage  -xkb -passwd 123456
sleep 1
done &


#jupyter-notebook --ip=0.0.0.0 --allow-root  --notebook-dir /mnt/data/quartus &

while :;
do
cd /mnt/data/quartus
/opt/intelFPGA_lite/18.1/quartus/bin/quartus
done
