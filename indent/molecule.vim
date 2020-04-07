"   Vim-Molecule: A Plugin for Molecule in Vim.
"
"   Copyright (C) 2020 Boyu Yang <yangby@cryptape.com>
"
"   This program is free software: you can redistribute it and/or modify
"   it under the terms of the GNU Affero General Public License as published by
"   the Free Software Foundation, either version 3 of the License, or
"   (at your option) any later version.
"
"   This program is distributed in the hope that it will be useful,
"   but WITHOUT ANY WARRANTY; without even the implied warranty of
"   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"   GNU Affero General Public License for more details.
"
"   You should have received a copy of the GNU Affero General Public License
"   along with this program.  If not, see <https://www.gnu.org/licenses/>.

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

if !exists("g:molecule_mode_indent")
    let g:molecule_mode_indent = 4
endif

setlocal autoindent
setlocal nolisp
setlocal indentexpr=MoleculeIndent(v:lnum)
setlocal indentkeys+=0>

if exists('*MoleculeIndent')
    finish
endif

function! MoleculeIndent(currLineNum)

    " First line should have no indent
    if a:currLineNum == 0
        return 0
    endif

    " Base on the indent of the previous non-blank line
    let l:prevLineNum = prevnonblank(a:currLineNum - 1)
    let l:currLineIndent= indent(l:prevLineNum)

    let l:prevLine = getline(l:prevLineNum)
    let l:currLine = getline(a:currLineNum)

    " If the previons line isn't a line comment,
    " and the last non-blank character of it is one of '[{<('.
    if l:prevLine !~# '^\s*\(#\|//\)' && l:prevLine =~# '[\[{<(]\s*$'
        let l:currLineIndent += g:molecule_mode_indent
    endif

    " If the current line ends a block.
    if l:currLine =~# '^\s*[)>}\]]'
        let l:currLineIndent -= g:molecule_mode_indent
    endif

    return l:currLineIndent
endfunction
