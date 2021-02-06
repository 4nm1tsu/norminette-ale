failed=0
cp ./norminette.vim ~/.vim/plugged/ale/ale_linters/c/norminette.vim
# > /dev/null
if [ $? -ne 0 ]; then
    failed=1
fi
cp ./norminette_cpp.vim ~/.vim/plugged/ale/ale_linters/cpp/norminette.vim
#  > /dev/null
if [ $? -ne 0 ]; then
    failed=1
fi
if [ $failed -eq 0 ]; then
    echo $(tput setaf 2)Copy complete! ✔︎$(tput sgr0)
else
    echo $(tput setaf 1)Copy failed! ✗$(tput sgr0)
fi
