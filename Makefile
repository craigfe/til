.PHONY: readme

readme:
	.meta/update-readme README.md > /tmp/til-readme.md
	mv /tmp/til-readme.md README.md
