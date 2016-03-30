all:
	pandoc projeto.md -c estilo.css --toc -s -S  -o projeto.html

