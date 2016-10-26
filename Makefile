
# clear out any suffixes
.SUFFIXES:

root-objects := .init.sh .neovim.sh .nodejs.sh .other.sh
user-objects := .global-npm-setup.sh .global-npm-packages.sh

root : $(root-objects)
user : $(user-objects)
.PHONY : root user clean

.init.sh : init.sh
	./$<;
	@touch $@;

.neovim.sh : neovim.sh .init.sh
	./$<;
	@touch $@;

.nodejs.sh : nodejs.sh .init.sh
	./$<;
	@touch $@;

.other.sh : other.sh .init.sh
	./$<;
	@touch $@;

.global-npm-setup.sh : global-npm-setup.sh .nodejs.sh
	./$<;
	@touch $@;

.global-npm-packages.sh : global-npm-packages.sh .global-npm-setup.sh
	./$<;
	@touch $@;
