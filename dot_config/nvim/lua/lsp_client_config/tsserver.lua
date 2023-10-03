local function table_assign(table_a, table_b)
  local merged = table_a
  for key, value in pairs(table_b) do
    merged[key] = value
  end
  return merged
end

-- @see https://github.com/typescript-language-server/typescript-language-server#initializationoptions
local server_default_preferences = {
  allowIncompleteCompletions = true,
  allowRenameOfImportPath = true,
  allowTextChangesInNewFiles = true,
  displayPartsForJSDoc = true,
  generateReturnInDocTemplate = true,
  includeAutomaticOptionalChainCompletions = true,
  includeCompletionsForImportStatements = true,
  includeCompletionsForModuleExports = true,
  includeCompletionsWithClassMemberSnippets = true,
  includeCompletionsWithObjectLiteralMethodSnippets = true,
  includeCompletionsWithInsertText = true,
  includeCompletionsWithSnippetText = true,
  jsxAttributeCompletionStyle = "auto",
  providePrefixAndSuffixTextForRename = true,
  provideRefactorNotApplicableReason = true,
}

local inlay_hints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

local M = {
  init_options = {
    hostInfo = "neovim",
    preferences = table_assign(server_default_preferences, {
      importModuleSpecifierEnding = "auto",
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
      quotePreference = "auto",
      useLabelDetailsInCompletionEntries = true,
    }),
  },
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
    typesscript = {
      inlayHints = inlay_hints,
    },
    javascript = {
      inlayHints = inlay_hints,
    },
  },
}

return M
