local M = {}

M.setup = function()
	local copilot = require("CopilotChat")
	copilot.setup({
		prompts = {
			Explain = {
				prompt = "/COPILOT_EXPLAIN 上記のコードを日本語で説明してください",
				mapping = "<leader>ce",
			},
			Review = {
				prompt = "/COPILOT_REVIEW 選択したコードをレビューしてください。レビューコメントは日本語でお願いします。",
				mapping = "<leader>cr",
			},
			Fix = {
				prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
				mapping = "<leader>cf",
			},
			Optimize = {
				prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
				mapping = "<leader>co",
				description = "バディにコードの最適化をお願いする",
			},
			Docs = {
				prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
				mapping = "<leader>cd",
			},
			Tests = {
				prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
				mapping = "<leader>ct",
			},
			FixDiagnostic = {
				prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
				mapping = "<leader>cd",
				selection = require("CopilotChat.select").diagnostics,
			},
			Commit = {
				prompt = "commitize の規則に従って、変更に対するコミットメッセージを記述してください。 タイトルは最大50文字で、メッセージは72文字で折り返されるようにしてください。 メッセージ全体を gitcommit 言語のコード ブロックでラップしてください。メッセージは英語でお願いします。",
				mapping = "<leader>cc",
				selection = require("CopilotChat.select").gitdiff,
			},
			CommitStaged = {
				prompt = "commitize の規則に従って、ステージ済みの変更に対するコミットメッセージを記述してください。 タイトルは最大50文字で、メッセージは72文字で折り返されるようにしてください。 メッセージ全体を gitcommit 言語のコード ブロックでラップしてください。メッセージは英語でお願いします。",
				mapping = "<leader>cs",
				selection = function(source)
					return require("CopilotChat.select").gitdiff(source, true)
				end,
			},
		},
	})
end

return M
