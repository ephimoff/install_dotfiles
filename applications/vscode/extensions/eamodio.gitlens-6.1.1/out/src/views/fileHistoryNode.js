'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const system_1 = require("../system");
const vscode_1 = require("vscode");
const commitFileNode_1 = require("./commitFileNode");
const explorerNode_1 = require("./explorerNode");
const gitService_1 = require("../gitService");
const logger_1 = require("../logger");
class FileHistoryNode extends explorerNode_1.ExplorerNode {
    constructor(uri, repo, explorer) {
        super(uri);
        this.repo = repo;
        this.explorer = explorer;
    }
    getChildren() {
        return __awaiter(this, void 0, void 0, function* () {
            this.updateSubscription();
            const log = yield this.explorer.git.getLogForFile(this.uri.repoPath, this.uri.fsPath, this.uri.sha);
            if (log === undefined)
                return [new explorerNode_1.MessageNode('No file history')];
            return [...system_1.Iterables.map(log.commits.values(), c => new commitFileNode_1.CommitFileNode(c.fileStatuses[0], c, this.explorer, commitFileNode_1.CommitFileNodeDisplayAs.CommitLabel | commitFileNode_1.CommitFileNodeDisplayAs.StatusIcon))];
        });
    }
    getTreeItem() {
        this.updateSubscription();
        const item = new vscode_1.TreeItem(`${this.uri.getFormattedPath()}`, vscode_1.TreeItemCollapsibleState.Expanded);
        item.contextValue = explorerNode_1.ResourceType.FileHistory;
        item.iconPath = {
            dark: this.explorer.context.asAbsolutePath('images/dark/icon-history.svg'),
            light: this.explorer.context.asAbsolutePath('images/light/icon-history.svg')
        };
        return item;
    }
    updateSubscription() {
        if (this.explorer.autoRefresh) {
            this.disposable = this.disposable || vscode_1.Disposable.from(this.explorer.onDidChangeAutoRefresh(this.onAutoRefreshChanged, this), this.repo.onDidChange(this.onRepoChanged, this));
        }
        else if (this.disposable !== undefined) {
            this.disposable.dispose();
            this.disposable = undefined;
        }
    }
    onAutoRefreshChanged() {
        this.updateSubscription();
    }
    onRepoChanged(e) {
        if (e.changed(gitService_1.RepositoryChange.Stashes, true))
            return;
        logger_1.Logger.log(`RepositoryNode.onRepoChanged(${e.changes.join()}); triggering node refresh`);
        this.explorer.refreshNode(this);
    }
}
exports.FileHistoryNode = FileHistoryNode;
//# sourceMappingURL=fileHistoryNode.js.map