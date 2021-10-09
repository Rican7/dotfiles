"
" ALE configuration
"

" Behavior options
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave =  0
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

" Completion
"
" Autocompletion disabled until different LSP issues are solved:
" https://github.com/dense-analysis/ale/issues/3555
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc " Set the omnifunc to use ALE's completion

" Linters
"
" Most languages and their tools are automatically found and enabled, and
" therefore don't need to be configured here.
let g:ale_linters = {
\   'go': ['go build', 'gofmt', 'golint'],
\   'php': ['php', 'phpcs', 'phpstan'],
\}

" Fixers
"
" Fixers are NOT automatically enabled, and therefore need to be manually
" configured for each language here.
"
" Notes:
"  - None for Go, as we'll use vim-go to handle fixing/formatting
let g:ale_fixers = {
\   'go': [],
\   'hack': ['hackfmt'],
\   'typescript': ['deno'],
\   'javascript': ['eslint', 'prettier'],
\   'html': ['prettier'],
\   'css': ['stylelint', 'prettier'],
\   'json': ['jq', 'prettier'],
\   'sh': ['shfmt'],
\   'svelte': ['prettier'],
\}

" Specific options for linters/fixers
let g:ale_php_phpcs_standard = 'PSR2' " Use the PSR-2 standard for PHP Code Sniffer
let g:ale_go_golint_options = '-min_confidence=0.3' " Set a lower minimum confidence than default on `golint`
