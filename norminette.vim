" Author: hokada <hokada@student.42tokyo.jp>
" Description: norminette linter for C files.

call ale#Set('c_norminette_executable', 'norminette')
call ale#Set('c_norminette_options', ' -d')

function! ale_linters#c#norminette#GetExecutable(buffer) abort
    return ale#Var(a:buffer, 'c_norminette_executable')
endfunction

function! ale_linters#c#norminette#GetCommand(buffer) abort
    return ale#Escape(ale_linters#c#norminette#GetExecutable(a:buffer))
    \   . ale#Var(a:buffer, 'c_norminette_options')
    \   . ' %t'
endfunction


function! ale_linters#c#norminette#Opscript(buffer, lines) abort
    " Look for lines like the following.
    "
    " hoge.c: KO!
    "	SPACE_BEFORE_FUNC    (line:   3, col:   4):     space before function name
	let l:pattern = '\v^\t*(([a-zA-Z]|_|\.)+)(\ *\(line:\ *(\d+),\ *col:\ *(\d+)\))?:\t*(.+)$'
    let l:output = []
	let l:curr_file = ''
	let l:lel = ale#util#GetMatches(a:lines, l:pattern)

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
		if !l:match[4]
			let l:curr_file = l:match[1]
		else
			call add(l:output, {
            \   'lnum': str2nr(l:match[4]),
			\   'col': str2nr(l:match[5]),
            \   'type': 'W',
            \   'text': l:match[6],
            \})
        endif
    endfor

    return l:output
endfunction

call ale#linter#Define('c', {
\   'name': 'norminette',
\   'output_stream': 'both',
\   'executable': function('ale_linters#c#norminette#GetExecutable'),
\   'command': function('ale_linters#c#norminette#GetCommand'),
\   'callback': 'ale_linters#c#norminette#Opscript',
\})
