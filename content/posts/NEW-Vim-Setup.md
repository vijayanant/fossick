+++
type =  "post"
title= "10 Vim Plugins That Made My Vim Easy "
date =   "2015-01-04 09:18:06"
tags = [ "vim", "plugin" ]
categories = ["Tools"]
+++

Few days back I posted the below pic online and some of my friends wanted to know how I got there. I am no vim expert and there are myriad of other (possibly better) ways of doing things. So I will just list the plugins I have used in my setup. 

![my_vim_setup](/my_vim_setup.png)

Note that the side panes (NERDTree on the left and Tagbar on the right) auto-collapse. They magically appear when you summon them and hide themselves when the task is done. 

 Sl | Plugin Name | Description
 ---|-------------|-------------
 1  | [ NERDTree ][ref_nerd_commenter]      | Amazing file system explorer. It presents the filesystem to you in the form of a tree which you manipulate with the keyboard and/or mouse. It also allows you to perform simple filesystem operations.
 2  | [ ctrlp ][ref_ctrlp]                  | It provides an intuitive and fast mechanism to load files from the file system (with regex and fuzzy find), from open buffers, and from recently used files.
 3  | [ Surround ][ref_surround]            | Surround.vim is all about “surroundings”: parentheses, brackets, quotes, XML tags, and more.  The plugin provides mappings to easily delete, change and add such surroundings in pairs.
 4  | [ NERDCommenter ][ref_nerd_commenter] | Allows you to wrangle your code comments, regardless of filetype.
 5  | [ Syntastic ][ref_syntastic]          |  Awesome syntax checking plugin that runs buffers through external syntax checkers as they are saved and opened. If syntax errors are detected, the user is notified and is happy because they didn’t have to compile their code or execute their script to find them.
 6  | [ neocomplcache ][ref_neocomplcache]  |  An amazing autocomplete plugin with additional support for snippets. It can complete simultaneously from the dictionary, buffer, omnicomplete and snippets. This is the one true plugin that brings Vim autocomplete on par with the best editors.
 7  | [ Fugitive ][ref_fugitive]            | Fugitive adds git support to git directories in vim.
 8  | [ Tagbar ][ref_tagbar]                | Another cool plugin that provides an easy way to browse the tags of the current file and get an overview of its structure. It does this by creating a sidebar that displays the ctags-generated tags of the current file, ordered by their scope.
 9  | [ PyMode ][ref_pymode]                | A must have plugin for Python devs. This plugin contains all you need to develop python applications in Vim.
 10 | [ YouCompleteMe ][ref_youcompleteme]  | YouCompleteMe is a fast, as-you-type, fuzzy-search code completion engine for Vim. It has several completion engines: an identifier-based engine that works with every programming language, a semantic, Clang-based engine that provides native semantic code completion for C/C++/Objective-C/Objective-C++ (“the C-family languages”), a Jedi-based completion engine for Python, an OmniSharp-based completion engine for C# and an omnifunc-based completer that uses data from Vim’s omnicomplete system to provide semantic completions for many other languages (Ruby, PHP etc.).

If you know of other good plugins or have some comments please feel free to reach out on twitter or send me an email. Happy coding. 

[ref_tweet]: https://twitter.com/vijayanant/status/550961298700124160/photo/1
[ref_nerd_tree]: https://github.com/scrooloose/nerdtree
[ref_ctrlp]: https://github.com/kien/ctrlp.vim
[ref_surround]: https://github.com/tpope/vim-surround 
[ref_nerd_commenter]: https://github.com/scrooloose/nerdcommenter
[ref_syntastic]: https://github.com/scrooloose/syntastic
[ref_neocomplcache]:https://github.com/Shougo/neocomplcache.vim
[ref_fugitive]: https://github.com/tpope/vim-fugitive
[ref_tagbar]: https://github.com/majutsushi/tagbar
[ref_pymode]: https://github.com/klen/python-mode
[ref_youcompleteme]: https://github.com/Valloric/YouCompleteMe
