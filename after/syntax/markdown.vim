syntax region ConcealmentBug matchgroup=Goblins excludenl start="\vleft-goblin" skip="\v[\a]+" end="\vright-goblin" concealends
highlight ConcealmentBug cterm=underline gui=underline
highlight clear Conceal
