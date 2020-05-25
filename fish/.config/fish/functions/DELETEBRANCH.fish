function DELETEBRANCH
	git push origin --delete $1
git branch -D $1
end
