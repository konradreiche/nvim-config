local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

ls.setup({
  update_events = {"TextChanged", "TextChangedI"}
})

local function capitalize(args)
    local input = args[1][1]
    return input:sub(1, 1):upper() .. input:sub(2)
end

local function singular(word)
  return word:sub(1, -2)
end

local function compose(f1, f2)
  return function(args)
    return f1(f2(args))
  end
end

ls.add_snippets("all", {
	s("typeopt", {
    t("type "), i(1, "options"), t({" struct {}", "", ""}),
      t("// "), f(compose(singular, capitalize), {1}), t(" is a functional option for flexible and extensible configuration of "),
      t({"", "// ["}),
      i(2), 
      t("], allowing modification of internal state or behavior during"),
    t({"", "// construction."}),
    t({"", ""}),
    t("type "), f(compose(singular, capitalize), {1}), t(" func(*"), rep(1), t(") error"),
    t({
      "",
      "",
      "// With",
    }),
    f(capitalize, {1}), t(" permits aggregating multiple options together, and is useful to"),
    t({
      "",
      "// avoid having to append options when creating helper functions or wrappers.",
      "func With",
    }),
    f(capitalize, {1}), t("(opts ..."), f(compose(singular, capitalize), {1}), t(") "), f(compose(singular, capitalize), {1}), t(" {"),
    t({
      "",
      "\treturn func(o *"
    }),
    rep(1), t(") error {"),
    t({
      "",
      "\t\tfor _, opt := range opts {",
      "\t\t\tif err := opt(o); err != nil {",
      "\t\t\t\treturn err",
      "\t\t\t}",
      "\t\t}",
      "\t\treturn nil",
      "\t}",
      "}",
    }),
	}),
  s("func With", {
    t("func With"), i(1, ""),
    t({
      "() Option {",
      "\treturn func(o *options) error {",
      "\t\treturn nil",
      "\t}",
      "}",
    }),
  }),
  s("cfg :=", {
    t({
      "cfg := options{}",
      "if err := WithOptions(opts...)(&cfg); err != nil {",
      "\treturn nil, err",
      "}",
    }),
  }),
  s("iferr", {
    t({"if err != nil {", "\t"}),
    t("return err"),
    t({"","}"}),
  }),
  s("iferrr", {
    t({"if err != nil {", "\t"}),
    t("return nil, err"),
    t({"","}"}),
  }),
  s("fatal", {
    t({
      "if err != nil {",
      "\tt.Fatal(err)",
      "}",
    }),
  }),
  s("tests :=", {
    t({
      "tests := []struct {",
      "\tname string",
      "}{",
      "\t{",
      "",
    }),
    t("\t\tname: \""), i(1, ""), t("\""),
    t({
      ",",
      "\t},",
      "}",
      "",
      "for _, tt := range tests {",
      "\tt.Run(tt.name, func(t *testing.T) {",
      "\t\t",
      "\t})",
      "}",
    }),
  }),
})

vim.keymap.set("n", "<leader>ie", function()
  local ls = require("luasnip")
  for _, snippet in ipairs(ls.get_snippets("all")) do
    if snippet.trigger == "iferr" then
      ls.snip_expand(snippet)
      break
    end
  end
end, { desc = "Insert Go error check snippet" })

vim.keymap.set("n", "<leader>iee", function()
  local ls = require("luasnip")
  for _, snippet in ipairs(ls.get_snippets("all")) do
    if snippet.trigger == "iferrr" then
      ls.snip_expand(snippet)
      break
    end
  end
end, { desc = "Insert Go error check snippet with nil result" })
