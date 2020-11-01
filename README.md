Bug
---

Setting a custom `cursorconceal` value in an `after/ftplugin` does not "stick" when a buffer is loaded via `bufadd + bufload`.  Other values from the `ftplugin` are set correctly.

Background information
-----------

In the example configuration, there are two important settings,

1) `concealcursor`

The `init.vim` value is `niv`, meaning all concealed text should remain concealed when the cursor hovers it.

The `after/ftplugin/markdown.vim` value is `` (blank), meaning concealed text should *become* visible when your cursor moves to the line containing concealed text.

2) `showbreak`

The `init.vim` value is `_`, meaning wrapped lines should be prefixed with `_`.

The `after/ftplugin/markdown.vim` value is `*`, meaning wrapped lines should be prefixed with `*`.

Repro details
-------------

You must remove any existing /after configuration files, and add the repos included /after files, when running neovim.

`nvim --cmd "set rtp-=~/.config/nvim/after" --cmd "set rtp+=~/concealcursor-bug.vim/after" -u init.vim`

Now you may press "b" in normal mode. The file `sample.md` will be loaded via `bufadd() and bufload() and nvim_win_set_buf()`.

If you navigate the file, to the indicated line, you will see no concealed characters. Wrapped lines will however, be correctly prefixed with `_`.

If you inspect `:verbose set showbreak?`, you will see it was set via the ftplugin file. If you inspect `:verbose set cursorconceal?` you will see it was last set by the init file. If you inspect `:set ft?`, you will see it is correctly detected as markdown.

Quit vim.

Reopen using the previous command.

Now you may press "n" in normal mode. The file `sample.md` will be loaded via the `:edit` command.`

If you navigate the file, to the indicated line, you *will* have concealed characters revealed to you. Wrapped lines will also be correctly prefixed with `_`.

If you inspect `:verbose set showbreak?`, you will see it was set via the ftplugin file. If you inspect `:verbose set cursorconceal?` you will see it was also set via the ftplugin file.

Note
----

If you press "b" to view the bugged load, then run `set ft=markdown`, the correct concealcursor will be set.
