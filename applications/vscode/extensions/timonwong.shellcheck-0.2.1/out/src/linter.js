"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const vscode = require("vscode");
const async_1 = require("./utils/async");
var RunTrigger;
(function (RunTrigger) {
    RunTrigger[RunTrigger["onSave"] = 0] = "onSave";
    RunTrigger[RunTrigger["onType"] = 1] = "onType";
})(RunTrigger || (RunTrigger = {}));
(function (RunTrigger) {
    RunTrigger.strings = {
        onSave: 'onSave',
        onType: 'onType'
    };
    RunTrigger.from = function (value) {
        switch (value) {
            case RunTrigger.strings.onSave:
                return RunTrigger.onSave;
            case RunTrigger.strings.onType:
                return RunTrigger.onType;
        }
    };
})(RunTrigger || (RunTrigger = {}));
function escapeRegexp(s) {
    // Shamelessly stolen from https://github.com/atom/underscore-plus/blob/130913c179fe1d718a14034f4818adaf8da4db12/src/underscore-plus.coffee#L138
    return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
}
const NON_WORD_CHARACTERS = escapeRegexp('/\\()"\':,.;<>~!@#$%^&*|+=[]{}`?-…');
const WORD_REGEXP = new RegExp(`^[\t ]*$|[^\\s${NON_WORD_CHARACTERS}]+`);
function asDiagnostic(textDocument, item) {
    let startPos = new vscode.Position(item.line - 1, item.column - 1);
    let range;
    if (item.endLine && item.endColumn) {
        let endPos = new vscode.Position(item.endLine - 1, item.endColumn - 1);
        range = new vscode.Range(startPos, endPos);
    }
    else {
        range = textDocument.getWordRangeAtPosition(startPos);
    }
    if (!range) {
        // Guess word range (code stolen from atom-linter)
        let textLine = textDocument.lineAt(startPos);
        let colEnd = textLine.range.end.character;
        let match = WORD_REGEXP.exec(textLine.text.substr(startPos.character));
        if (match) {
            colEnd = startPos.character + match.index + match[0].length;
        }
        range = new vscode.Range(startPos, startPos.with({ character: colEnd }));
    }
    let severity = asDiagnosticSeverity(item.level);
    let diagnostic = new vscode.Diagnostic(range, `${item.message} [SC${item.code}]`, severity);
    diagnostic.source = 'shellcheck';
    diagnostic.code = item.code;
    return diagnostic;
}
function asDiagnosticSeverity(level) {
    switch (level) {
        case 'error':
            return vscode.DiagnosticSeverity.Error;
        case 'style':
        /* falls through */
        case 'info':
            return vscode.DiagnosticSeverity.Information;
        case 'warning':
        /* falls through */
        default:
            return vscode.DiagnosticSeverity.Warning;
    }
}
class ShellCheckProvider {
    constructor() {
        this.enabled = true;
        this.trigger = null;
        this.executable = null;
        this.executableNotFound = false;
        this.exclude = [];
        this.customArgs = [];
    }
    activate(subscriptions) {
        this.diagnosticCollection = vscode.languages.createDiagnosticCollection();
        subscriptions.push(this);
        vscode.workspace.onDidChangeConfiguration(this.loadConfiguration, this, subscriptions);
        this.loadConfiguration();
        vscode.workspace.onDidOpenTextDocument(this.triggerLint, this, subscriptions);
        vscode.workspace.onDidCloseTextDocument((textDocument) => {
            this.diagnosticCollection.delete(textDocument.uri);
            delete this.delayers[textDocument.uri.toString()];
        }, null, subscriptions);
        // Shellcheck all open shell documents
        vscode.workspace.textDocuments.forEach(this.triggerLint, this);
    }
    dispose() {
        this.disposeDocumentListener();
        this.diagnosticCollection.clear();
        this.diagnosticCollection.dispose();
    }
    disposeDocumentListener() {
        if (this.documentListener) {
            this.documentListener.dispose();
        }
    }
    loadConfiguration() {
        let oldExecutable = this.executable;
        let section = vscode.workspace.getConfiguration('shellcheck');
        if (section) {
            this.enabled = section.get('enable', true);
            this.trigger = RunTrigger.from(section.get('run', RunTrigger.strings.onType));
            this.executable = section.get('executablePath', 'shellcheck');
            this.exclude = section.get('exclude', []);
            this.customArgs = section.get('customArgs', []);
        }
        this.delayers = Object.create(null);
        if (this.executableNotFound) {
            this.executableNotFound = oldExecutable === this.executable;
        }
        this.disposeDocumentListener();
        this.diagnosticCollection.clear();
        if (this.enabled) {
            if (this.trigger === RunTrigger.onType) {
                this.documentListener = vscode.workspace.onDidChangeTextDocument((e) => {
                    this.triggerLint(e.document);
                });
            }
            else if (this.trigger === RunTrigger.onSave) {
                this.documentListener = vscode.workspace.onDidSaveTextDocument(this.triggerLint, this);
            }
        }
        // Configuration has changed. Re-evaluate all documents
        vscode.workspace.textDocuments.forEach(this.triggerLint, this);
    }
    isAllowedTextDocument(textDocument) {
        if (textDocument.languageId !== ShellCheckProvider.languageId) {
            return false;
        }
        const scheme = textDocument.uri.scheme;
        return (scheme === 'file' || scheme === 'untitled');
    }
    triggerLint(textDocument) {
        if (this.executableNotFound || !this.isAllowedTextDocument(textDocument)) {
            return;
        }
        if (!this.enabled) {
            this.diagnosticCollection.delete(textDocument.uri);
            return;
        }
        let key = textDocument.uri.toString();
        let delayer = this.delayers[key];
        if (!delayer) {
            delayer = new async_1.ThrottledDelayer(this.trigger === RunTrigger.onType ? 250 : 0);
            this.delayers[key] = delayer;
        }
        delayer.trigger(() => this.runLint(textDocument));
    }
    runLint(textDocument) {
        return new Promise((resolve, reject) => {
            let executable = this.executable || 'shellcheck';
            let diagnostics = [];
            let processLine = (item) => {
                if (item) {
                    diagnostics.push(asDiagnostic(textDocument, item));
                }
            };
            let options = vscode.workspace.rootPath ? { cwd: vscode.workspace.rootPath } : undefined;
            let args = ['-f', 'json'];
            if (this.exclude.length) {
                args = args.concat(['-e', this.exclude.join(',')]);
            }
            if (this.customArgs.length) {
                args = args.concat(this.customArgs);
            }
            if (this.trigger === RunTrigger.onSave) {
                args.push(textDocument.fileName);
            }
            else {
                args.push('-');
            }
            let childProcess = child_process_1.spawn(executable, args, options);
            childProcess.on('error', (error) => {
                if (this.executableNotFound) {
                    resolve();
                    return;
                }
                this.showError(error, executable);
                this.executableNotFound = true;
                resolve();
            });
            if (childProcess.pid) {
                childProcess.stdout.setEncoding('utf-8');
                if (this.trigger === RunTrigger.onType) {
                    childProcess.stdin.write(textDocument.getText());
                    childProcess.stdin.end();
                }
                let output = [];
                childProcess.stdout
                    .on('data', (data) => {
                    output.push(data.toString());
                })
                    .on('end', () => {
                    if (output.length) {
                        JSON.parse(output.join('')).forEach(processLine);
                    }
                    this.diagnosticCollection.set(textDocument.uri, diagnostics);
                    resolve();
                });
            }
            else {
                resolve();
            }
        });
    }
    showError(error, executable) {
        let message = null;
        if (error.code === 'ENOENT') {
            message = `Cannot shellcheck the shell script. The shellcheck program was not found. Use the 'shellcheck.executablePath' setting to configure the location of 'shellcheck'`;
        }
        else {
            message = error.message ? error.message : `Failed to run shellcheck using path: ${executable}. Reason is unknown.`;
        }
        vscode.window.showInformationMessage(message);
    }
}
ShellCheckProvider.languageId = 'shellscript';
exports.default = ShellCheckProvider;
//# sourceMappingURL=linter.js.map