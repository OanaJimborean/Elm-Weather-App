"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const fs_1 = __importDefault(require("fs"));
function forecast(req, res) {
    const resp = JSON.parse(fs_1.default.readFileSync("./scripts/data/response.json", { encoding: "utf-8" }));
    res.status(200).json(resp);
}
function main(args) {
    const app = (0, express_1.default)();
    app.use((0, cors_1.default)());
    if (args.slow) {
        app.use((req, res, next) => {
            setTimeout(() => {
                next();
            }, 1000);
        });
    }
    const port = 3000;
    app.get("/v1/forecast", forecast);
    const server = app.listen(port, () => {
        console.log(`Starting server ${port}`);
        if (args.slow) {
            console.log(`Slow mode ON. Delay: 1 second.`);
        }
    });
}
function parseArgs() {
    const args = {
        slow: ["--slow"].includes(process.argv[2]),
    };
    main(args);
}
if (typeof require !== "undefined" && require.main === module) {
    parseArgs();
}
//# sourceMappingURL=weather-server.js.map