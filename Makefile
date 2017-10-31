
# clear out any suffixes
.SUFFIXES:

root-objects := .init.sh .vim.sh .nodejs.sh .other.sh .tmux.sh .python-pip.sh .python-packages.sh
user-objects := .dotfiles.sh

root : $(root-objects)
user : $(user-objects)
.PHONY : root user clean


.init.sh : init.sh
	./$<;
	@touch $@;

.vim.sh : vim.sh .init.sh
	./$<;
	@touch $@;

.tmux.sh : tmux.sh .init.sh
	./$<;
	@touch $@;

.nodejs.sh : nodejs.sh .init.sh
	./$<;
	@touch $@;

.other.sh : other.sh .init.sh
	./$<;
	@touch $@;

.python-pip.sh : python-pip.sh .init.sh
	./$<;
	@touch $@;

.python-packages.sh : python-packages.sh .python-pip.sh
	./$<;
	@touch $@;

## installed without root privilege

.dotfiles.sh : dotfiles.sh .init.sh
	./$<;
	@touch $@;

test :
	./test.sh;

clean :
	rm $(root-objects) $(user-objects);
