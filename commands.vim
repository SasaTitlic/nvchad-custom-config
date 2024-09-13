" XML formatting command
command! XMLFormat call s:XMLFormat()
function! s:XMLFormat()
    %!xmllint --format -
endfunction

" JSON formatting command
command! JSONFormat call s:JSONFormat()
function! s:JSONFormat()
    %!jq '.'
endfunction

" JSON inline formatting command
command! JSONInline call s:JSONInline()
function! s:JSONInline()
    %!jq -c '.'
endfunction

" Wire command
command! Wire call s:Wire()
function! s:Wire()
    !cd %:h; wire
endfunction

" Lint command
command! Lint call s:Lint()
function! s:Lint()
    !cd %:h; golangci-lint run
endfunction
