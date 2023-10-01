# Defined in - @ line 1
function rmd
	pandoc $argv | lynx -stdin
end
