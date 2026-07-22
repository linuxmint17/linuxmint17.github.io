clean:
	hexo clean;
run:
	hexo clean;hexo generate; hexo server
deploy:
	hexo clean;hexo generate; hexo deploy
all:
	hexo clean;hexo generate; hexo server
