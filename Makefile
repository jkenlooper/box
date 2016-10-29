
# clear out any suffixes
.SUFFIXES:

root-objects := .init.sh .neovim.sh .nodejs.sh .other.sh .tmux.sh
user-objects := .global-npm-setup.sh .global-npm-packages.sh .dotfiles.sh .python-pip.sh .todotxt.sh

root : $(root-objects)
user : $(user-objects)
.PHONY : root user clean


.init.sh : init.sh
	./$<;
	@touch $@;

.neovim.sh : neovim.sh .init.sh
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


## installed without root privilege

.dotfiles.sh : dotfiles.sh .init.sh
	./$<;
	@touch $@;

.todotxt.sh : todotxt.sh .dotfiles.sh
	./$<;
	@touch $@;

.python-pip.sh : python-pip.sh .dotfiles.sh
	./$<;
	@touch $@;

.global-npm-setup.sh : global-npm-setup.sh .nodejs.sh
	./$<;
	@touch $@;

.global-npm-packages.sh : global-npm-packages.sh .global-npm-setup.sh
	./$<;
	@touch $@;

.python-packages.sh : python-packages.sh .python-pip.sh
	./$<;
	@touch $@;

clean :
	rm $(root-objects) $(user-objects);
