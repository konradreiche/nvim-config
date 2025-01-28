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

ls.add_snippets("all", {
	s("type opt", {
		t({
      "type options struct {",
      "}",
      "",
      "// Option is a functional option for flexible and extensible configuration of",
      "// ",
    }),
    i(1, ""),
    t({
      ", allowing modification of internal state or behavior during construction.",
      "type Option func(*options) error",
      "",
      "// WithOptions permits aggregating multiple options together, and is useful to",
      "// avoid having to append options when creating helper functions or wrappers.",
      "func WithOptions(opts ...Option) Option {",
      "\treturn func(o *options) error {",
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
})


