local map = require("utils").map

map("i", "<a-\\>", "|> ", { desc = "Insert '|>'" })
map("i", "<a-o>", "end<left><left><left><cr><esc><up>o", { desc = "Insert '... end'" })
