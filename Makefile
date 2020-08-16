.PHONY: til readme hooks

til:
	.meta/new-til

readme:
	.meta/update-readme README.md > /tmp/til-readme.md
	mv /tmp/til-readme.md README.md

hooks:
	ln -s .meta/hooks/pre-commit .git/hooks/pre-commit
