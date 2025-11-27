; extends

; This makes treesitter parse all contents inside html! { ... } macro invocations as Rust code (instead of the default HTML).
; This means that comments are now correctly normal rust comments! (the commentstring is set based on rust instead of html)
(macro_invocation
  macro: (_) @_macro_name
  (token_tree) @injection.content
  (#match? @_macro_name "html$")
  (#set! injection.language "rust")
  (#set! injection.include-children))
