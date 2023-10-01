function pprint
	cat $argv | python -m json.tool | less
end
