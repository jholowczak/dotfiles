function jsgrep
	grep -RIEn $argv | grep -v node_modules | less -R
end
