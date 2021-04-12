" Author: hokada <hokada@student.42tokyo.jp>
" Description: norminette linter for C++ files.

call ale#Set('cpp_norminette_executable', 'norminette')
call ale#Set('cpp_norminette_options', ' -d')

function! ale_linters#cpp#norminette#GetExecutable(buffer) abort
    return ale#Var(a:buffer, 'cpp_norminette_executable')
endfunction

function! ale_linters#cpp#norminette#GetCommand(buffer) abort
    return ale#Escape(ale_linters#cpp#norminette#GetExecutable(a:buffer))
    \   . ale#Var(a:buffer, 'cpp_norminette_options')
    \   . ' %t'
endfunction


function! ale_linters#cpp#norminette#Opscript(buffer, lines) abort
    "	Error: SPACE_REPLACE_TAB    (line:  17, col:  11):      Found space when expecting tab

    let l:pattern = '\v^Error: *(([a-zA-Z]|_|\.)+)(\ *\(line:\ *(\d+),\ *col:\ *(\d+)\))?:\t*(.+)$'
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

call ale#linter#Define('cpp', {
\   'name': 'norminette',
\   'output_stream': 'both',
\   'executable': function('ale_linters#cpp#norminette#GetExecutable'),
\   'command': function('ale_linters#cpp#norminette#GetCommand'),
\   'callback': 'ale_linters#cpp#norminette#Opscript',
\})
