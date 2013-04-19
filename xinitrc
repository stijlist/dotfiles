setxkbmap -option ctrl:nocaps &
xsetroot -cursor_name left_ptr &
xrdb -merge ~/.Xresources &
xset +fp /usr/share/fonts/local &
xset fp rehash &
xset r rate 200 25 &
xmonad &
xcape -e 'Control_L=Escape' &
exec urxvtd 
# exec redshift -l 30.2:97.7 -t 5500:3600
