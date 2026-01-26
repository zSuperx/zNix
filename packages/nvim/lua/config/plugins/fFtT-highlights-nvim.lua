require('fFtT-highlights'):setup({
  next = "",
  prev = "",
  multi_line = {
    enable = true
  },
  match_highlight = {
    style = "full",
    show_jump_numbers = false,
  },
  backdrop = {
    style = {
      on_key_press = "full",
      show_in_motion = "full",
    },
  },
  jumpable_chars = {
    show_instantly_jumpable = "on_key_press",
    show_multiline_jumpable = "on_key_press",
  },
})
