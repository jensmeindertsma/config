set_dark() {
	gsettings set org.gnome.desktop.interface gtk-theme ":dark"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	kitten themes --reload-in=all --config-file-name theme.conf GitHub Dark
}

set_light() {
	gsettings set org.gnome.desktop.interface gtk-theme ":light"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
	kitten themes --reload-in=all --config-file-name theme.conf GitHub Light
}

if [[ "$(gsettings get org.gnome.desktop.interface color-scheme)" == "'prefer-light'"
	]]; then
	set_dark
else
	set_light
fi

