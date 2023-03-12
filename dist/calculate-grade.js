"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const run_tests_1 = require("./run-tests");
const chalk_1 = __importDefault(require("chalk"));
function parseTest(t) {
    if (t.labels[0].includes("VerifyExamples")) {
        let labels = t.labels[0].split(".").slice(0, -1);
        const tagRe = /\{- (?<tag>\w+) -\}/g;
        const res = tagRe.exec(t.labels[1]);
        if (res !== null) {
            const tag = res.groups["tag"];
            labels.push(tag);
        }
        const testDesc = t.labels[1].replace(tagRe, "").replace(/\s+/g, " ");
        var i = testDesc.indexOf(":");
        labels.push(testDesc.slice(0, i).trim(), testDesc.slice(i + 1).trim());
        return Object.assign(Object.assign({}, t), { labels });
    }
    else if (t.labels[0].startsWith("Hidden.")) {
        const labels = [t.labels[0].replace("Hidden.", ""), ...t.labels.slice(1)];
        return Object.assign(Object.assign({}, t), { labels });
    }
    else {
        return t;
    }
}
function genTestTree(labels, prevMap) {
    if (labels.length == 0) {
        throw "Should not happen";
    }
    const current = labels[0];
    const tree = prevMap instanceof Map ? prevMap : typeof prevMap === "number" ? new Map([["", prevMap]]) : new Map();
    const rest = labels.slice(1);
    if (rest.length > 0) {
        const children = genTestTree(rest, tree.get(current));
        tree.set(current, children);
    }
    else {
        tree.set(current, 0);
    }
    return tree;
}
function addToTestTree(map, labels) {
    return genTestTree(labels, map);
}
function lookupWeight(map, label) {
    if (typeof map === "number") {
        return map;
    }
    else {
        if (label.length === 0) {
            throw "Should not happen";
        }
        const submap = map.get(label[0]);
        if (submap === undefined) {
            console.warn(chalk_1.default.red(`Found test with unknown label (tests descriptions should not be changed): ${label}`));
            return 0;
        }
        return lookupWeight(submap, label.slice(1));
    }
}
function deserializeMap(obj) {
    if (typeof obj === "number") {
        return obj;
    }
    let map = new Map();
    for (const key in obj) {
        const element = obj[key];
        const value = deserializeMap(element);
        map.set(key, value);
    }
    return map;
}
function calculateMaxGrade(tree) {
    if (typeof tree === "number") {
        return tree;
    }
    else {
        return [...tree.values()].reduce((a, e) => a + calculateMaxGrade(e), 0);
    }
}
function grade(opts) {
    if (opts.runTests || !fs_1.default.existsSync("./logs/test-logs.ndjson")) {
        console.log("Running tests...");
        const res = (0, run_tests_1.runTest)({ saveJson: true });
        if (res.stderr.length != 0) {
            console.warn(chalk_1.default.red("Can't calculate grade as there were some errors"));
            return {
                result: "err",
                message: "Can't calculate grade as there were some errors",
            };
        }
    }
    const content = fs_1.default.readFileSync("./logs/test-logs.ndjson", "utf-8");
    const lines = content.split("\n");
    const parsed = lines.filter((line) => line.length !== 0).map((line) => JSON.parse(line));
    const runStart = parsed[0];
    const runEnd = parsed[parsed.length - 1];
    const testEvents = parsed.slice(1, -1);
    const tests = testEvents.map(parseTest).filter((t) => !t.labels.some((l) => ["hidden", "ignore"].includes(l)));
    const weights = deserializeMap(JSON.parse(fs_1.default.readFileSync("./scripts/weights.json", { encoding: "utf-8" })));
    const unroundedGrade = tests
        .filter((t) => t.status === "pass")
        .reduce((s, test) => s + lookupWeight(weights, test.labels), 0);
    const maxGrade = Math.ceil(calculateMaxGrade(weights));
    const grade = Math.ceil(unroundedGrade);
    return { result: "ok", maxGrade, grade };
}
function main(args) {
    const result = grade(args);
    if (result.result == "ok") {
        console.log(chalk_1.default.green(`Final grade (for visible, automatic tests): ${result.grade}/${result.maxGrade}`));
    }
}
function parseArgs() {
    const args = {
        runTests: ["-r", "--run-tests"].includes(process.argv[2]),
    };
    main(args);
}
if (typeof require !== "undefined" && require.main === module) {
    parseArgs();
}
//# sourceMappingURL=calculate-grade.js.map