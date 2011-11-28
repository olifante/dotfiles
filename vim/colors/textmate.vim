" Vim color file
" Converted from Textmate theme Mac Classic using Coloration v0.3.2 (http://github.com/sickill/coloration)

"set background=light
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "textmate_mac_classic"


hi Boolean ctermfg=63 ctermbg=NONE cterm=bold guifg=#585cf6 guibg=NONE gui=bold
hi Character ctermfg=160 ctermbg=NONE cterm=bold guifg=#c5060b guibg=NONE gui=bold
hi ColorColumn ctermfg=NONE ctermbg=254 cterm=NONE guifg=NONE guibg=#e6e6e6 gui=NONE
hi Comment ctermfg=27 ctermbg=NONE cterm=NONE guifg=#0066ff guibg=NONE gui=italic
hi Conditional ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi Constant ctermfg=160 ctermbg=NONE cterm=bold guifg=#c5060b guibg=NONE gui=bold
hi Cursor ctermfg=NONE ctermbg=0 cterm=NONE guifg=NONE guibg=#000000 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=254 cterm=NONE guifg=NONE guibg=#e6e6e6 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=254 cterm=NONE guifg=NONE guibg=#e6e6e6 gui=NONE
hi Define ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi Directory ctermfg=160 ctermbg=NONE cterm=bold guifg=#c5060b guibg=NONE gui=bold
hi ErrorMsg ctermfg=15 ctermbg=88 cterm=NONE guifg=#ffffff guibg=#990000 gui=NONE
hi Float ctermfg=20 ctermbg=NONE cterm=NONE guifg=#0000cd guibg=NONE gui=NONE
hi Folded ctermfg=27 ctermbg=15 cterm=NONE guifg=#0066ff guibg=#ffffff gui=NONE
hi Function ctermfg=19 ctermbg=NONE cterm=bold guifg=#0000a2 guibg=NONE gui=bold
hi Identifier ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi IncSearch ctermfg=NONE ctermbg=147 cterm=NONE guifg=NONE guibg=#ababff gui=NONE
hi Keyword ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi Label ctermfg=22 ctermbg=NONE cterm=NONE guifg=#036a07 guibg=NONE gui=NONE
hi LineNr ctermfg=244 ctermbg=254 cterm=NONE guifg=#808080 guibg=#e6e6e6 gui=NONE
hi MatchParen ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi NonText ctermfg=250 ctermbg=231 cterm=NONE guifg=#bfbfbf guibg=#f2f2f2 gui=NONE
hi Normal ctermfg=0 ctermbg=NONE cterm=NONE guifg=#000000 guibg=#ffffff gui=NONE
hi Number ctermfg=20 ctermbg=NONE cterm=NONE guifg=#0000cd guibg=NONE gui=NONE
hi Operator ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=189 cterm=NONE guifg=NONE guibg=#c6deff gui=NONE
hi PreProc ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi Search ctermfg=NONE ctermbg=147 cterm=NONE guifg=NONE guibg=#ababff gui=NONE
hi Special ctermfg=0 ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=NONE
"hi SpecialKey ctermfg=250 ctermbg=254 cterm=NONE guifg=#bfbfbf guibg=#e6e6e6 gui=NONE
hi Statement ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi StatusLine ctermfg=0 ctermbg=249 cterm=bold guifg=#000000 guibg=#b5b5b5 gui=bold
hi StatusLineNC ctermfg=0 ctermbg=249 cterm=NONE guifg=#000000 guibg=#b5b5b5 gui=NONE
hi StorageClass ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
hi String ctermfg=22 ctermbg=NONE cterm=NONE guifg=#036a07 guibg=NONE gui=NONE
hi Tag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Title ctermfg=0 ctermbg=NONE cterm=bold guifg=#000000 guibg=NONE gui=bold
hi Todo ctermfg=27 ctermbg=NONE cterm=inverse,bold guifg=#0066ff guibg=NONE gui=inverse,bold,italic
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi VertSplit ctermfg=249 ctermbg=249 cterm=NONE guifg=#b5b5b5 guibg=#b5b5b5 gui=NONE
hi Visual ctermfg=NONE ctermbg=189 cterm=NONE guifg=NONE guibg=#c6deff gui=NONE
hi WarningMsg ctermfg=15 ctermbg=88 cterm=NONE guifg=#ffffff guibg=#990000 gui=NONE
"hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi cssClassName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi cssColor ctermfg=160 ctermbg=NONE cterm=bold guifg=#c5060b guibg=NONE gui=bold
"hi cssCommonAttr ctermfg=28 ctermbg=NONE cterm=bold guifg=#06960e guibg=NONE gui=bold
"hi cssFunctionName ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi cssPseudoClassId ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi cssURL ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi cssValueLength ctermfg=20 ctermbg=NONE cterm=NONE guifg=#0000cd guibg=NONE gui=NONE
"hi erubyComment ctermfg=27 ctermbg=NONE cterm=NONE guifg=#0066ff guibg=NONE gui=italic
"hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi erubyRailsMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi htmlArg ctermfg=21 ctermbg=NONE cterm=NONE guifg=#1c02ff guibg=NONE gui=NONE
"hi htmlEndTag ctermfg=21 ctermbg=NONE cterm=NONE guifg=#1c02ff guibg=NONE gui=NONE
"hi htmlSpecialChar ctermfg=160 ctermbg=NONE cterm=bold guifg=#c5060b guibg=NONE gui=bold
"hi htmlTag ctermfg=21 ctermbg=NONE cterm=NONE guifg=#1c02ff guibg=NONE gui=NONE
"hi htmlTagName ctermfg=21 ctermbg=NONE cterm=NONE guifg=#1c02ff guibg=NONE gui=NONE
"hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi javaScriptFunction ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
"hi javaScriptRailsFunction ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi rubyClass ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
"hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi rubyConstant ctermfg=68 ctermbg=NONE cterm=bold guifg=#6d79de guibg=NONE gui=bold
"hi rubyControl ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
"hi rubyEscape ctermfg=34 ctermbg=NONE cterm=NONE guifg=#26b31a guibg=NONE gui=NONE
"hi rubyException ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
"hi rubyFunction ctermfg=19 ctermbg=NONE cterm=bold guifg=#0000a2 guibg=NONE gui=bold
"hi rubyGlobalVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
"hi rubyInclude ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
"hi rubyInstanceVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
"hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"hi rubyOperator ctermfg=21 ctermbg=NONE cterm=bold guifg=#0000ff guibg=NONE gui=bold
"hi rubyPseudoVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
"hi rubyRailsARAssociationMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi rubyRailsARMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi rubyRailsMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi rubyRailsRenderMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
"hi rubyRailsUserClass ctermfg=68 ctermbg=NONE cterm=bold guifg=#6d79de guibg=NONE gui=bold
"hi rubyRegexp ctermfg=22 ctermbg=NONE cterm=NONE guifg=#036a07 guibg=NONE gui=NONE
"hi rubyRegexpDelimiter ctermfg=22 ctermbg=NONE cterm=NONE guifg=#036a07 guibg=NONE gui=NONE
"hi rubyStringDelimiter ctermfg=22 ctermbg=NONE cterm=NONE guifg=#036a07 guibg=NONE gui=NONE
"hi rubySymbol ctermfg=160 ctermbg=NONE cterm=bold guifg=#c5060b guibg=NONE gui=bold
"hi yamlAlias ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
"hi yamlAnchor ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
"hi yamlDocumentHeader ctermfg=NONE ctermbg=231 cterm=NONE guifg=NONE guibg=#f2f2f2 gui=NONE
"hi yamlKey ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
