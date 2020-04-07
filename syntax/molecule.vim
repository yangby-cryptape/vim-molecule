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

if exists("b:current_syntax")
  finish
endif

syn case match

" Keyword
syn keyword molKeywordImport            import
syn keyword molKeywordByte              byte

" Constant
syn match   molNumber                   contained skipwhite skipempty "\<\d\+\>"
syn match   molType                     contained skipwhite skipempty "\<\a\w*\>"
syn match   molIdentifier               contained skipwhite skipempty "\<\a\w*\>"

" Punctuation
syn match   molAngleStart               contained skipwhite skipempty "<"
syn match   molAngleEnd                 contained skipwhite skipempty ">"
syn match   molBracketStart             contained skipwhite skipempty "\["
syn match   molBracketEnd               contained skipwhite skipempty "]"
syn match   molBraceStart               contained skipwhite skipempty "{"
syn match   molBraceEnd                 contained skipwhite skipempty "}"
syn match   molParensStart              contained skipwhite skipempty "("
syn match   molParensEnd                contained skipwhite skipempty ")"
syn match   molComma                    contained skipwhite skipempty ','
syn match   molColon                    contained skipwhite skipempty ':'
syn match   molSemicolon                contained skipwhite skipempty ';'

" Array Declaration
syn region  molArrayRegion                        skipwhite skipempty start="\<array\>" end="]\s*;" keepend fold transparent                             contains=molArrayDeclKeyword,molArrayDeclName,molArrayDeclBody,molSemicolon
syn keyword molArrayDeclKeyword         contained skipwhite skipempty array                                                  nextgroup=molArrayDeclName
syn match   molArrayDeclName            contained skipwhite skipempty "[^\[]*"                                   transparent nextgroup=molArrayDeclBody  contains=molIdentifier
syn region  molArrayDeclBody            contained skipwhite skipempty start="\[" end="]"            keepend fold transparent nextgroup=molSemicolon      contains=molBracketStart,molType,molSemicolon,molNumber,molBracketEnd
" Struct Declaration
syn region  molStructRegion                       skipwhite skipempty start="\<struct\>" end="}"    keepend fold transparent                             contains=molStructDeclKeyword,molFieldsSetName,molFieldsSetBody
syn keyword molStructDeclKeyword        contained skipwhite skipempty struct                                                 nextgroup=molFieldsSetName
" Vector Declaration
syn region  molVectorRegion                       skipwhite skipempty start="\<vector\>" end=";"    keepend fold transparent                             contains=molVectorDeclKeyword,molVectorDeclName,molVectorDeclBody,molSemicolon
syn keyword molVectorDeclKeyword        contained skipwhite skipempty vector                                                 nextgroup=molVectorDeclName
syn match   molVectorDeclName           contained skipwhite skipempty "[^<]*"                                    transparent nextgroup=molVectorDeclBody contains=molIdentifier
syn region  molVectorDeclBody           contained skipwhite skipempty start="<" end=">"             keepend fold transparent nextgroup=molSemicolon      contains=molAngleStart,molType,molAngleEnd
" Table Declaration
syn region  molTableRegion                        skipwhite skipempty start="\<table\>" end="}"     keepend fold transparent                             contains=molTableDeclKeyword,molFieldsSetName,molFieldsSetBody
syn keyword molTableDeclKeyword         contained skipwhite skipempty table                                                  nextgroup=molFieldsSetName
" Option Declaration
syn region  molOptionRegion                       skipwhite skipempty start="\<option\>" end=";"    keepend fold transparent                             contains=molOptionDeclKeyword,molOptionDeclName,molOptionDeclBody,molSemicolon
syn keyword molOptionDeclKeyword        contained skipwhite skipempty option                                                 nextgroup=molOptionDeclName
syn match   molOptionDeclName           contained skipwhite skipempty "[^(]*"                                    transparent nextgroup=molOptionDeclBody contains=molIdentifier
syn region  molOptionDeclbody           contained skipwhite skipempty start="(" end=")"             keepend fold transparent nextgroup=molSemicolon      contains=molParensStart,molType,molParensEnd
" Union Declaration
syn region  molUnionRegion                        skipwhite skipempty start="\<union\>" end="}"     keepend fold transparent                             contains=molUnionDeclKeyword,molItemsSetName,molItemsSetBody
syn keyword molUnionDeclKeyword         contained skipwhite skipempty union                                                  nextgroup=molItemsSetName

" Item Declaration
syn match   molItemDecl                 contained skipwhite skipempty "\w\+\s*,"                                 transparent                             contains=molType,molComma
" Field Declaration
syn match   molFieldDecl                contained skipwhite skipempty "\w\+\s*:\s*\w\+\s*,"                      transparent                             contains=molFieldDeclName,molFieldDeclType
syn match   molFieldDeclName            contained skipwhite skipempty "\w\+\s*:"                                 transparent nextgroup=molFieldDeclType  contains=molIdentifier,molColon
syn match   molFieldDeclType            contained skipwhite skipempty "\w\+\s*,"                                 transparent                             contains=molType,molComma
" A Set of Items (For Union)
syn match   molItemsSetName             contained skipwhite skipempty "[^{]*"                                    transparent nextgroup=molItemsSetBody   contains=molIdentifier
syn region  molItemsSetBody             contained skipwhite skipempty start="{" end="}"             keepend fold transparent                             contains=molBraceStart,molItemDecl,molBraceEnd
" A Set of Fields (For Struct & Table)
syn match   molFieldsSetName            contained skipwhite skipempty "[^{]*"                                    transparent nextgroup=molFieldsSetBody  contains=molIdentifier
syn region  molFieldsSetBody            contained skipwhite skipempty start="{" end="}"             keepend fold transparent                             contains=molBraceStart,molFieldDecl,molBraceEnd

" Comments
syn keyword molCommentTodo              contained                     TODO FIXME XXX
syn region  molLineComment              containedin=ALL               start="\/\/" end="$" oneline  keepend                                              contains=molCommentTodo
syn region  molBlockComment             containedin=ALL               start="/\*"  end="\*/"                fold                                         contains=molCommentTodo

"
" Highlight
"

hi def link molKeywordImport            Include
hi def link molKeywordByte              Type

hi def link molNumber                   Number
hi def link molType                     Type
hi def link molIdentifier               Identifier

hi def link molAngleStart               SpecialChar
hi def link molAngleEnd                 SpecialChar
hi def link molBracketStart             SpecialChar
hi def link molBracketEnd               SpecialChar
hi def link molBraceStart               SpecialChar
hi def link molBraceEnd                 SpecialChar
hi def link molParensStart              SpecialChar
hi def link molParensEnd                SpecialChar
hi def link molComma                    SpecialChar
hi def link molColon                    SpecialChar
hi def link molSemicolon                SpecialChar

hi def link molArrayDeclKeyword         Keyword
hi def link molStructDeclKeyword        Keyword
hi def link molVectorDeclKeyword        Keyword
hi def link molTableDeclKeyword         Keyword
hi def link molOptionDeclKeyword        Keyword
hi def link molUnionDeclKeyword         Keyword

hi def link molCommentTodo              TODO
hi def link molLineComment              Comment
hi def link molBlockComment             Comment

let b:current_syntax = "molecule"
