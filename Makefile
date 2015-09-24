watch:
	while sleep 1; do find ./{test,lib} -iname "*.js"|entr -r gulp test; done
