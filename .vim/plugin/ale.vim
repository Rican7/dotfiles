"
" ALE configuration
"

let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave =  0
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'go': ['go build', 'gofmt', 'golint'],
\   'php': ['php', 'phpcs', 'phpstan'],
\}
let g:ale_php_phpcs_standard = 'PSR2' " Use the PSR-2 standard for PHP Code Sniffer
let g:ale_go_golint_options = '-min_confidence=0.3' " Set a lower minimum confidence than default on `golint`
