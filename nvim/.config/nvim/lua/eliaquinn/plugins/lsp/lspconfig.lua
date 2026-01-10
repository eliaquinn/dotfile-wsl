return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"antosha417/nvim-lsp-file-operations",
		{ "folke/neodev.nvim", opts = {} },
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Verificar se a nova API está disponível
		local use_new_api = vim.fn.has("nvim-0.11") == 1

		if use_new_api then
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Função on_attach para configurar mapeamentos locais
			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "<leader>lwl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
			end

			-- Configuração de diagnósticos
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "󰰀",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			})

			vim.schedule(function()
				-- Terraform LSP
				vim.lsp.config.terraformls = {
					cmd = { "terraform-ls", "serve" },
					filetypes = { "terraform", "terraform-vars" },
					root_markers = { ".terraform", "*.tf", ".git" },
					capabilities = capabilities,
					on_attach = on_attach,
				}

				-- ESLint LSP (diagnósticos + fix)
				vim.lsp.config.eslint = {
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)

						-- auto-fix ao salvar (se o server suportar)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								-- tenta aplicar "fix all" do eslint quando disponível
								pcall(vim.cmd, "EslintFixAll")
							end,
						})
					end,
				}

				-- Lua LSP
				vim.lsp.config.lua_ls = {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = { enable = false },
						},
					},
				}

				vim.lsp.config.ts_ls = {
					capabilities = capabilities,
					on_attach = on_attach,
				}

				vim.lsp.config.pyright = {
					capabilities = capabilities,
					on_attach = on_attach,
				}

				-- Dart LSP
				-- vim.lsp.config.dartls = {
				-- 	cmd = { "dart", "language-server", "--protocol=lsp" },
				-- 	filetypes = { "dart" },
				-- 	root_markers = { "pubspec.yaml", ".git" },
				-- 	capabilities = capabilities,
				-- 	on_attach = on_attach,
				-- 	settings = {
				-- 		dart = {
				-- 			completeFunctionCalls = true,
				-- 			showTodos = true,
				-- 		},
				-- 	},
				-- }

				vim.lsp.enable({ "lua_ls", "ts_ls", "eslint", "terraformls", "yamlls", "pyright" })
			end)
		end
	end,
}
