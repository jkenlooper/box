
# clear out any suffixes
.SUFFIXES:

root-objects := .init-apt-get.sh .init.sh .nodejs.sh .tmux.sh .python-pip.sh .python-packages.sh
user-objects := .vim.sh .dotfiles.sh

root : $(root-objects)
user : $(user-objects)
.PHONY : root user clean


.init-apt-get.sh : init-apt-get.sh
	./$<;
	@touch $@;

.init.sh : init.sh
	./$<;
	@touch $@;

.tmux.sh : tmux.sh .init.sh
	./$<;
	@touch $@;

.nodejs.sh : nodejs.sh .init.sh
	./$<;
	@touch $@;

.python-pip.sh : python-pip.sh .init.sh
	./$<;
	@touch $@;

.python-packages.sh : python-packages.sh .python-pip.sh
	./$<;
	@touch $@;

## installed without root privilege

.vim.sh : vim.sh .init.sh
	./$<;
	@touch $@;

.dotfiles.sh : dotfiles.sh .init.sh
	./$<;
	@touch $@;

clean :
	rm $(root-objects) $(user-objects);
